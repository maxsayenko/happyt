//
//  HabitContainer.swift
//  happyt
//
//  Created by Max Saienko on 10/1/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//
import SwiftCharts

struct HabitContainer {
    private let labelOffsetX: CGFloat = 40
    private let labelOffsetY: CGFloat = 10
    private let labelHeight: CGFloat = 20
    
    var view: UIView
    var chart: Chart
    
    init(frame: CGRect, habit: Habit, type: ChartType) {
        let habitContainerView = UIView(frame: frame)
        habitContainerView.translatesAutoresizingMaskIntoConstraints = false
        //habitContainerView.alpha = 0.6
        habitContainerView.backgroundColor = UIColor.grayColor()
        habitContainerView.layer.cornerRadius = 20
        //habitContainerView.layer.borderWidth = 1
        
        // Label
        let nameLabel = UILabel(frame: CGRectMake(labelOffsetX, labelOffsetY, frame.width, labelHeight))
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.text = habit.name
        habitContainerView.addSubview(nameLabel)
        
        // Chart
        var chart: HabitChart?
        if(type == ChartType.Day) {
            chart = DayChart(frame: habitContainerView.frame, habit: habit)
        } else {
            chart = WeekChart(frame: habitContainerView.frame, habit: habit)
        }

        self.chart = chart!.chart
        habitContainerView.addSubview(chart!.view)
        
        self.view = habitContainerView
    }
}
