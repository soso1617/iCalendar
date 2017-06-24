//
//  DayView.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class DayView
 *
 *********************************************************************/

class DayView: UIView {
    
    private var dayNumberLabel = UILabel.init()
    private var eventCircleImageView = UIImageView(image: UIImage.init(named: "eventCircle"))
    weak var delegate: CalendarDelegate?
    var day: Day?
    
    //
    //  is today
    //
    var isToday = false {
        
        didSet
        {
            //
            //  tell delegate the day is today
            //
            if self.isToday
            {
                self.delegate?.todayDayView(dayView: self)
            }
            
            //
            //  if selected or unselected, redraw
            //
            self.setNeedsDisplay()
        }
    }
    
    //
    //  is selected
    //
    var isSelected = false {
        
        didSet
        {
            //
            //  if selected or unselected, redraw
            //
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        if self.isSelected
        {
            let context = UIGraphicsGetCurrentContext()
            
            //
            //  change text color with new background color
            //
            self.dayNumberLabel.textColor = UIColor.icWhite
            self.dayNumberLabel.font = UIFont.icFont2
            
            //
            //  remove circle image view
            //
            self.eventCircleImageView.removeFromSuperview()
            
            //
            //  draw background round rect
            //
            let path = UIBezierPath.init(arcCenter: CGPoint.init(x: rect.width / 2, y: rect.height / 2), radius: ceil(min(rect.width, rect.height) / 2.5), startAngle: 0, endAngle: 360.degreesToFRadians, clockwise: false).cgPath
            context?.addPath(path)
            context?.setFillColor(UIColor.dayColor.cgColor)
            context?.fillPath()
        }
        //
        //  check status to different text color
        //
        else
        {
            if self.isToday
            {
                self.dayNumberLabel.textColor = UIColor.todayColor
                self.dayNumberLabel.font = UIFont.icFont6
            }
            else
            {
                self.dayNumberLabel.textColor = UIColor.icTextColor
                self.dayNumberLabel.font = UIFont.icFont2
            }
            
            //
            //  add circle image view if have event
            //
            if self.day?.events?.count ?? 0 > 0
            {
                self.addSubview(self.eventCircleImageView)
            }
            else
            {
                //
                //  remove circle image view
                //
                self.eventCircleImageView.removeFromSuperview()
            }
        }
    }
    
    /**
     
     Init DayView by day obj
     
     - Parameter day:       day obj
     - Parameter frame:     day view frame
     - Parameter delegate:  calendar delegate for dayView
     
     - Returns: DayView obj
     
     */
    init(day: Day, frame: CGRect, delegate: CalendarDelegate?) {
        
        self.day = day
        self.delegate = delegate
        self.isToday = day.isToday
        self.isSelected = day.isSelected
        
        super.init(frame: frame)
        
        //
        //  tell delegate the day is today
        //
        if self.isToday
        {
            self.delegate?.todayDayView(dayView: self)
        }
        
        //
        //  tell delegate the day is today
        //
        if self.isSelected
        {
            self.delegate?.selectedDay(day: day, dayView: self)
        }
        
        self.backgroundColor = UIColor.icWhite
        
        //
        //  add self's tap gesture
        //
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.tapped))
        self.addGestureRecognizer(gesture)
        
        //
        //  set text label
        //
        self.dayNumberLabel.font = UIFont.icFont2
        self.dayNumberLabel.text = String(day.valueInMonth)
        self.dayNumberLabel.sizeToFit()
        self.dayNumberLabel.frame = CGRect(x: (self.bounds.size.width - self.dayNumberLabel.bounds.size.width) / 2, y: (self.bounds.size.height - self.dayNumberLabel.bounds.size.height) / 2, width: self.dayNumberLabel.bounds.size.width, height: self.dayNumberLabel.bounds.size.height)
        self.dayNumberLabel.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        self.addSubview(self.dayNumberLabel)
        
        //
        //  add circle image view
        //
        let circleSide: CGFloat = 4.0
        let bottomMargin: CGFloat = 0.5
        
        self.eventCircleImageView.frame = CGRect(x: (self.bounds.size.width - circleSide) / 2, y: self.bounds.size.height - circleSide - bottomMargin * 2 - 1, width: circleSide, height: circleSide)
        
        let bottomMarginView = UIView.init(frame: CGRect(x: 0, y: self.bounds.height - bottomMargin, width: self.bounds.width, height: bottomMargin))
        bottomMarginView.backgroundColor = UIColor.icLightGray
        self.addSubview(bottomMarginView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    //
    //  tap gesture method
    //
    @objc private func tapped() {
        
        if !self.isSelected
        {
            self.isSelected = true
            
            //
            //  tell delegate the day is selected
            //
            self.delegate?.selectedDay(day: self.day!, dayView: self)
        }
    }
}
