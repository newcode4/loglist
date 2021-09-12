
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class PageViewer extends StatefulWidget {
  @override
  _PageViewerState createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {


  final controller = PageController(viewportFraction: 0.8, keepPage: false);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        3,
            (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0x2429406F),
          ),
          margin: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          child: Container(
            child: PageViewer(),
          ),
        ));
    return Scaffold(
      appBar: AppBar(
        title: Text("라인 그래프",
        style:
          TextStyle(fontWeight: FontWeight.bold)
          ,)
        , centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              SizedBox(
                height:500,
                width: 400,
                child: PageView.builder(
                  controller: controller,
                   itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 3),
              ),
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: SwapEffect(
                    dotHeight: 16,
                    dotWidth: 16,
                    type: SwapType.yRotation,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
