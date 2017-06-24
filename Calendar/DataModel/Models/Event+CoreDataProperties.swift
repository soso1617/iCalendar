//
//  Event+CoreDataProperties.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/6/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var attendeesName: String?
    @NSManaged public var duration: String?
    @NSManaged public var endDate: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var locationDesc: String?
    @NSManaged public var shortDesc: String?
    @NSManaged public var startDate: NSDate?
    @NSManaged public var type: String?
    @NSManaged public var inDays: NSSet?

}

// MARK: Generated accessors for inDays
extension Event {

    @objc(addInDaysObject:)
    @NSManaged public func addToInDays(_ value: Day)

    @objc(removeInDaysObject:)
    @NSManaged public func removeFromInDays(_ value: Day)

    @objc(addInDays:)
    @NSManaged public func addToInDays(_ values: NSSet)

    @objc(removeInDays:)
    @NSManaged public func removeFromInDays(_ values: NSSet)

}
