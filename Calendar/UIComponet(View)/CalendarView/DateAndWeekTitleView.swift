//
//  DateAndWeekTitleView.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/3/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  Class DateAndWeekTitleView
 *
 *********************************************************************/

enum TitleStyle
{
    case `default`, dark, light
}

class DateAndWeekTitleView: UIView {
    
    var day: Day? {
        
        didSet
        {
            //
            //  if day changed, reset month label's text
            //
            if let day = self.day
            {
                self.monthLabel.text = String.init(format: "%@ %d", day.belongMonth?.name ?? "", day.belongMonth?.belongYear?.value ?? 0)
            }
        }
    }

    private(set) var style: TitleStyle = .default
    
    private var monthLabel: UILabel = UILabel.init()
    private var weekDayTitleView: UIView = UIView.init()
    private let titleViewHeight: CGFloat = 20.0
    private let dateFormatter = DateFormatter()
    
    init(day: Day, frame: CGRect, style: TitleStyle) {
        
        self.day = day
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.icGrayishBlue
        self.weekDayTitleView.frame = CGRect(x: 0, y: frame.size.height - titleViewHeight, width: frame.size.width, height: titleViewHeight)
        self.weekDayTitleView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        self.weekDayTitleView.backgroundColor = UIColor.clear
        self.addSubview(self.weekDayTitleView)
        
        let weekDayLabelWidth = self.weekDayTitleView.frame.width / 7.0
        
        //
        //  create each weekday label
        //
        for weekDay in 1...7
        {
            let label = UILabel.init()
            label.text = String.init(format: "Week_Day_%d_Short", weekDay).localized
            label.font = UIFont.icFont3
            label.textColor = weekDay == 1 || weekDay == 7 ? UIColor.icBlackishGreen : self.textColor()
            label.textAlignment = .center
            label.frame = CGRect(x: weekDayLabelWidth * CGFloat(weekDay - 1), y: 0, width: weekDayLabelWidth, height: self.weekDayTitleView.frame.height)
            label.backgroundColor = UIColor.clear
            self.weekDayTitleView.addSubview(label)
        }
        
        self.monthLabel.textColor = self.textColor()
        self.monthLabel.font = UIFont.icFont2
        self.monthLabel.text = String.init(format: "%@ %d", day.belongMonth?.name ?? "", day.belongMonth?.belongYear?.value ?? 0)
        self.monthLabel.textAlignment = .center
        self.monthLabel.sizeToFit()
        self.monthLabel.backgroundColor = UIColor.clear
        self.monthLabel.frame = CGRect(x: 0, y: self.weekDayTitleView.frame.origin.y - self.monthLabel.frame.height, width: self.frame.width, height: self.monthLabel.frame.height)
        self.monthLabel.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        self.addSubview(self.monthLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    private func textColor() -> UIColor {
    
        switch self.style
        {
            case .dark:
                return UIColor.black
            case .light:
                fallthrough
            case .default:
                return UIColor.icWhite
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
