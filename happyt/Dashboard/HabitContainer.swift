//
//  HabitContainer.swift
//  happyt
//
//  Created by Max Saienko on 10/1/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//
import SwiftCharts

struct HabitContainer {
    private let labelOffset: CGFloat = 10
    private let labelHeight: CGFloat = 20
    
    var view: UIView
    var chart: Chart
    
    init(frame: CGRect, habit: Habit, type: ChartType) {
        let habitContainerView = UIView(frame: frame)
        habitContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        habitContainerView.backgroundColor = UIColor.greenColor()
        habitContainerView.layer.cornerRadius = 20
        habitContainerView.layer.borderWidth = 1
        
        // Label
        let nameLabel = UILabel(frame: CGRectMake(labelOffset, labelOffset, frame.width, labelHeight))
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
