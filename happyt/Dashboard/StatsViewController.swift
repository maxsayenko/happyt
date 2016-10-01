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
        debugPrint("Stats")
        debugPrint(self.view.frame)
        debugPrint(scrollView.frame)
        debugPrint(contentView.frame)
        
        let habits = appDelegate.habits
        let containerWidth = view.frame.width - 22
        let containerHeight: CGFloat = 300
        var offsetY: CGFloat = 10
        for habit in habits {
            let habitContainer = UIView(frame: CGRectMake(10, offsetY, containerWidth, containerHeight))
            habitContainer.backgroundColor = UIColor.greenColor()
            habitContainer.layer.cornerRadius = 20
            habitContainer.layer.borderWidth = 1

            let nameLabel = UILabel(frame: CGRectMake(10, 10, containerWidth, 20))
            nameLabel.text = habit.name
            habitContainer.addSubview(nameLabel)
            
            contentView.addSubview(habitContainer)
            
            offsetY = 10 + habitContainer.frame.maxY
            
            
            let chartConfig = BarsChartConfig(
                valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
            )
            
            let chart = BarsChart(
                frame: CGRectMake(10, 40, containerWidth - 20, containerHeight - 45),
                chartConfig: chartConfig,
                xTitle: "X axis",
                yTitle: "Y axis",
                bars: [
                    ("A", 2),
                    ("B", 4.5),
                    ("C", 3),
                    ("D", 5.4),
                    ("E", 6.8),
                    ("F", 0.5)
                ],
                color: UIColor.redColor(),
                barWidth: 20
            )
            
            self.charts.append(chart)
            habitContainer.addSubview(chart.view)
        }
        
        
//        let chartConfig = ChartConfigXY(
//            xAxisConfig: ChartAxisConfig(from: 2, to: 14, by: 2),
//            yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
//        )
//        
//        let chart = LineChart(
//            frame: CGRectMake(0, 70, 300, 500),
//            chartConfig: chartConfig,
//            xTitle: "X axis",
//            yTitle: "Y axis",
//            lines: [
//                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.redColor()),
//                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blueColor())
//            ]
//        )
//        
//        self.view.addSubview(chart.view)
        // Do any additional setup after loading the view.
        

        
        
        
        
        
        
        
        
        
        
        
//        let chartPoints: [ChartPoint] = [(2, 2), (4, 4), (6, 6), (8, 10), (12, 14)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
//        
//        let xValues = 0.stride(through: 16, by: 2).map {ChartAxisValueInt($0)}
//        let yValues = 0.stride(through: 16, by: 2).map {ChartAxisValueInt($0)}
//        
//        let labelSettings = ChartLabelSettings(font: UIFont.systemFontOfSize(14))
//        
//        // create axis models with axis values and axis title
//        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
//        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
//        
//        let chartFrame = CGRectMake(20, 100, 300, 400)
//        
//        let chartSettings = ChartSettings()
//        chartSettings.axisStrokeWidth = 0.2
//        chartSettings.top = 20
//        chartSettings.trailing = 20
//        // ...
//        
//        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
//        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
//        
//        // create layer with line
//        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor(red: 0.4, green: 0.4, blue: 1, alpha: 0.2), lineWidth: 3, animDuration: 0.7, animDelay: 0)
//        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
//        
//        // creates custom view for each chartpoint
//        let myCustomViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
//            let center = chartPointModel.screenLoc
//            let label = UILabel(frame: CGRectMake(center.x - 20, center.y - 10, 40, 20))
//            label.backgroundColor = UIColor.greenColor()
//            label.textAlignment = NSTextAlignment.Center
//            label.text = chartPointModel.chartPoint.description
//            //label.font = ExamplesDefaults.labelFont
//            return label
//        }
//        
//        // create layer that uses the view generator
//        let myCustomViewLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: myCustomViewGenerator, displayDelay: 0, delayBetweenItems: 0.05)
//        
//        
//        // create layer with guidelines
//        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: 1.0)
//        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
//        
//        let chart = Chart(
//            frame: chartFrame,
//            layers: [
//                xAxis,
//                yAxis,
//                guidelinesLayer,
//                chartPointsLineLayer,
//                myCustomViewLayer
//            ]
//        )
//        
//        self.view.addSubview(chart.view)
//        self.chart = chart
        
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )
        
        let chart = BarsChart(
            frame: CGRectMake(0, 0, 300, 300),
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            bars: [
                ("A", 2),
                ("B", 4.5),
                ("C", 3),
                ("D", 5.4),
                ("E", 6.8),
                ("F", 0.5)
            ],
            color: UIColor.redColor(),
            barWidth: 20
        )
        
        //chartView.addSubview(chart.view)
        //self.chart = chart
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
