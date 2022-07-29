import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class PDFViewer extends StatefulWidget {
  final Function() onDismissTapped;
  final String pdfText;
  const PDFViewer(
      {Key? key, required this.onDismissTapped, required this.pdfText})
      : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  double scrollSpeed = 1.0;
  Function? onDismissTapped;
//https://stackoverflow.com/questions/57138772/how-to-autoscroll-text-in-flutter
  final ScrollController _scrollController = ScrollController();
  bool scroll = false;
  int speedFactor = 100;

  //For Scaling Text Area
  //https://stackoverflow.com/questions/55440184/flutter-gesturedetector-how-to-pinch-in-out-or-zoom-in-out-text-using-two-finge
  double _fontSize = 20;
  final double _baseFontSize = 20;
  double _fontScale = 1;
  double _baseFontScale = 1;
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  bool _stopScrolling = false;

  _scroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;
    int duration = durationDouble.toInt();
    if (duration <= 0) {
      duration = 1;
    }
    print(
        "maxScrollExtent = $maxExtent and distanceDifference = $distanceDifference and durationDouble = $durationDouble");
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: duration), curve: Curves.linear);
  }

  _toggleScrolling() {
    /* if (_stopScrolling) {
      print("Stop scrolling flag value is $_stopScrolling");
      return;
    } */

    setState(() {
      scroll = !scroll;
    });

    if (scroll) {
      _scroll();
    } else {
      _scrollController.animateTo(_scrollController.offset,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      _toggleScrolling();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('pdf') ,),
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 100),
                  child: NotificationListener(
                    onNotification: (notif) {
                      if (notif is ScrollEndNotification && scroll) {
                        Timer(const Duration(seconds: 1), () {
                          _scroll();
                        });
                      }
                      return true;
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(20),
                      child: DefaultTextStyle(
                        style: const TextStyle(color: Colors.white),
                        child: GestureDetector(
                          onScaleStart: (ScaleStartDetails scaleStartDetails) {
                            setState(() {
                              //_stopScrolling = true;
                              _toggleScrolling();
                            });
                            //_baseScaleFactor = _scaleFactor;
                            _baseFontScale = _fontScale;

                            print("base scale factor = $_baseFontScale");
                          },
                          onScaleUpdate:
                              (ScaleUpdateDetails scaleUpdateDetails) {
                            // don't update the UI if the scale didn't change
                            /* if (scaleUpdateDetails.scale == 1.0) {
                              debugPrint("Scale is 1.0 returning");
                              setState(() {
                                _stopScrolling = false;
                                _toggleScrolling();
                              });
                              return;
                            } */
                            /* _scaleFactor =
                                _baseScaleFactor * scaleUpdateDetails.scale;
                            print("Final scale factor = $_scaleFactor");
                            if (_scaleFactor < 1.0) {
                              _scaleFactor = 1.0;
                            }
                            print("New Final scale factor = $_scaleFactor"); */

                            //setState(() {
                            _fontScale =
                                (_baseFontScale * scaleUpdateDetails.scale)
                                    .clamp(0.5, 5.0);
                            _fontSize = _fontScale * _baseFontSize;
                            debugPrint("New Final font size = $_fontSize");
                            if (_fontSize < 20) {
                              _fontSize = 20;
                            }
                            //});
                            setState(() {
                              //_toggleScrolling();
                              _stopScrolling = false;
                              _toggleScrolling();
                            });
                          },
                          child: Text(
                            widget.pdfText,
                            /* textScaleFactor:
                                (_scaleFactor <= 0.1) ? 1.0 : _scaleFactor, */
                            style: TextStyle(
                                fontSize: (_fontSize < 20) ? 20 : _fontSize),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withAlpha(50),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: TextButton(
                              child: const Text(
                                "Dismiss",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () => widget.onDismissTapped(),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: _buildSlider(context)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SliderTheme(
        data: SliderThemeData(
            activeTrackColor: Colors.brown[700],
            inactiveTrackColor: Colors.brown[300],
            inactiveTickMarkColor: Colors.transparent,
            activeTickMarkColor: Colors.transparent),
        child: Slider(
            divisions: 100,
            min: 0,
            max: 100,
            value: speedFactor.toDouble(),
            onChanged: (double value) {
              setState(() {
                //scrollSpeed = value;
                _toggleScrolling();
              });

              speedFactor = value.toInt();
              if (speedFactor == 0) {
                speedFactor = 1;
              }
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  //scrollSpeed = value;
                  _toggleScrolling();
                });
              });
            }),
      ),
    );
  }
}