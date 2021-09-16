import 'dart:math';
import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as TextElement;
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:intl/intl.dart';
import 'package:tradelist/common/Constants.dart';
import 'package:tradelist/model/item_model.dart';

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
        title: Text('꺾은선 그래프'),centerTitle: true,
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
                      final value =model.selectedSeries[0]
                          .measureFn(model.selectedDatum[0].index);

                      CustomCircleSymbolRenderer.value=value;
                      print(value);
                    })
                  ],
                  animate: true,
                  animationDuration: Duration(seconds: 1),
                  behaviors: [
                    charts.LinePointHighlighter(
                        symbolRenderer: CustomCircleSymbolRenderer())
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
  var f = NumberFormat('###,###,###,###');
  static int value;

  @override

  void paint(ChartCanvas canvas, Rectangle<num> bounds, {List<int> dashPattern, Color fillColor, FillPatternType fillPattern, Color strokeColor, double strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor,fillPattern: fillPattern, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left -5, bounds.top -30, bounds.width + 10, bounds.height + 10),
        fill: Color.white
    );
    box.write(
        'result${DateTime.now().subtract(Duration(days: 7)).month}',
        value);
    var textStyle= style.TextStyle();
    textStyle.color= Color.black;
    textStyle.fontSize= 15;
    canvas.drawText(
        TextElement.TextElement("${f.format(value)}원", style: textStyle),
        (bounds.left).round(),
        (bounds.top -28).round()
    );
  }
}
