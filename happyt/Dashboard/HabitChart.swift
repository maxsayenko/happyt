//
//  HabitChart.swift
//  happyt
//
//  Created by Max Saienko on 10/5/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import SwiftCharts

class HabitChart {
    let view: ChartView
    let chart: Chart
    
    init(view: ChartView, chart: Chart) {
        self.view = view
        self.chart = chart
    }
}