import 'package:flutter/material.dart';

/// Main Class.
/// [title] is the title of de progress bar.
/// [width] is the width of the progress bar in pixels
/// [percentage] is the percentage to be represented in the progress bar.
/// [firstlimit] It is the upper limit of the first segment.
/// [secondlimit] It is the upper limit of the second segment.
class DoProgressBar extends StatelessWidget {
  final String title;
  final double width;
  final double percentage;
  final double firstlimit;
  final double secondlimit;

  /// Builder requirements are defined
  DoProgressBar({
    this.title,
    @required this.width,
    @required this.percentage,
    @required this.firstlimit,
    @required this.secondlimit,
  });

  @override
  Widget build(BuildContext context) {
    /// Advanced percentage rounding
    final prounded = (percentage.roundToDouble());

    /// Main container
    return Container(
      child: Column(
        children: [
          (title == null) ? Text('') : Text(title),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: width,
              height: (width / 4),
              color: Colors.grey[900],
              child: Container(
                width: (width * 0.9),
                height: (width / 4 * 0.9),
                color: Colors.white,
                margin: EdgeInsets.all(10 * (width / 200)),
                child: Stack(
                  /// Progress bar stacking.
                  children: [
                    ClipRRect(
                      borderRadius:  BorderRadius.circular(20),
                      child: Container(
                        width: prounded*0.6,
                        height: width / 4 * 0.9,
                        color: (prounded >= secondlimit)
                            ? Colors.white
                            : (prounded < firstlimit)
                                ? Colors.red
                                : Colors.yellow,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        child: SizedBox(
                          width: prounded*0.6,
                          height: width / 10,
                          child: Container(
                            color: (prounded >= secondlimit)
                                ? Color(0xFFBCCDFF)
                                : (prounded < firstlimit)
                                    ? Colors.redAccent
                                    : Colors.yellowAccent,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${prounded.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20 * (width / 200),
                          color: (prounded >= secondlimit)
                              ? Colors.black
                              : (prounded < firstlimit)
                                  ? Colors.white
                                  : Colors.lightGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
