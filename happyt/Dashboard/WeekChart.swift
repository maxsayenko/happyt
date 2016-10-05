//
//  BarChart.swift
//  happyt
//
//  Created by Max Saienko on 10/5/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import SwiftCharts

class WeekChart: HabitChart {
//    let view: ChartView
//    let chart: Chart
    
    init(frame: CGRect, habit: Habit) {
        //let tuplesXY = [(2, 8), (4, 9), (6, 10), (8, 12), (12, 17)]
        let tuplesXY2 = [("Mon", 1, 3), ("Tue", 2, 5), ("Wed", 3, 7), ("Thurs", 4, 17), ("Fri", 5, 11), ("Sat", 6, 10), ("Sun", 7, 4)]
        
//        func reverseTuples(tuples: [(Int, Int)]) -> [(Int, Int)] {
//            return tuples.map{($0.1, $0.0)}
//        }
        
        let chartPoints = tuplesXY2.map{ChartPoint(x: ChartAxisValueString($0.0, order: $0.1), y: ChartAxisValueInt($0.2))}
        
        let labelSettings = ChartLabelSettings(font: UIFont.systemFontOfSize(14))
        
        let (axisValues1, axisValues2) = (
            0.stride(through: 20, by: 2).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            tuplesXY2.map() { name, x, y in
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
//        self.chart = chart
//        self.view = chart.view
    }
}
