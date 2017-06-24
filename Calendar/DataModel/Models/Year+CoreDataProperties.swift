//
//  Year+CoreDataProperties.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation
import CoreData


extension Year {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Year> {
        return NSFetchRequest<Year>(entityName: "Year")
    }

    @NSManaged public var id: Int16
    @NSManaged public var value: Int16
    @NSManaged public var months: NSOrderedSet?
    @NSManaged public var nextYear: Year?
    @NSManaged public var previousYear: Year?
    @NSManaged public var weeks: NSOrderedSet?

}

// MARK: Generated accessors for months
extension Year {

    @objc(insertObject:inMonthsAtIndex:)
    @NSManaged public func insertIntoMonths(_ value: Month, at idx: Int)

    @objc(removeObjectFromMonthsAtIndex:)
    @NSManaged public func removeFromMonths(at idx: Int)

    @objc(insertMonths:atIndexes:)
    @NSManaged public func insertIntoMonths(_ values: [Month], at indexes: NSIndexSet)

    @objc(removeMonthsAtIndexes:)
    @NSManaged public func removeFromMonths(at indexes: NSIndexSet)

    @objc(replaceObjectInMonthsAtIndex:withObject:)
    @NSManaged public func replaceMonths(at idx: Int, with value: Month)

    @objc(replaceMonthsAtIndexes:withMonths:)
    @NSManaged public func replaceMonths(at indexes: NSIndexSet, with values: [Month])

    @objc(addMonthsObject:)
    @NSManaged public func addToMonths(_ value: Month)

    @objc(removeMonthsObject:)
    @NSManaged public func removeFromMonths(_ value: Month)

    @objc(addMonths:)
    @NSManaged public func addToMonths(_ values: NSOrderedSet)

    @objc(removeMonths:)
    @NSManaged public func removeFromMonths(_ values: NSOrderedSet)

}

// MARK: Generated accessors for weeks
extension Year {

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
