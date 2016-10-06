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
        let today = NSDate()
        let unitFlags: NSCalendarUnit = [.Weekday, .Day]
        let dateComponents = NSCalendar.currentCalendar().components(unitFlags, fromDate: today)
        
        // Go back in time, 1 less day, and then go to the beginning of that day
        let weekStart = today.addDays((dateComponents.weekday - 1) * -1).startOfDay
        
        debugPrint(dateComponents.weekday)
        debugPrint(today)
        debugPrint(today.getString())
        debugPrint(weekStart)
        debugPrint(weekStart.getString())
        
        var daysWithEvents: [String: WeekChartPoint] = ["Sun": WeekChartPoint(type: WeekDayType.Sun), "Mon": WeekChartPoint(type: WeekDayType.Mon), "Tue": WeekChartPoint(type: WeekDayType.Tue), "Wed": WeekChartPoint(type: WeekDayType.Wed), "Thu": WeekChartPoint(type: WeekDayType.Thu), "Fri": WeekChartPoint(type: WeekDayType.Fri), "Sat": WeekChartPoint(type: WeekDayType.Sat)]
        
        for event in habit.events.array as! [Event] {
            // Sun
            if(event.date.isGreaterThanDate(weekStart) && event.date.isLessThanDate(weekStart.addDays(1))) {
                daysWithEvents["Sun"]?.events.append(event)
                daysWithEvents["Sun"]?.value = (daysWithEvents["Sun"]?.events.count)!
            }
            
            // Mon
            if(event.date.isGreaterThanDate(weekStart.addDays(1)) && event.date.isLessThanDate(weekStart.addDays(2))) {
                daysWithEvents["Mon"]?.events.append(event)
                daysWithEvents["Mon"]?.value = (daysWithEvents["Mon"]?.events.count)!
            }
            
            // Tue
            if(event.date.isGreaterThanDate(weekStart.addDays(2)) && event.date.isLessThanDate(weekStart.addDays(3))) {
                daysWithEvents["Tue"]?.events.append(event)
                daysWithEvents["Tue"]?.value = (daysWithEvents["Tue"]?.events.count)!
            }
            
            // Wed
            if(event.date.isGreaterThanDate(weekStart.addDays(3)) && event.date.isLessThanDate(weekStart.addDays(4))) {
                daysWithEvents["Wed"]?.events.append(event)
                daysWithEvents["Wed"]?.value = (daysWithEvents["Wed"]?.events.count)!
            }
            
            // Thur
            if(event.date.isGreaterThanDate(weekStart.addDays(4)) && event.date.isLessThanDate(weekStart.addDays(5))) {
                daysWithEvents["Thu"]?.events.append(event)
                daysWithEvents["Thu"]?.value = (daysWithEvents["Thu"]?.events.count)!
            }
            
            // Fri
            if(event.date.isGreaterThanDate(weekStart.addDays(5)) && event.date.isLessThanDate(weekStart.addDays(6))) {
                daysWithEvents["Fri"]?.events.append(event)
                daysWithEvents["Fri"]?.value = (daysWithEvents["Fri"]?.events.count)!
            }
            
            // Sat
            if(event.date.isGreaterThanDate(weekStart.addDays(6)) && event.date.isLessThanDate(weekStart.addDays(7))) {
                daysWithEvents["Sat"]?.events.append(event)
                daysWithEvents["Sat"]?.value = (daysWithEvents["Sat"]?.events.count)!
            }
        }
        
        let chartData = [("Sun", 0, 4), ("Mon", 1, 3), ("Tue", 2, 5), ("Wed", 3, 7), ("Thurs", 4, 17), ("Fri", 5, 11), ("Sat", 6, 10)]
        
        let chartPoints = daysWithEvents.map{
            ChartPoint(x: ChartAxisValueString($0.0, order: $0.1.type.rawValue), y: ChartAxisValueInt($0.1.value))
        }
        
//        let chartPoints = chartData.map{
//            ChartPoint(x: ChartAxisValueString($0.0, order: $0.1), y: ChartAxisValueInt($0.2))
//        }
        
        let labelSettings = ChartLabelSettings(font: UIFont.systemFontOfSize(14))
        
        let (axisValues1, axisValues2) = (
            0.stride(through: 20, by: 2).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            chartData.map() { name, x, y in
                ChartAxisValueString(name, order: x, labelSettings: labelSettings)
            }
        )
        let (xValues, yValues) = (axisValues2, axisValues1)
        
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
        
        let chartFrame = CGRectMake(10, 35, frame.width - 20, frame.height - 45)
        
        let chartSettings = ChartSettings()
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.labelsToAxisSpacingX = 3
        chartSettings.top = 5
        chartSettings.trailing = 15
        chartSettings.labelsToAxisSpacingY = 10
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let chartPointsLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: barViewGenerator)
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: 1.0)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                chartPointsLayer]
        )

        super.init(view: chart.view, chart: chart)
    }
}
