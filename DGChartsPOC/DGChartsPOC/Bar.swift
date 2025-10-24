//
//  Bar.swift
//  DGChartsPOC
//
//  Created by Asif Habib on 18/04/25.
//

import SwiftUI
import DGCharts

struct Bar: UIViewRepresentable {
    var entries: [BarChartDataEntry] = []
    func makeUIView(context: Context) -> DGCharts.BarChartView {
        let chart = BarChartView()
        chart.data = addData()
//        BarChartData(dataSet: BarChartDataSet(entries: entries))
        return chart
    }
    
    func updateUIView(_ uiView: DGCharts.BarChartView, context: Context) {
        uiView.data = addData()
    }
    
    func addData() -> BarChartData {
        let data = BarChartData()
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.colors = [.blue]
        dataSet.label = "Bar Chart"
        data.dataSets.append(dataSet)
        return data
    }
    
    typealias UIViewType = BarChartView
}

struct Line: UIViewRepresentable {
    func updateUIView(_ uiView: DGCharts.LineChartView, context: Context) {
//        uiView.data = addLineChartData()
    }

    var lineEntries: [ChartDataEntry] = []
    var line2Entries: [ChartDataEntry] = []
    func makeUIView(context: Context) -> DGCharts.LineChartView {
        let chart = LineChartView()
        chart.data = addLineChartData()
//        BarChartData(dataSet: BarChartDataSet(entries: entries))
        return chart
    }
    
    func updateUIView(_ uiView: DGCharts.BarChartView, context: Context) {
//        uiView.data = addLineChartData()
    }
    
    func addLineChartData() -> LineChartData {
        let data = LineChartData()
        let dataSet = LineChartDataSet(entries: lineEntries)
        let dataSet2 = LineChartDataSet(entries: line2Entries)
        dataSet.colors = [.blue]
        dataSet.label = "Line Chart"
        dataSet2.colors = [.red]
        dataSet2.label = "Line Chart 2"
        data.dataSets.append(dataSet)
        data.dataSets.append(dataSet2)
        
        return data
    }
    
    typealias UIViewType = LineChartView
}

#Preview {
    Bar()
    
}

struct Bar_Previews: PreviewProvider {
    static var previews: some View {
        Bar(entries: [BarChartDataEntry(x: 1, y: 1), BarChartDataEntry(x: 2, y: 2), BarChartDataEntry(x: 3, y: 10)])
    }
}
struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line(lineEntries: [
            ChartDataEntry(x: 2, y: 43),
            ChartDataEntry(x: 4, y: 32),
            ChartDataEntry(x: 5, y: 74),
            ChartDataEntry(x: 23, y: 344),
        ],
             line2Entries: [
                 ChartDataEntry(x: 3, y: 12),
                 ChartDataEntry(x: 8, y: 32),
                 ChartDataEntry(x: 10, y: 22),
                 ChartDataEntry(x: 36, y: 45),
             ],
        )
    }
}
