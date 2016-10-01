//
//  StatsController.swift
//  happyt
//
//  Created by Max Saienko on 9/17/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import UIKit
import SwiftCharts

class StatsViewController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var charts: [Chart] = []

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let habits = appDelegate.habits
        
        let containerWidth = view.frame.width - 22
        let containerHeight: CGFloat = 300
        var offsetY: CGFloat = 10
        for habit in habits {
            let container = HabitContainer(frame: CGRectMake(10, offsetY, containerWidth, containerHeight), habit: habit)
            contentView.addSubview(container.view)
            offsetY = 10 + container.view.frame.maxY
            
            // Chart
            let chartFrame = CGRectMake(10, 40, containerWidth - 20, containerHeight - 45)
            
            let chartPoints: [ChartPoint] = [(2, 2), (4, -4), (6, 6), (8, 10), (12, 9)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
            
            let xValues = 0.stride(through: 24, by: 3).map {ChartAxisValueInt($0)}
            //let xValues = [ChartAxisValueInt(-2), ChartAxisValueInt(0), ChartAxisValueInt(3), ChartAxisValueInt(5)]
            let yValues = (-4).stride(through: 10, by: 2).map {ChartAxisValueInt($0)}
            
            let labelSettings = ChartLabelSettings(font: UIFont.systemFontOfSize(14))
            
            // create axis models with axis values and axis title
            let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Time", settings: labelSettings))
            let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Count", settings: labelSettings.defaultVertical()))
            
            let chartSettings = ChartSettings()
            chartSettings.axisStrokeWidth = 0.2
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
            
            
            
            //////////////==================////////////////
            
            self.charts.append(chart)
            container.view.addSubview(chart.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
