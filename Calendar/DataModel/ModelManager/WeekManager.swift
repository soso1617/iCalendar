//
//  WeekManager.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation

/*********************************************************************
 *
 *  class WeekManager -- Singleton
 *  This class is responsible for controlling the core data model: Week
 *
 *********************************************************************/

class WeekManager {
    
    // MARK: Singleton init
    
    //
    //  singleton instance
    //
    static let sharedManager = WeekManager()
    
    //
    //  prevent be init from others
    //
    private init() {
        
    }
    
    /**
     
     Create Week by Week data dict, will check core data if this object already exsit
     
     - Parameter dict: Week data, must contain primary key value
     
     - Returns: Week obj
     
     */
    func createWeekBy(dict: [String : Any]) -> Week? {
        
        var retWeek: Week? = nil
        
        //
        //  make sure the primary key exists
        //
        if let primaryValue = dict[WeekProperties.primaryKey] as? Int32
        {
            //
            //  try to fetch the week obj if exist
            //
            if let week = self.fetchWeekByKeyValue(primaryValue)
            {
                retWeek = week
                
                //
                //  set properties value if it's contained in dict
                //
                if let value = dict[WeekProperties.value] as? Int16
                {
                    retWeek?.valueInYear = value
                }
            }
            else
            {
                retWeek = CalendarModelManager.sharedManager.createObj(entityName: EntityName.week) as? Week
                
                //
                //  set properties value if it's contained in dict
                //
                retWeek?.id = Int32(primaryValue)
                
                if let value = dict[WeekProperties.value] as? Int16
                {
                    retWeek?.valueInYear = value
                }
            }
        }
        
        return retWeek
    }
    
    /**
     
     Fetch Week by Week id
     
     - Parameter value: Week id
     
     - Returns: Specified Week obj
     
     */
    func fetchWeekByKeyValue(_ value: Int32) -> Week? {
        
        var retWeek: Week? = nil
        
        let predicate = NSPredicate.init(format: "%K = %ld", WeekProperties.primaryKey, value)
        
        if let fetchedResult = CalendarModelManager.sharedManager.fetchObj(entityName: EntityName.week, predicate: predicate) as? Array<Week>, fetchedResult.count > 0
        {
            retWeek = fetchedResult.last
        }
        
        return retWeek
    }
    
    /**
     
     Fetch this week obj
     
     - Returns: This Week obj
     
     */
    func thisWeek() -> Week? {
        
        let calendar = Calendar.init(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        
        return self.fetchWeekByKeyValue(weekId(year: dateComponents.yearForWeekOfYear!, weekInYear: dateComponents.weekOfYear!))
    }
}
