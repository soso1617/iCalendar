//
//  MonthManager.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/30/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation

/*********************************************************************
 *
 *  class MonthManager -- Singleton
 *  This class is responsible for controlling the core data model: Month
 *
 *********************************************************************/

class MonthManager {
    
    // MARK: Singleton init
    
    //
    //  singleton instance
    //
    static let sharedManager = MonthManager()
    
    //
    //  prevent be init from others
    //
    private init() {
        
    }
    
    /**
     
     Create Month by Month data dict, will check core data if this object already exsit
     
     - Parameter dict: Month data, must contain primary key value
     
     - Returns: Month obj
     
     */
    func createMonthBy(dict: [String : Any]) -> Month? {
        
        var retMonth: Month? = nil
        
        //
        //  make sure the primary key exists
        //
        if let primaryValue = dict[MonthProperties.primaryKey] as? Int32
        {
            //
            //  try to fetch the month obj if exist
            //
            if let month = self.fetchMonthByKeyValue(primaryValue)
            {
                retMonth = month
                
                //
                //  set properties value if it's contained in dict
                //
                if let value = dict[MonthProperties.value] as? Int16
                {
                    retMonth?.valueInYear = value
                }
                
                if let name = dict[MonthProperties.name] as? String
                {
                    retMonth?.name = name
                }
            }
            else
            {
                retMonth = CalendarModelManager.sharedManager.createObj(entityName: EntityName.month) as? Month
                
                //
                //  set properties value if it's contained in dict
                //
                retMonth?.id = Int32(primaryValue)
                
                if let value = dict[MonthProperties.value] as? Int16
                {
                    retMonth?.valueInYear = value
                }
                
                if let name = dict[MonthProperties.name] as? String
                {
                    retMonth?.name = name
                }
            }
        }
        
        return retMonth
    }
    
    /**
     
     Fetch Month by Month id
     
     - Parameter value: Month id
     
     - Returns: Specified Month obj
     
     */
    func fetchMonthByKeyValue(_ value: Int32) -> Month? {
        
        var retMonth: Month? = nil
        
        let predicate = NSPredicate.init(format: "%K = %ld", MonthProperties.primaryKey, value)
        
        if let fetchedResult = CalendarModelManager.sharedManager.fetchObj(entityName: EntityName.month, predicate: predicate) as? Array<Month>, fetchedResult.count > 0
        {
            retMonth = fetchedResult.last
        }
        
        return retMonth
    }
    
    /**
     
     Fetch this month obj
     
     - Returns: This Month obj
     
     */
    func thisMonth() -> Month? {
        
        let calendar = Calendar.init(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.month, .year], from: Date())
        
        return self.fetchMonthByKeyValue(monthId(year: dateComponents.year!, month: dateComponents.month!))
    }
    
    /**
     
     Return month count
     
     - Returns: Months count
     
     */
    func allMonthCount() -> Int {
        
        return 12 * UserDefaults.standard.integer(forKey: kUserDefaultDBYears)
    }
    
    /**
     
     Return month index from all months, start from 1
     
     - Parameter month: Month obj
     
     - Returns: This Month index
     
     */
    func monthIndexInAll(_ month: Month) -> Int {
        
        var retIndex = -1
        let startYear = UserDefaults.standard.integer(forKey: kUserDefaultFromYear)
        
        if let year = month.belongYear?.value
        {
            let intervalYears = Int(year) - startYear
            
            retIndex = intervalYears * 12 + Int(month.valueInYear)
        }
        
        return retIndex
    }
    
    /**
     
     Return month from all months in DB by month Index, start from 1
     
     - Parameter monthIndex: Month index in all month
     
     - Returns: Specified Month obj
     
     */
    func monthAtIndex(_ monthIndex: Int) -> Month? {
        
        let startYear = UserDefaults.standard.integer(forKey: kUserDefaultFromYear)
        let year = Int(monthIndex / 12)
        let month = monthIndex % 12 + 1
        
        return self.fetchMonthByKeyValue(monthId(year: startYear + year, month: month))
    }
}
