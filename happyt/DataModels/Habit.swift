//
//  Habit.swift
//  happyt
//
//  Created by Max Saienko on 9/19/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//
import CoreData

class Habit: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var hasPlusButton: Bool
    @NSManaged var hasMinusButton: Bool
    // Core Data - relational property
    @NSManaged var events: NSOrderedSet
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(name: String, hasPlusButton: Bool, hasMinusButton: Bool, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        
        let entity = NSEntityDescription.entityForName("Habit", inManagedObjectContext: context!)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.hasPlusButton = hasPlusButton
        self.hasMinusButton = hasMinusButton
        self.id = NSUUID().UUIDString
    }
    
//    init(name: String, hasPlusButton: Bool, hasMinusButton: Bool) {
//        self.name = name
//        self.hasPlusButton = hasPlusButton
//        self.hasMinusButton = hasMinusButton
//        self.id = NSUUID().UUIDString
//    }
}