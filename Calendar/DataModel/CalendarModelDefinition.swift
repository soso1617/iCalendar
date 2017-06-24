//
//  CalendarModelDefinition.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/29/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation

enum WeekDay: Int16
{    
    case Sunday = 1, Monday = 2, Tuesday = 3, Wednesday = 4, Thursday = 5, Friday = 6, Saturday = 7
}

struct EntityName {
    
    static let year = "Year"
    static let month = "Month"
    static let week = "Week"
    static let day = "Day"
    static let event = "Event"
}

struct YearProperties {
    
    static let value = "value"
    static let primaryKey = "id"
}

struct MonthProperties {
    
    static let value = "valueInYear"
    static let primaryKey = "id"
    static let name = "name"
}

struct WeekProperties {
    
    static let value = "valueInYear"
    static let primaryKey = "id"
}

struct DayProperties {
    
    static let primaryKey = "id"
    static let nameInWeek = "nameInWeek"
    static let valueInWeek = "valueInWeek"
    static let valueInMonth = "valueInMonth"
    static let date = "date"
}

//
//  normally this properties key should be same as JSON data from server
//
struct EventProperties {
    
    static let primaryKey = "id"
    static let type = "type"
    static let attendees = "attendees"
    static let startDate = "startDate"
    static let endDate = "endDate"
    static let location = "location"
    static let shortDesc = "shortDesc"
    static let duration = "duration"
}

@inline(never) func dayId(year: Int, month: Int, day: Int) -> Int32 {
    
    return Int32(year * 10000 + month * 100 + day)
}

@inline(never) func weekId(year: Int, weekInYear: Int) -> Int32 {
    
    return Int32(year * 100 + weekInYear)
}

@inline(never) func monthId(year: Int, month: Int) -> Int32 {
    
    return Int32(year * 100 + month)
}
