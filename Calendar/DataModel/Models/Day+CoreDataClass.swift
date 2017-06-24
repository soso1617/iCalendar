//
//  Day+CoreDataClass.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/27/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation
import CoreData

@objc(Day)
public class Day: NSManagedObject {

    var isToday = false
    var isSelected = false
    
    //
    //  return sorted events by start date
    //
    func sortedEvents() -> Array<Event>? {
        
        let sortDesc = NSSortDescriptor.init(key: "startDate", ascending: true)
        
        return self.events?.sortedArray(using: [sortDesc]) as? Array<Event>
    }
}
