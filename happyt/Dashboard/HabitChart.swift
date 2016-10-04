//
//  Chart.swift
//  happyt
//
//  Created by Max Saienko on 10/1/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import SwiftCharts

struct HabitChart {
    let view: ChartView
    let chart: Chart
    
    init(frame: CGRect, habit: Habit) {
        let chartFrame = CGRectMake(10, 40, frame.width - 20, frame.height - 45)
        
        var coordinates: [(Int, Int)] = []
        var yValue = 0
        var minY = 0
        var maxY = 1
        for event in habit.events {
            let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: event.date)
            let multiplier = event.isPositive ? 1 : -1
            yValue += 1 * multiplier
            
            if (yValue > maxY) {
                maxY = yValue
            } else if (yValue < minY) {
                minY = yValue
            }
            
            coordinates.append((hour, yValue))
        }

        //let chartPoints: [ChartPoint] = [(2, 2), (4, -4), (6, 6), (8, 10), (12, 9)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
        
        let chartPoints: [ChartPoint] = coordinates.map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
        
        // Axis values
        let xValues = 0.stride(through: 24, by: 3).map {ChartAxisValueInt($0)}
        let yValues = (minY).stride(through: maxY, by: 1).map {ChartAxisValueInt($0)}
        
        let labelSettings = ChartLabelSettings(font: UIFont.systemFontOfSize(14))
        
        // create axis models with axis values and axis title
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Time", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Count", settings: labelSettings.defaultVertical()))
        
        let chartSettings = ChartSettings()
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.labelsToAxisSpacingX = 3
        chartSettings.top = 10
        chartSettings.trailing = 10
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        // create layer with line
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor(red: 0.4, green: 0.4, blue: 1, alpha: 0.2), lineWidth: 3, animDuration: 0.7, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
        
        // create layer with base line
        let baseLinePoints: [ChartPoint] = [(0, 0), (24, 0)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
        let baseLineModel = ChartLineModel(chartPoints: baseLinePoints, lineColor: UIColor.blueColor(), lineWidth: 3, animDuration: 0, animDelay: 0)
        let baseLineChartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [baseLineModel])
        
        // create layer with guidelines
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: 1.0)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                chartPointsLineLayer,
                baseLineChartPointsLineLayer
            ]
        )
        
        self.chart = chart
        self.view = chart.view
    }
}
