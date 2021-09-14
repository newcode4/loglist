
import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tradelist/common/Constants.dart';
import 'package:tradelist/pages/sales.dart';

import 'package:flutter/widgets.dart' hide Element;

class LineGraph extends StatefulWidget {
  @override
  _LineGraphState createState() {
    return _LineGraphState();
  }
}

class _LineGraphState extends State<LineGraph> {
  List<charts.Series<Sales, int>> _seriesBarData;
  List<Sales> mydata;

  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Sales, int>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Sales sales, _) => int.parse(sales.month),
        measureFn: (Sales sales, _) => int.parse(sales.month_total),
        id: 'Sales',
        data: mydata,
        labelAccessorFn: (Sales row, _) => "${row.month_total}원",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('꺽은선 그래프'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('month_result')
          .orderBy('sort', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Sales> sales = snapshot.data.documents
              .map((documentSnapshot) => Sales.fromMap(documentSnapshot.data))
              .toList();

          Firestore.instance
              .collection("month_result")
              .document("0${DateTime.now().subtract(Duration(days: 7)).month}")
              .get()
              .then((DocumentSnapshot ds) {
            var sales2 = ds.data["month_total"];

            box.write(
                'result${DateTime.now().subtract(Duration(days: 7)).month}',
                sales2);
            // print(box.read('result${DateTime.now().subtract(Duration(days:7)).month}'));
          });
          return _buildChart(context, sales);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Sales> saledata) {
    mydata = saledata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.LineChart(
                  _seriesBarData,
                  selectionModels: [
                    new charts.SelectionModelConfig(
                        changedListener: (SelectionModel model) {
                          print( model.selectedSeries[0].measureFn(
                              model.selectedDatum[0].index)
                          );
                          }
                    )
                  ],
                  animate: true,
                  animationDuration: Duration(seconds: 1),
                  behaviors: [
                    charts.LinePointHighlighter(
                      symbolRenderer:  CustomCircleSymbolRenderer()
                    )
                  ],

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  static String value;
  @override
  void Paint(ChartCanvas canvas, Rectangle<num> bounds, {List<int> dashPattern, Color fillColor, Color strokeColor, double strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left -5, bounds.top -30, bounds.width + 10, bounds.height + 10),
        fill: Color.white
    );
    // var textStyle= style.TextStyle();
    // textStyle.color= Color.black;
    // textStyle.fontSize= 15;
    // canvas.drawText(
    //     TextElement("$value", style: textStyle),
    //     (bounds.left).round(),
    //     (bounds.top -28).round()
    // );
  }
}