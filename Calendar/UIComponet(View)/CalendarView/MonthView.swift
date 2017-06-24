//
//  MonthView.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  Class MonthView
 *
 *********************************************************************/

class MonthView: UIView {
    
    var month: Month?
    var weeksView: Array<WeekView>?
    private var monthNameLabel = UILabel.init()
    private var dayViewDictionay: Dictionary <Int32, DayView>?  // use harsh table to store day view, thus we could search day view by dayID quickly

    /**
     
     Init MonthView by day obj
     
     - Parameter month:     month obj
     - Parameter frame:     month view frame
     - Parameter delegate:  calendar delegate for dayView
     
     - Returns: MonthView obj
     
     */
    init(month: Month, frame: CGRect, delegate: CalendarDelegate?) {
        
        self.month = month
        self.weeksView = Array()
        self.dayViewDictionay = Dictionary()
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.icWhite
        
        //
        //  create weeks view by weeks array
        //
        if let weeks = month.weeks?.array as? Array<Week>
        {
            //
            //  because week don't have index within month, so just use index in array
            //
            for (index, week) in weeks.enumerated()
            {
                let weekView = WeekView.init(week: week, inMonth: self.month, frame: CalendarViewDefinition.weeksFrameInMonth[index], delegate: delegate)
                weekView.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
                
                //
                //  store day view
                //
                for dayView in weekView.daysView!
                {
                    self.dayViewDictionay?[dayView.day!.id] = dayView
                }
                
                self.weeksView?.append(weekView)
                self.addSubview(weekView)
            }
        }
        
        //
        //  add month title
        //
        let intervalX: CGFloat = 20.0
        self.monthNameLabel.text = String.init(format: "%@ %d", self.month?.name ?? "", self.month?.belongYear?.value ?? 0)
        self.monthNameLabel.font = UIFont.icFont5
        self.monthNameLabel.textColor = UIColor.icGreen
        self.monthNameLabel.sizeToFit()
        self.monthNameLabel.frame = CGRect(x: self.bounds.width - self.monthNameLabel.bounds.width - intervalX, y: CalendarViewDefinition.monthViewFrame(weeksCount: 5).height + (CalendarViewDefinition.dayHeight - self.monthNameLabel.bounds.height) / 2, width: self.monthNameLabel.bounds.width, height: self.monthNameLabel.bounds.height)
        self.addSubview(self.monthNameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    /**
     
     Refresh the specified day view by day id, mostly for today
     
     - Returns: None
     
     */
    func refreshTodayBy(id: Int32) {
        
        if let todayView = self.dayViewDictionay?[id]
        {
            todayView.isToday = true
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
