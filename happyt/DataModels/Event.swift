//
//  Event.swift
//  happyt
//
//  Created by Max Saienko on 9/30/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//
import CoreData

class Event: NSManagedObject {
    @NSManaged var date: NSDate
    @NSManaged var isPositive: NSNumber
    
    // Core Data - relational property
    @NSManaged var habit: Habit?
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(isPositive: Bool, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.date = NSDate()
        self.isPositive = isPositive
    }
    
    init(date: NSDate, isPositive: Bool, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.date = date
        self.isPositive = isPositive
    }
}
