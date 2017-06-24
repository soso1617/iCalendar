//
//  DayMananger.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/30/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation

/*********************************************************************
 *
 *  class DayManager -- Singleton
 *  This class is responsible for controlling the core data model: Day
 *
 *********************************************************************/

class DayManager {
    
    // MARK: Singleton init
    
    //
    //  singleton instance
    //
    static let sharedManager = DayManager()
    
    //
    //  prevent be init from others
    //
    private init() {
        
    }
    
    /**
     
     Create Day by Day data dict, will check core data if this object already exsit
     
     - Parameter dict: Day data, must contain primary key value
     
     - Returns: Day obj
     
     */
    func createDayBy(dict: [String : Any]) -> Day? {
        
        var retDay: Day? = nil
        
        //
        //  make sure the primary key exists
        //
        if let primaryValue = dict[DayProperties.primaryKey] as? Int32
        {
            //
            //  try to fetch the day obj if exist
            //
            if let day = self.fetchDayByKeyValue(primaryValue)
            {
                retDay = day
                
                //
                //  set properties value if it's contained in dict
                //
                if let valueInWeek = dict[DayProperties.valueInWeek] as? Int16
                {
                    retDay?.valueInWeek = valueInWeek
                }
                
                if let valueInMonth = dict[DayProperties.valueInMonth] as? Int16
                {
                    retDay?.valueInMonth = valueInMonth
                }
                
                if let nameInWeek = dict[DayProperties.nameInWeek] as? String
                {
                    retDay?.nameInWeek = nameInWeek
                }
                
                if let date = dict[DayProperties.date] as? NSDate
                {
                    retDay?.date = date
                }
            }
            else
            {
                retDay = CalendarModelManager.sharedManager.createObj(entityName: EntityName.day) as? Day
                
                //
                //  set property value if it's contained in dict
                //
                retDay?.id = Int32(primaryValue)
                
                if let valueInWeek = dict[DayProperties.valueInWeek] as? Int16
                {
                    retDay?.valueInWeek = valueInWeek
                }
                
                if let valueInMonth = dict[DayProperties.valueInMonth] as? Int16
                {
                    retDay?.valueInMonth = valueInMonth
                }
                
                if let nameInWeek = dict[DayProperties.nameInWeek] as? String
                {
                    retDay?.nameInWeek = nameInWeek
                }
                
                if let date = dict[DayProperties.date] as? NSDate
                {
                    retDay?.date = date
                }
            }
        }
        
        return retDay
    }
    
    /**
     
     Fetch Day by Day id
     
     - Parameter value: Day id
     
     - Returns: Specified Day obj
     
     */
    func fetchDayByKeyValue(_ value: Int32) -> Day? {
        
        var retDay: Day? = nil
        
        let predicate = NSPredicate.init(format: "%K = %ld", DayProperties.primaryKey, value)
        
        if let fetchedResult = CalendarModelManager.sharedManager.fetchObj(entityName: EntityName.day, predicate: predicate) as? Array<Day>, fetchedResult.count > 0
        {
            retDay = fetchedResult.last
        }
        
        return retDay
    }
    
    /**
     
     Fetch today's Day obj
     
     - Returns: Today Day obj
     
     */
    func today() -> Day? {
        
        let calendar = Calendar.init(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        
        if let today = self.fetchDayByKeyValue(dayId(year: dateComponents.year!, month: dateComponents.month!, day: dateComponents.day!))
        {
            //
            //  set is-today
            //
            today.isToday = true
            return today
        }
        
        return nil
    }
}
