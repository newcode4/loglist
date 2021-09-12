
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tradelist/common/graph.dart';
import 'package:tradelist/pages/logpage.dart';
import 'package:tradelist/pages/pageviewer.dart';
import 'package:tradelist/pages/tradelist.dart';
import 'package:tradelist/utilites/toolsUtilities.dart';

import 'saleshomepage.dart';


class StarterPage extends StatefulWidget {
  @override
  _StarterPageState createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    List<Widget> tabs = [
      TradeList(),
      LogPage(),
      GraphPage(),
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home,color: ToolsUtilities.whiteColor, size: 20,),
          Icon(Icons.text_snippet,color: ToolsUtilities.whiteColor, size: 20,),
          Icon(Icons.trending_up,color: ToolsUtilities.whiteColor, size: 20),
        ],
        color: ToolsUtilities.secondColor,
        buttonBackgroundColor: ToolsUtilities.secondColor,
        backgroundColor: ToolsUtilities.whiteColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds:200),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: tabs[_page],
    );
  }
}
