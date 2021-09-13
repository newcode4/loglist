import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tradelist/pages/sales.dart';

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() {
    return _GraphPageState();
  }
}

class _GraphPageState extends State<GraphPage> {
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
      appBar: AppBar(title: Text('막대 그래프',style: TextStyle(fontWeight: FontWeight.bold),),centerTitle: true,),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('month_result').orderBy('title',descending: false).snapshots(),
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
                child: charts.BarChart(_seriesBarData,
                    animate: true,
                    animationDuration: Duration(seconds:1),
                     behaviors: [
                      // new charts.DatumLegend(
                      //   entryTextStyle: charts.TextStyleSpec(
                      //       color: charts.MaterialPalette.black,
                      //       fontFamily: 'Georgia',
                      //       fontSize: 12),
                      // )
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