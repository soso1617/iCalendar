//
//  CalendarViewDefinition.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  CalendarViewDefinition
 *
 *********************************************************************/

let kHeaderTitleViewHeight: CGFloat = 20.0

struct CalendarViewDefinition {
    
    static let width = SystemConfiguration.screenSize().width
    static let dayHeight = ceil(SystemConfiguration.screenSize().height / 20.0)
    static let dayWidth = ceil(width / 7.0)
    
    //
    //  day changed notification name
    //
    static let kNotificationNameDayChanged = "kDayChanged"
    
    //
    //  computed days frame for one week, count is 7
    //
    static var daysFrameInWeek: Array<CGRect> = {

        var rectArray: Array<CGRect> = Array()
        
        for index in 0 ..< 7
        {
            let rect = CGRect(x: CGFloat(index) * dayWidth, y: 0, width: dayWidth, height: dayHeight)
            rectArray.append(rect)
        }
        
        return rectArray
    }()
    
    //
    //  computed week view frame for one month, top count is 6
    //
    static var weeksFrameInMonth: Array<CGRect> = {

        var rectArray: Array<CGRect> = Array()
        
        for index in 0 ..< 6
        {
            let rect = CGRect(x: 0, y: CGFloat(index) * dayHeight, width: width, height: dayHeight)
            rectArray.append(rect)
        }
        
        return rectArray
    }()
    
    enum WeekCount: Int {
        case week4 = 4, week5 = 5, week6 = 6
    }
    
    //
    //  computed month view frame
    //
    private static var week4ViewFrame: CGRect = {
        
        return CGRect(x: 0, y: 0, width: width, height: dayHeight * 4)
    }()
    
    private static var week5ViewFrame: CGRect = {
        
        return CGRect(x: 0, y: 0, width: width, height: dayHeight * 5)
    }()
    
    private static var week6ViewFrame: CGRect = {
        
        return CGRect(x: 0, y: 0, width: width, height: dayHeight * 6)
    }()
    
    //
    //  return static month view frame
    //  default is max frame within 6 weeks
    //
    static func monthViewFrame(weeksCount: Int = 6) -> CGRect {
        
        switch weeksCount
        {
            case WeekCount.week4.rawValue:
                return CalendarViewDefinition.week4ViewFrame
            case WeekCount.week5.rawValue:
                return CalendarViewDefinition.week5ViewFrame
            case WeekCount.week6.rawValue:
                fallthrough
            default:
                return CalendarViewDefinition.week6ViewFrame
        }
    }
}
