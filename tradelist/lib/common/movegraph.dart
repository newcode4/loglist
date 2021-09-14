import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tradelist/pages/line_chart/line_chart.dart';
import 'package:tradelist/pages/pie_chart/pie_chart_page.dart';
import 'package:tradelist/pages/saleshomepage.dart';
import 'package:tradelist/utilites/platform_info.dart';





class MoveGraph extends StatefulWidget {



  @override
  _MoveGraphState createState() => _MoveGraphState();
}

class _MoveGraphState extends State<MoveGraph> {
  int _currentPage = 0;

  final _controller = PageController(initialPage: 0);
  final _duration = Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;
  final _pages = [
    GraphPage(),
    LineGraph(),
    PieChartPage(),
    // BarChartPage3(),
  ];

  bool get isDesktopOrWeb => PlatformInfo().isDesktopOS() || PlatformInfo().isWeb();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics:
              isDesktopOrWeb ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
          controller: _controller,
          children: _pages,
        ),
      ),
      bottomNavigationBar: isDesktopOrWeb
          ? Container(
              padding: EdgeInsets.all(16),
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Visibility(
                    visible: _currentPage != 0,
                    child: FloatingActionButton(
                      onPressed: () => _controller.previousPage(duration: _duration, curve: _curve),
                      child: Icon(Icons.chevron_left_rounded),
                    ),
                  ),
                  Spacer(),
                  Visibility(
                    visible: _currentPage != _pages.length - 1,
                    child: FloatingActionButton(
                      onPressed: () => _controller.nextPage(duration: _duration, curve: _curve),
                      child: Icon(Icons.chevron_right_rounded),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
