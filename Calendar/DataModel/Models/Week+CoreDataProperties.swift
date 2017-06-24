//
//  Week+CoreDataProperties.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation
import CoreData


extension Week {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Week> {
        return NSFetchRequest<Week>(entityName: "Week")
    }

    @NSManaged public var id: Int32
    @NSManaged public var valueInYear: Int16
    @NSManaged public var belongMonths: NSOrderedSet?
    @NSManaged public var days: NSOrderedSet?
    @NSManaged public var nextWeek: Week?
    @NSManaged public var previousWeek: Week?
    @NSManaged public var belongYear: Year?

}

// MARK: Generated accessors for belongMonths
extension Week {

    @objc(insertObject:inBelongMonthsAtIndex:)
    @NSManaged public func insertIntoBelongMonths(_ value: Month, at idx: Int)

    @objc(removeObjectFromBelongMonthsAtIndex:)
    @NSManaged public func removeFromBelongMonths(at idx: Int)

    @objc(insertBelongMonths:atIndexes:)
    @NSManaged public func insertIntoBelongMonths(_ values: [Month], at indexes: NSIndexSet)

    @objc(removeBelongMonthsAtIndexes:)
    @NSManaged public func removeFromBelongMonths(at indexes: NSIndexSet)

    @objc(replaceObjectInBelongMonthsAtIndex:withObject:)
    @NSManaged public func replaceBelongMonths(at idx: Int, with value: Month)

    @objc(replaceBelongMonthsAtIndexes:withBelongMonths:)
    @NSManaged public func replaceBelongMonths(at indexes: NSIndexSet, with values: [Month])

    @objc(addBelongMonthsObject:)
    @NSManaged public func addToBelongMonths(_ value: Month)

    @objc(removeBelongMonthsObject:)
    @NSManaged public func removeFromBelongMonths(_ value: Month)

    @objc(addBelongMonths:)
    @NSManaged public func addToBelongMonths(_ values: NSOrderedSet)

    @objc(removeBelongMonths:)
    @NSManaged public func removeFromBelongMonths(_ values: NSOrderedSet)

}

// MARK: Generated accessors for days
extension Week {

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
