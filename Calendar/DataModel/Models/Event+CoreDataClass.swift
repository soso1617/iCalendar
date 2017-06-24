//
//  Event+CoreDataClass.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/27/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSManagedObject {
    
    //
    //  return displayed start time, should check is in current date
    //
    func displayStartTime(inDate: Date) -> String? {
        
        var retStartTime: String? = nil
        
        if let date = self.startDate as Date?
        {
            if DateConversion.compare2DateIsSame(date, comparedDate: inDate)
            {
                retStartTime = DateConversion.date2MMSSFromDate(date)
            }
            else
            {
                retStartTime = "Day_Before".localized
            }
        }
        
        return retStartTime
    }
    
    //
    //  return displayed end time, should check is in current date
    //
    func displayEndTime(inDate: Date) -> String? {
        
        var retEndTime: String? = nil
        
        if let date = self.endDate as Date?
        {
            if DateConversion.compare2DateIsSame(date, comparedDate: inDate)
            {
                retEndTime = DateConversion.date2MMSSFromDate(date)
            }
            else
            {
                retEndTime = "Day_After".localized
            }
        }
        
        return retEndTime
    }
    
    //
    //  return event status
    //
    func status() -> EventStatus {
        
        return EventManager.sharedManager.eventStatus(self)
    }
}
