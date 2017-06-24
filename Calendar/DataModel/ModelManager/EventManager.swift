//
//  EventManager.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/6/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation

/*********************************************************************
 *
 *  class EventManager -- Singleton
 *  This class is responsible for controlling the core data model: Event
 *
 *********************************************************************/

enum EventStatus: Int16
{
    case AtNow, NotStarted, Passed, `Default`
}

enum EventType: String
{
    case Meeting = "Meeting", Call = "Call", Outdoor = "Outdoor"
}

class EventManager {
    
    // MARK: Singleton init
    
    private var calendar: Calendar

    //
    //  singleton instance
    //
    static let sharedManager = EventManager()
    
    //
    //  prevent be init from others
    //
    private init() {
        
        self.calendar = Calendar.init(identifier: .gregorian)
        self.calendar.timeZone = TimeZone.current
    }
    
    /**
     
     Create Even by Event data dict, will check core data if this object already exsit
     
     - Parameter dict: Event data, must contain primary key value
     
     - Returns: Event obj
     
     */
    func createEventBy(dict: [String : Any]) -> Event? {
        
        var retEvent: Event? = nil
        
        //
        //  make sure the primary key exists
        //
        if let primaryValue = dict[EventProperties.primaryKey] as? Int32
        {
            //
            //  try to fetch the day obj if exist
            //
            if let event = self.fetchEventByKeyValue(primaryValue)
            {
                retEvent = event
                
                //
                //  set properties value if it's contained in dict
                //
                if let type = dict[EventProperties.type] as? String
                {
                    retEvent?.type = type
                }
                
                //
                //  suppose date from sever is string
                //
                if let startDateString = dict[EventProperties.startDate] as? String
                {
                    retEvent?.startDate = DateConversion.dateFromISO8601String(startDateString) as NSDate?
                }
                
                //
                //  suppose date from sever is string
                //
                if let endDateString = dict[EventProperties.endDate] as? String
                {
                    retEvent?.endDate = DateConversion.dateFromISO8601String(endDateString) as NSDate?
                }
                
                if let location = dict[EventProperties.location] as? String
                {
                    retEvent?.locationDesc = location
                }
                
                if let attendees = dict[EventProperties.attendees] as? String
                {
                    retEvent?.attendeesName = attendees
                }
                
                if let shortDesc = dict[EventProperties.shortDesc] as? String
                {
                    retEvent?.shortDesc = shortDesc
                }
                
                //
                //  add event to it belongs days
                //
                self.addEventInDays(retEvent!)
            }
            else
            {
                retEvent = CalendarModelManager.sharedManager.createObj(entityName: EntityName.event) as? Event
                
                //
                //  set property value if it's contained in dict
                //
                retEvent?.id = Int32(primaryValue)
                
                if let type = dict[EventProperties.type] as? String
                {
                    retEvent?.type = type
                }
                
                //
                //  suppose date from sever is string
                //
                if let startDateString = dict[EventProperties.startDate] as? String
                {
                    retEvent?.startDate = DateConversion.dateFromISO8601String(startDateString) as NSDate?
                }
                
                //
                //  suppose date from sever is string
                //
                if let endDateString = dict[EventProperties.endDate] as? String
                {
                    retEvent?.endDate = DateConversion.dateFromISO8601String(endDateString) as NSDate?
                }
                
                if let location = dict[EventProperties.location] as? String
                {
                    retEvent?.locationDesc = location
                }
                
                if let attendees = dict[EventProperties.attendees] as? String
                {
                    retEvent?.attendeesName = attendees
                }
                
                if let shortDesc = dict[EventProperties.shortDesc] as? String
                {
                    retEvent?.shortDesc = shortDesc
                }
                
                //
                //  add event to it belongs days
                //
                self.addEventInDays(retEvent!)
            }
        }
        
        return retEvent
    }
    
    /**
     
     Fetch Event by Event id
     
     - Parameter value: Event id
     
     - Returns: Specified Event obj
     
     */
    func fetchEventByKeyValue(_ value: Int32) -> Event? {
        
        var retEvent: Event? = nil
        
        let predicate = NSPredicate.init(format: "%K = %ld", EventProperties.primaryKey, value)
        
        if let fetchedResult = CalendarModelManager.sharedManager.fetchObj(entityName: EntityName.event, predicate: predicate) as? Array<Event>, fetchedResult.count > 0
        {
            retEvent = fetchedResult.last
        }
        
        return retEvent
    }
    
    /**
     
     Return event stauts
     
     - Parameter event: Event id
     
     - Returns: event status by current date
     
     */
    func eventStatus(_ event: Event) -> EventStatus {
        
        var retStatus = EventStatus.Default
        
        //
        //  I don't think this is a good performace way, but I really don't have time to do comparasion
        //
        if let startDate = event.startDate as Date?, let endDate = event.endDate as Date?
        {
            let currentDate = Date()
            let array = [startDate, endDate, currentDate]
            let index = array.sorted().index(of: currentDate)
            
            switch index as Int!
            {
                case 0:
                    retStatus = .NotStarted
                case 1:
                    retStatus = .AtNow
                case 2:
                    retStatus = .Passed
                default:
                    retStatus = .Default
            }
        }
        
        return retStatus
    }
    
    //
    //  add event to it belongs days
    //
    private func addEventInDays(_ event: Event) {
        
        if let startDate = event.startDate as Date?, let endDate = event.endDate as Date?
        {
            var startDateComponents = self.calendar.dateComponents([.year, .month, .day, .timeZone, .minute, .hour, .second], from: startDate)
            let intervalDateComponents = self.calendar.dateComponents([.year, .month, .day, .timeZone, .minute, .hour], from: startDate, to: endDate)
            let days = intervalDateComponents.day
            
            //
            //  calculate duration
            //
            if days! > 0 || intervalDateComponents.hour! > 0
            {
                event.duration = String.init(format: "Duration_H".localized, days! * 24 + intervalDateComponents.hour!) + String.init(format: "Duration_M".localized, intervalDateComponents.minute!)
            }
            else
            {
                event.duration = String.init(format: "Duration_M".localized, intervalDateComponents.minute!)
            }
            
            for _ in 0 ... (days ?? 0)
            {
                if let date = self.calendar.date(from: startDateComponents)
                {
                    let newDateComponents = self.calendar.dateComponents([.year, .month, .day], from: date)
                    
                    if let day = DayManager.sharedManager.fetchDayByKeyValue(dayId(year: newDateComponents.year!, month: newDateComponents.month!, day: newDateComponents.day!))
                    {
                        event.addToInDays(day)
                    }
                }
                
                startDateComponents.day! += 1
            }
        }
    }
    
    #if DEBUG
    
    //
    //  create temp event for testing
    //
    func createTempEventData() {
        
        if let path = Bundle.main.path(forResource: "Events", ofType: "plist"), let dictionaryArray = Array<Any>.initFromFilePath(path) as? [Dictionary<String, Any>]
        {
            for dictionary in dictionaryArray
            {
                _ = self.createEventBy(dict: dictionary)
            }
            
            CalendarModelManager.sharedManager.saveCoreData()
        }
    }
    #endif
}
