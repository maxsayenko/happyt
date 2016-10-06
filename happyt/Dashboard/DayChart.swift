//
//  Chart.swift
//  happyt
//
//  Created by Max Saienko on 10/1/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import SwiftCharts

class DayChart: HabitChart {
    init(frame: CGRect, habit: Habit) {
        let chartFrame = CGRectMake(10, 35, frame.width - 20, frame.height - 45)
        
        let chartSettings = ChartSettings()
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.labelsToAxisSpacingX = 3
        chartSettings.top = 10
        chartSettings.trailing = 10
        
        let labelSettings = ChartLabelSettings(font: UIFont.systemFontOfSize(14), fontColor: UIColor.whiteColor(), rotation: 0, rotationKeep: .Center, shiftXOnRotation: true, textAlignment: .Default)
        
        let guidelinesColor = UIColor.whiteColor()
        let lineColor = UIColor(red: 0, green: 161, blue: 216, alpha: 1)
        let baselineColor = UIColor.yellowColor()
        
        var coordinates: [(Int, Int)] = [(0, 0)]
        var yValue = 0
        var minY = 0
        var maxY = 1
        
        let today = NSDate()
        let unitFlags: NSCalendarUnit = [.Minute, .Hour, .Day, .Month, .Year]
        
        // Today's events
        let filteredEvents = habit.events.filter() { event in
            return event.date.isGreaterThanDate(today.startOfDay) && event.date.isLessThanDate(today)
        }
        
        for event in filteredEvents as! [Event] {
            let dateComponents = NSCalendar.currentCalendar().components(unitFlags, fromDate: event.date)
            let hour = dateComponents.hour
            let multiplier = event.isPositive == 1 ? 1 : -1
            yValue += 1 * multiplier
            
            if (yValue > maxY) {
                maxY = yValue
            } else if (yValue < minY) {
                minY = yValue
            }
            
            coordinates.append((hour, yValue))
        }

        let chartPoints: [ChartPoint] = coordinates.map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
        
        let xValues = [0, 3, 6, 9, 12, 15, 18, 21, 23].map {ChartAxisValueInt($0, labelSettings: labelSettings)}
        let yValues = (minY).stride(through: maxY, by: 1).map {ChartAxisValueInt($0, labelSettings: labelSettings)}
        
        // create axis models with axis values and axis title
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Time", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Count", settings: labelSettings.defaultVertical()))
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        // create layer with line
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: lineColor, lineWidth: 3, animDuration: 0.7, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
        
        // create layer with base line
        let baseLinePoints: [ChartPoint] = [(0, 0), (23, 0)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
        let baseLineModel = ChartLineModel(chartPoints: baseLinePoints, lineColor: baselineColor, lineWidth: 3, animDuration: 0, animDelay: 0)
        let baseLineChartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [baseLineModel])
        
        // create layer with guidelines
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: guidelinesColor, linesWidth: 1.0)
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
        
        super.init(view: chart.view, chart: chart)
    }
}
