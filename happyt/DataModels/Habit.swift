//
//  Habit.swift
//  happyt
//
//  Created by Max Saienko on 9/19/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

struct Habit {
    var id: String
    var name: String
    var hasPlusButton: Bool = false
    var hasMinusButton: Bool = false
    
    init(name: String, hasPlusButton: Bool, hasMinusButton: Bool) {
        self.name = name
        self.hasPlusButton = hasPlusButton
        self.hasMinusButton = hasMinusButton
        self.id = NSUUID().UUIDString
    }
}