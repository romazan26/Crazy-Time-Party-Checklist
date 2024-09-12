//
//  SpinFortune+CoreDataProperties.swift
//
//
//  Created by Роман on 12.09.2024.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc(SpinFortune)
public class SpinFortune: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpinFortune> {
        return NSFetchRequest<SpinFortune>(entityName: "SpinFortune")
    }

    @NSManaged public var backGround: UIImage?
    @NSManaged public var spin: UIImage?
    @NSManaged public var nameGame: String?
    @NSManaged public var wheelColor: UIImage?
    @NSManaged public var task: NSSet?
    @NSManaged public var tag: Int16
    @NSManaged public var color: UIImage?

}

// MARK: Generated accessors for tesk
extension SpinFortune {

    @objc(addTaskObject:)
    @NSManaged public func addToTask(_ value: Task)

    @objc(removeTaskObject:)
    @NSManaged public func removeFromTask(_ value: Task)

    @objc(addTask:)
    @NSManaged public func addToTask(_ values: NSSet)

    @objc(removeTask:)
    @NSManaged public func removeFromTask(_ values: NSSet)

}

extension SpinFortune : Identifiable {

}
