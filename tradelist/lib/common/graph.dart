// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class LineGraph extends StatefulWidget {
//   LineGraph({Key key}) : super(key: key);
//
//   @override
//   _LineGraphState createState() => _LineGraphState();
// }
//
// class _LineGraphState extends State<LineGraph> {
//   List<SalesData> _chartData;
//   TooltipBehavior _tooltipBehavior;
//
//   @override
//   void initState() {
//     _chartData = getChartData();
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 550,
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Scaffold(
//             body: SfCartesianChart(
//               legend: Legend(isVisible: true),
//               tooltipBehavior: _tooltipBehavior,
//               series: <ChartSeries>[
//                 LineSeries<SalesData, double>(
//                     color: Color(0xff23b6e6),
//                     name: '누적수익',
//                     dataSource: _chartData,
//                     xValueMapper: (SalesData sales, _) => sales.month,
//                     yValueMapper: (SalesData sales, _) => sales.sales,
//                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                     enableTooltip: true)
//               ],
//               primaryXAxis: NumericAxis(
//                 edgeLabelPlacement: EdgeLabelPlacement.shift,
//               ),
//               primaryYAxis: NumericAxis(
//                   labelFormat: '{value}만원',
//                   numberFormat: NumberFormat.simpleCurrency(decimalDigits: 3)),
//             )),
//       ),
//     );
//   }
//
//   List<SalesData> getChartData() {
//     final List<SalesData> chartData = [
//       SalesData(1, 100),
//       SalesData(2, 12),
//       SalesData(3, 24),
//       SalesData(4, 30),
//       SalesData(5, 18),
//       SalesData(6, 300),
//       SalesData(7, 300),
//       SalesData(8, 300),
//       SalesData(9, 300),
//       SalesData(10, 300),
//       SalesData(11, 300),
//       SalesData(12, 300),
//     ];
//     return chartData;
//   }
// }
//
// class SalesData {
//   SalesData(this.month, this.sales);
//
//   final double month;
//   final double sales;
// }
