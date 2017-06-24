//
//  WeekView.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class WeekView
 *
 *********************************************************************/

class WeekView: UIView {
    
    var week: Week?
    var daysView: Array<DayView>?

    /**
     
     Init WeekView by week obj, if inMonth is exist, then will filter the weekday not be included in this month
     
     - Parameter week:      week obj
     - Parameter inMonth:   month obj, filter the weekday if not be included in the month, if create month view, you could pass this ojc, if create week view only, you don't need to have inMonth.
     - Parameter frame:     week view frame
     - Parameter delegate:  calendar delegate for dayView
     
     - Returns: WeekView obj
     
     */
    init(week: Week, inMonth: Month? = nil, frame: CGRect, delegate: CalendarDelegate?) {
        
        self.week = week
        self.daysView = Array()
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.icWhite
        
        //
        //  create days view by days array
        //
        if let days = week.days?.array as? Array<Day>
        {
            for day in days
            {
                if nil == inMonth || day.belongMonth == inMonth
                {
                    let dayView = DayView.init(day: day, frame: CalendarViewDefinition.daysFrameInWeek[Int(day.valueInWeek - 1)], delegate: delegate)
                    dayView.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
                    
                    self.daysView?.append(dayView)
                    self.addSubview(dayView)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
    // Drawing code
    }
    */
}
