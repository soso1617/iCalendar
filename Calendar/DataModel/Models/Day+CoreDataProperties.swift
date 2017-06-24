//
//  Day+CoreDataProperties.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var nameInWeek: String?
    @NSManaged public var valueInMonth: Int16
    @NSManaged public var valueInWeek: Int16
    @NSManaged public var events: NSSet?
    @NSManaged public var belongMonth: Month?
    @NSManaged public var belongWeek: Week?
    @NSManaged public var nextDay: Day?
    @NSManaged public var previousDay: Day?

}

// MARK: Generated accessors for events
extension Day {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: Event)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: Event)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}
