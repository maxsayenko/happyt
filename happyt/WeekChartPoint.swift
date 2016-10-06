//
//  WeekChartPoint.swift
//  happyt
//
//  Created by Max Saienko on 10/5/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

struct WeekChartPoint {
    let type: WeekDayType
    var value: Int
    var events: [Event]
    
    init(type: WeekDayType) {
        self.type = type
        value = 0
        events = []
    }
}
