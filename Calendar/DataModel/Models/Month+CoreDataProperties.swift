//
//  Month+CoreDataProperties.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation
import CoreData


extension Month {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Month> {
        return NSFetchRequest<Month>(entityName: "Month")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var valueInYear: Int16
    @NSManaged public var days: NSOrderedSet?
    @NSManaged public var belongYear: Year?
    @NSManaged public var weeks: NSOrderedSet?
    @NSManaged public var nextMonth: Month?
    @NSManaged public var previousMonth: Month?

}

// MARK: Generated accessors for days
extension Month {

    @objc(insertObject:inDaysAtIndex:)
    @NSManaged public func insertIntoDays(_ value: Day, at idx: Int)

    @objc(removeObjectFromDaysAtIndex:)
    @NSManaged public func removeFromDays(at idx: Int)

    @objc(insertDays:atIndexes:)
    @NSManaged public func insertIntoDays(_ values: [Day], at indexes: NSIndexSet)

    @objc(removeDaysAtIndexes:)
    @NSManaged public func removeFromDays(at indexes: NSIndexSet)

    @objc(replaceObjectInDaysAtIndex:withObject:)
    @NSManaged public func replaceDays(at idx: Int, with value: Day)

    @objc(replaceDaysAtIndexes:withDays:)
    @NSManaged public func replaceDays(at indexes: NSIndexSet, with values: [Day])

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: Day)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: Day)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSOrderedSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSOrderedSet)

}

// MARK: Generated accessors for weeks
extension Month {

    @objc(insertObject:inWeeksAtIndex:)
    @NSManaged public func insertIntoWeeks(_ value: Week, at idx: Int)

    @objc(removeObjectFromWeeksAtIndex:)
    @NSManaged public func removeFromWeeks(at idx: Int)

    @objc(insertWeeks:atIndexes:)
    @NSManaged public func insertIntoWeeks(_ values: [Week], at indexes: NSIndexSet)

    @objc(removeWeeksAtIndexes:)
    @NSManaged public func removeFromWeeks(at indexes: NSIndexSet)

    @objc(replaceObjectInWeeksAtIndex:withObject:)
    @NSManaged public func replaceWeeks(at idx: Int, with value: Week)

    @objc(replaceWeeksAtIndexes:withWeeks:)
    @NSManaged public func replaceWeeks(at indexes: NSIndexSet, with values: [Week])

    @objc(addWeeksObject:)
    @NSManaged public func addToWeeks(_ value: Week)

    @objc(removeWeeksObject:)
    @NSManaged public func removeFromWeeks(_ value: Week)

    @objc(addWeeks:)
    @NSManaged public func addToWeeks(_ values: NSOrderedSet)

    @objc(removeWeeks:)
    @NSManaged public func removeFromWeeks(_ values: NSOrderedSet)

}
