//
//  HabitContainer.swift
//  happyt
//
//  Created by Max Saienko on 10/1/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

struct HabitContainer {
    private let labelOffset: CGFloat = 10
    private let labelHeight: CGFloat = 20
    
    var view: UIView
    
    init(frame: CGRect, habit: Habit) {
        let habitContainer = UIView(frame: frame)
        habitContainer.backgroundColor = UIColor.greenColor()
        habitContainer.layer.cornerRadius = 20
        habitContainer.layer.borderWidth = 1
        
        let nameLabel = UILabel(frame: CGRectMake(labelOffset, labelOffset, frame.width, labelHeight))
        nameLabel.text = habit.name
        habitContainer.addSubview(nameLabel)
        
        self.view = habitContainer
    }
}
