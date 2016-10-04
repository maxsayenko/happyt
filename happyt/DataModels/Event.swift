//
//  Event.swift
//  happyt
//
//  Created by Max Saienko on 9/30/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

struct Event {
    var habitId: String
    var date: NSDate
    var isPositive: Bool
    
    init(habitId id: String, isPositive: Bool) {
        self.date = NSDate()
        self.habitId = id
        self.isPositive = isPositive
    }
    
    init(habitId id: String, date: NSDate, isPositive: Bool) {
        self.date = date
        self.habitId = id
        self.isPositive = isPositive
    }
}
