//
//  WeekChart.swift
//  happyt
//
//  Created by Max Saienko on 10/5/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import SwiftCharts

class WeekChart: HabitChart {
    init(frame: CGRect, habit: Habit) {
        // Settings
        let chartFrame = CGRectMake(10, 35, frame.width - 20, frame.height - 45)
        
        let chartSettings = ChartSettings()
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.labelsToAxisSpacingX = 3
        chartSettings.top = 5
        chartSettings.trailing = 15
        chartSettings.labelsToAxisSpacingY = 10

        let labelSettings = ChartLabelSettings(font: UIFont.systemFontOfSize(14))
        
        // To maintain solid order
        let xAxisData = [("Sun", 0), ("Mon", 1), ("Tue", 2), ("Wed", 3), ("Thurs", 4), ("Fri", 5), ("Sat", 6)]
        
        var minY = 0
        var maxY = 1
        
        func updateMinMax(value: Int) {
            if(value > maxY) {
                maxY = value
            }
            if(value < minY) {
                minY = value
            }
        }
        
        let today = NSDate()
        let unitFlags: NSCalendarUnit = [.Weekday, .Day]
        let dateComponents = NSCalendar.currentCalendar().components(unitFlags, fromDate: today)
        
        // Go back in time, 1 less day, and then go to the beginning of that day
        let weekStart = today.addDays((dateComponents.weekday - 1) * -1).startOfDay
        
//        debugPrint(dateComponents.weekday)
//        debugPrint(today)
//        debugPrint(today.getString())
//        debugPrint(weekStart)
//        debugPrint(weekStart.getString())
        
        var daysWithEvents: [String: WeekChartPoint] = ["Sun": WeekChartPoint(type: WeekDayType.Sun), "Mon": WeekChartPoint(type: WeekDayType.Mon), "Tue": WeekChartPoint(type: WeekDayType.Tue), "Wed": WeekChartPoint(type: WeekDayType.Wed), "Thu": WeekChartPoint(type: WeekDayType.Thu), "Fri": WeekChartPoint(type: WeekDayType.Fri), "Sat": WeekChartPoint(type: WeekDayType.Sat)]
        
        func updateChartPoints(dayName: String, event: Event) {
            daysWithEvents[dayName]!.events.append(event)
            if(event.isPositive == 1) {
                daysWithEvents[dayName]!.value += 1
            } else {
                daysWithEvents[dayName]!.value -= 1
            }
            //daysWithEvents[dayName]!.value = daysWithEvents[dayName]!.events.count
            updateMinMax(daysWithEvents[dayName]!.value)
        }
        
        for event in habit.events.array as! [Event] {
            // Sun
            if(event.date.isGreaterThanDate(weekStart) && event.date.isLessThanDate(weekStart.addDays(1))) {
                updateChartPoints("Sun", event: event)
            }
            
            // Mon
            if(event.date.isGreaterThanDate(weekStart.addDays(1)) && event.date.isLessThanDate(weekStart.addDays(2))) {
                updateChartPoints("Mon", event: event)
            }
            
            // Tue
            if(event.date.isGreaterThanDate(weekStart.addDays(2)) && event.date.isLessThanDate(weekStart.addDays(3))) {
                updateChartPoints("Tue", event: event)
            }
            
            // Wed
            if(event.date.isGreaterThanDate(weekStart.addDays(3)) && event.date.isLessThanDate(weekStart.addDays(4))) {
                updateChartPoints("Wed", event: event)
            }
            
            // Thur
            if(event.date.isGreaterThanDate(weekStart.addDays(4)) && event.date.isLessThanDate(weekStart.addDays(5))) {
                updateChartPoints("Thu", event: event)
            }
            
            // Fri
            if(event.date.isGreaterThanDate(weekStart.addDays(5)) && event.date.isLessThanDate(weekStart.addDays(6))) {
                updateChartPoints("Fri", event: event)
            }
            
            // Sat
            if(event.date.isGreaterThanDate(weekStart.addDays(6)) && event.date.isLessThanDate(weekStart.addDays(7))) {
                updateChartPoints("Sat", event: event)
            }
        }
        
        let (xValues, yValues) = (
            xAxisData.map() { name, x in
                ChartAxisValueString(name, order: x, labelSettings: labelSettings)
            },
            (minY).stride(through: maxY, by: 1).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)}
        )
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Days", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Count", settings: labelSettings.defaultVertical()))
        
        let barViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, chart: Chart) -> UIView? in
            let bottomLeft = CGPoint(x: layer.innerFrame.origin.x, y: layer.innerFrame.origin.y + layer.innerFrame.height)
            
            let barWidth: CGFloat = 15
            
            let (p1, p2): (CGPoint, CGPoint) = {
                return (CGPoint(x: chartPointModel.screenLoc.x, y: bottomLeft.y), CGPoint(x: chartPointModel.screenLoc.x, y: chartPointModel.screenLoc.y))
            }()
            return ChartPointViewBar(p1: p1, p2: p2, width: barWidth, bgColor: UIColor.blueColor())
        }
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        
        // Bar Data Layer
        let chartPoints = daysWithEvents.map{
            ChartPoint(x: ChartAxisValueString($0.0, order: $0.1.type.rawValue), y: ChartAxisValueInt($0.1.value))
        }
        let chartPointsLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: barViewGenerator)
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: 1.0)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
        
        // create layer with base line
        let baseLinePoints: [ChartPoint] = [(0, 0), (6, 0)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
        let baseLineModel = ChartLineModel(chartPoints: baseLinePoints, lineColor: UIColor.blueColor(), lineWidth: 3, animDuration: 0, animDelay: 0)
        let baseLineChartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [baseLineModel])
        
        let chart = Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                chartPointsLayer,
                baseLineChartPointsLineLayer]
        )

        super.init(view: chart.view, chart: chart)
    }
}
