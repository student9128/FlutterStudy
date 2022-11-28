import 'package:flutter/material.dart';

class ChartLine extends CustomPainter {
  static const double _mPadding = 0,
      _mPaddingBottom = 0,
      _mPaddingTop = 0,
      _mPaddingLeft = 0,
      _mPaddingRight = 0;
  late double startX, endX, startY, endY;
  late double _disWidth, _disHeight;
  late Paint _axisPaint,
      _linePaint,
      _basePaint,
      _forgeLinePaint;
  late TextPainter _axisTextPaint;
  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
    _initData();
    _initAxisLine(size);
    _draw(canvas);
  }

  _initPaint() {}
  _initData() {}
  _initAxisLine(Size size) {
    startX = _mPadding;
    endX = size.width - _mPadding;
    startY = size.height-_mPadding;
    endY = _mPadding;
    _disWidth = endX - startX;
    _disHeight = startY - endY;
  }
  _draw(Canvas canvas) {
    _drawAxis(canvas);
  }
  _drawAxis(Canvas canvas){

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
