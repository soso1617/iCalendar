//
//  DateConversion.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/6/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation

class DateConversion {
    
    //
    //  lazy init
    //
    static var calender: Calendar = { return Calendar.init(identifier: .gregorian) }()
    
    //
    //  lazy init
    //
    static var timeZoneDateFormatter: DateFormatter = {
        
        let retDateFormatter = DateFormatter.init()
        
        //
        //  init dateformatter for global
        //
        retDateFormatter.timeStyle = .long
        retDateFormatter.dateStyle = .short
        
        //
        //  use current timezone for display
        //
        retDateFormatter.timeZone = TimeZone.current
        
        return retDateFormatter
    }()
    
    //
    //  lazy init
    //
    static var ISO8601DateFormatter: DateFormatter = {
        
        let retDateFormatter = DateFormatter.init()
        retDateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        retDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        
        return retDateFormatter
    }()
    
    //
    //  lazy init
    //
    static var HHMMDateFormatter: DateFormatter = {
        
        let retDateFormatter = DateFormatter.init()
        retDateFormatter.locale = Locale.current
        retDateFormatter.timeZone = TimeZone.current
        retDateFormatter.dateFormat = "HH:mm"
        
        return retDateFormatter
    }()
    
    //
    //  lazy init
    //
    static var LongDateFormatter: DateFormatter = {
        
        let retDateFormatter = DateFormatter.init()
        retDateFormatter.locale = Locale.current
        retDateFormatter.timeZone = TimeZone.current
        retDateFormatter.timeStyle = .none
        retDateFormatter.dateStyle = .long
        
        return retDateFormatter
    }()
    
    //
    //  convert kind formatter of "2016-11-30T09:20:30+08:00" to date
    //
    class func dateFromISO8601String(_ dateString: String) -> Date? {
        
        return ISO8601DateFormatter.date(from: dateString)
    }
    
    //
    //  convert timestamp to date string
    //
    class func dateStringWithSystemSpecifiedTimeZoneFromTimeStamp(_ timeStamp: Double) -> String {
        
        return timeZoneDateFormatter.string(from: Date.init(timeIntervalSince1970: timeStamp))
    }
    
    //
    //  convert date to date string
    //
    class func dateStringWithSystemSpecifiedTimeZoneFromDate(_ date: Date) -> String {
        
        return timeZoneDateFormatter.string(from: date)
    }
    
    //
    //  convert date to "HH:MM"
    //
    class func date2MMSSFromDate(_ date: Date) -> String {
        
        return HHMMDateFormatter.string(from: date)
    }
    
    //
    //  convert date to long date string
    //
    class func date2LongStringFromDate(_ date: Date) -> String {
        
        return LongDateFormatter.string(from: date)
    }
    
    //
    //  check to date is in same day
    //
    class func compare2DateIsSame(_ date: Date, comparedDate: Date) -> Bool {
    
        let component1 = self.calender.dateComponents([.year, .month, .day], from: date)
        let component2 = self.calender.dateComponents([.year, .month, .day], from: comparedDate)
        
        return ((component1.day! == component2.day!) && (component1.month! == component2.month!) && (component1.year! == component2.year!))
    }
}
