//
//  CalendarViewProtocol.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/2/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation

/*********************************************************************
 *
 *  protocol CalendarDelegate
 *
 *********************************************************************/

protocol CalendarDelegate: NSObjectProtocol {
 
    //
    //  tell delegate that day is selected
    //
    func selectedDay(day: Day, dayView: DayView)
    
    //
    //  tell delegate which dayView is for today's day obj
    //
    func todayDayView(dayView: DayView)
    
    //
    //  tell delegate current month is changed in month scroll view
    //
    func currentMonthChanged(changToMonth: Month)
}
