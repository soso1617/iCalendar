//
//  YearManager.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/29/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation

/*********************************************************************
 *
 *  class YearManager -- Singleton
 *  This class is responsible for controlling the core data model: Year
 *
 *********************************************************************/

class YearManager {
    
    // MARK: Singleton init
    
    //
    //  singleton instance
    //
    static let sharedManager = YearManager()
    
    //
    //  prevent be init from others
    //
    private init() {
        
    }
    
    /**
     
     Create Year by Year data dict, will check core data if this object already exsit
     
     - Parameter dict: Year data, must contain primary key value
     
     - Returns: Year obj
     
     */
    func createYearBy(dict: [String : Any]) -> Year? {
        
        var retYear: Year? = nil
        
        //
        //  make sure the primary key exists
        //
        if let primaryValue = dict[YearProperties.primaryKey] as? Int16
        {
            //
            //  try to fetch the year obj if exist
            //
            if let year = self.fetchYearByKeyValue(primaryValue)
            {
                retYear = year
                
                //
                //  set properties value if it's contained in dict
                //
                if let value = dict[YearProperties.value] as? Int16
                {
                    retYear?.value = value
                }
            }
            else
            {
                retYear = CalendarModelManager.sharedManager.createObj(entityName: EntityName.year) as? Year
                
                //
                //  set properties value if it's contained in dict
                //
                retYear?.id = Int16(primaryValue)
                
                if let value = dict[YearProperties.value] as? Int16
                {
                    retYear?.value = value
                }
            }
        }
        
        return retYear
    }
    
    /**
     
     Fetch Year by year id
     
     - Parameter value: year id
     
     - Returns: Specified Year obj
     
     */
    func fetchYearByKeyValue(_ value: Int16) -> Year? {
        
        var retYear: Year? = nil
        
        let predicate = NSPredicate.init(format: "%K = %ld", YearProperties.primaryKey, value)
        
        if let fetchedResult = CalendarModelManager.sharedManager.fetchObj(entityName: EntityName.year, predicate: predicate) as? Array<Year>, fetchedResult.count > 0
        {
            retYear = fetchedResult.last
        }
        
        return retYear
    }
    
    /**
     
     Fetch this year obj
     
     - Returns: This Year obj
     
     */
    func thisYear() -> Year? {
        
        let calendar = Calendar.init(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.year], from: Date())
        
        return self.fetchYearByKeyValue(Int16(dateComponents.year!))
    }
}
