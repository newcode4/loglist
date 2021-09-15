import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tradelist/common/Constants.dart';
import 'package:tradelist/model/item_model.dart';

import 'line_chart/line_chart.dart';


class BarChart extends StatefulWidget {
  @override
  _BarChartState createState() {
    return _BarChartState();
  }
}

class _BarChartState extends State<BarChart> {
  List<charts.Series<Sales, String>> _seriesBarData;
  List<Sales> mydata;

  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Sales, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Sales sales, _) => sales.title.toString(),
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
        title: Text('막대 그래프'),
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
              .document("00${DateTime.now().subtract(Duration(days: 7)).month}")
              .get()
              .then((DocumentSnapshot ds) {
            var sales2 = ds.data["month_total"];

            box.write(
                'result2${DateTime.now().subtract(Duration(days: 7)).month}',
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
                child: charts.BarChart(
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