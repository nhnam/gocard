//
//  GraphView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/20/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class GraphView: UIView, ChartDelegate {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func showChart() {
        let chart = Chart(frame: self.bounds)
        chart.delegate = self
        chart.yLabels = [0.00, 5.55, 14.70, 25.85, 36.0]
        chart.yLabelsFormatter = { String($1) }
        chart.xLabels = [01,02,03,04,05,06,07,08,09,10,11,12]
        chart.xLabelsFormatter = { String(format:"%02d", Int($1)) }
        let data = [(x: 0.0, y: 0),(x: 1, y: 16.5),(x: 2, y: 26.5),(x: 3, y: 6.5),(x: 4, y: 29.5),(x: 5, y: 35) ]
        let series = ChartSeries(data: data)
        series.area = true
        chart.add(series)
        self.addSubview(chart)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // Chart delegate
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Float, left: CGFloat) {
        // Do something on touch
//        for (serieIndex, dataIndex) in enumerate(indexes) {
//            if dataIndex != nil {
//                // The series at serieIndex has been touched
//                let value = chart.valueForSeries(serieIndex, atIndex: dataIndex)
//            }
//        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        // Do something when finished
    }
}
