//
//  Date.swift
//  happyt
//
//  Created by Max Saienko on 10/3/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

extension NSDate {
    var startOfDay: NSDate {
        return NSCalendar.currentCalendar().startOfDayForDate(self)
    }
    
    var endOfDay: NSDate? {
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())
    }
    
    func getString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE',' dd MMMM HH:mm:ss"
        return dateFormatter.stringFromDate(self)
    }
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        var isGreater = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isGreater = true
        }
        
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        var isLess = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
            isLess = true
        }
        
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        var isEqualTo = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame {
            isEqualTo = true
        }
        
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        return dateWithDaysAdded
    }
}
