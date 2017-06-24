//
//  CoreDataInitialization.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/27/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation
import CoreData

/*********************************************************************
 *
 *  class CalendarCoreDataInitializer
 *  Use this class to create static calender data in core data,
 *  Don't need to involve this class in release build
 *
 *********************************************************************/

class CalendarCoreDataInitializer {
    
    private static let calendar = Calendar.init(identifier: .gregorian)
    private static let dateFormatter = DateFormatter.init()
    
    //
    //  for store previous day usage
    //
    private static var previousDay: Day? = nil
    
    //
    //  for store previous week usage
    //
    private static var previousWeek: Week? = nil
    
    //
    //  for store previous month usage
    //
    private static var previousMonth: Month? = nil
    
    //
    //  for store previous year usage
    //
    private static var previousYear: Year? = nil
    
    /**
     
     Create calendar data in core data by years. For example, if you pass 10 years here, will create calender between "10 past years" + current year + "10 future years"
     
     - Parameter years:  Interval years
     
     - Returns: none
     
     */
    class func initializeCalendar(years: Int, completion: ((Bool) -> Void)?) -> Bool {
        
        //
        //  return bool value
        //
        var bRet = false

        if let currentYear = calendar.dateComponents([.year], from: Date()).year, currentYear > years
        {
            bRet = self.initializeCalendar(fromYear: currentYear - years, toYear: currentYear + years, completion: completion)
        }
        
        return bRet
    }
    
    /**
     
     Create calendar data in core data by fromYear to toYear   
     
     - Parameter fromYear:  from year
     - Parameter toYear:    to year
     
     - Returns: none
     
     */
    class func initializeCalendar(fromYear: Int, toYear: Int, completion: ((Bool) -> Void)?) -> Bool {
        
        //
        //  Acutally this method is just for testing, because we can use bulit-in calendar data rather than init when first run
        //
        
        CalendarModelManager.sharedManager.clearDB()
        
        #if DEBUG
            /* test initialization time */
            debugPrint("Initializing db")
            debugPrint("Test \(toYear - fromYear + 1) years initialization time Start")
            let timeStart = Date().timeIntervalSince1970
        #endif
        
        //
        //  return bool value
        //
        var bRet = false
        
        if toYear >= fromYear
        {
            //
            //  create calendar year by year
            //
            for year in fromYear ... toYear
            {
                if let yearObj = YearManager.sharedManager.createYearBy(dict: [YearProperties.primaryKey : Int16(year), YearProperties.value : Int16(year)])
                {
                    //
                    //  set previous year
                    //
                    yearObj.previousYear = previousYear
                    previousYear = yearObj
                    
                    //
                    //  create calendar for this year
                    //
                    self.createDataForYear(year, inYear: yearObj)
                }
            }
            
            //
            //  create some test data
            //
            #if DEBUG
                EventManager.sharedManager.createTempEventData()
            #endif
            
            //
            //  store all in coredata
            //
            CalendarModelManager.sharedManager.saveCoreData(completion: completion)
            
            bRet = true
        }
        
        #if DEBUG
            /* test initialization time */
            let timeEnd = Date().timeIntervalSince1970
            debugPrint("Test \(toYear - fromYear + 1) years initialization time End, total: \(timeEnd - timeStart) seconds")
        #endif
        
        return bRet
    }
    
    /**
     
     Create months and days objects for the specified year in core data
     
     - Parameter year:  the year value
     - Parameter yearObj:  the Year object
     
     - Returns: none
     
     */
    private class func createDataForYear(_ year: Int, inYear yearObj: Year) {
        
        var loopDateComponent = DateComponents()
        loopDateComponent.calendar = calendar
        loopDateComponent.year = year

        //
        //  loop full 12 months
        //
        for month in 1 ... 12
        {
            loopDateComponent.month = month
            loopDateComponent.day = 1
            loopDateComponent.weekOfMonth = 1
            
            //
            //  create month object
            //
            if let monthObj = MonthManager.sharedManager.createMonthBy(dict: [MonthProperties.primaryKey : monthId(year: year, month: month)])
            {
                monthObj.valueInYear = Int16(month)
                monthObj.name = dateFormatter.monthSymbols[month - 1]
                monthObj.belongYear = yearObj
                
                //
                //  set previous month
                //
                monthObj.previousMonth = previousMonth
                previousMonth = monthObj
                
                if let monthDate = loopDateComponent.date, let weekRange = calendar.range(of: .weekOfMonth, in: .month, for: monthDate)
                {
                    //
                    // create countable range for for loop
                    //
                    let countableWeekRange = CountableRange(weekRange)
                    var startDay = 1
                    
                    for week in countableWeekRange
                    {
                        loopDateComponent.weekOfMonth = week
                        loopDateComponent.day = startDay
                        
                        if let weekDate = loopDateComponent.date
                        {
                            //
                            //  get the week index in current year
                            //
                            let weekComponent = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: weekDate)
                            
                            /*********************************************************************************************************
                             !!!Important:
                             2012.12.30 the weekOfYear will come to next year, == 1
                             So we get yearForWeekOfYear, will be 2013, to confirm the week's id
                             **********************************************************************************************************/
                            
                            //
                            //  create month object
                            //
                            if let weekObj = WeekManager.sharedManager.createWeekBy(dict: [WeekProperties.primaryKey : weekId(year: weekComponent.yearForWeekOfYear!, weekInYear: weekComponent.weekOfYear!)])
                            {
                                weekObj.valueInYear = Int16(weekComponent.weekOfYear!)
                                weekObj.addToBelongMonths(monthObj)
                                weekObj.belongYear = yearObj
                                
                                //
                                //  because we may get same weekObj twice if this week belongs to 2 months
                                //
                                if weekObj != previousWeek
                                {
                                    //
                                    //  set previous week
                                    //
                                    weekObj.previousWeek = previousWeek
                                    previousWeek = weekObj
                                }
                                
                                if let range = calendar.range(of: .day, in: .weekOfMonth, for: weekDate)
                                {
                                    //
                                    //  for next week loop
                                    //
                                    debugPrint(range)
                                    startDay = range.upperBound
                                    
                                    //
                                    // create countable range for for loop
                                    //
                                    let countableRange = CountableRange(range)
                                    
                                    //
                                    //  loop all days in this week
                                    //
                                    for day in countableRange
                                    {
                                        loopDateComponent.day = day
                                        
                                        if let dayDate = loopDateComponent.date
                                        {
                                            //
                                            //  get the day index in current week
                                            //
                                            let dayComponent = calendar.dateComponents([.weekday], from: dayDate)
                                            
                                            //
                                            //  create day object
                                            //
                                            if let dayObj = DayManager.sharedManager.createDayBy(dict: [DayProperties.primaryKey : dayId(year: year, month: month, day: day)])
                                            {
                                                //
                                                //  year won't exceed range of int16
                                                //
                                                dayObj.valueInWeek = Int16(dayComponent.weekday!)
                                                dayObj.valueInMonth = Int16(day)
                                                dayObj.nameInWeek = dateFormatter.weekdaySymbols[dayComponent.weekday! - 1]
                                                dayObj.date = dayDate as NSDate // not sure this is needed, and the date is GMT+0, so if day is 20150101, the date is 20141231 16:00
                                                dayObj.belongWeek = weekObj
                                                dayObj.belongMonth = monthObj
                                                
                                                //
                                                //  set previous day
                                                //
                                                dayObj.previousDay = previousDay
                                                previousDay = dayObj
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
