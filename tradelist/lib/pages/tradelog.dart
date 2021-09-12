
import 'package:flutter/material.dart';

class TradeLog extends StatefulWidget {
  const TradeLog({Key key}) : super(key: key);

  @override
  _TradeLogState createState() => _TradeLogState();
}

class _TradeLogState extends State<TradeLog> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "통계 그래프",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  PageView(),
                ],
              ),
            )),
      ),
    );
  }
}
