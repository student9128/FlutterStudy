import 'dart:math';

import 'package:flutter/material.dart';

class CustomAnimCircle extends CustomPainter {
  late Paint _paint;
  final Color? backgroundColor;
  final double? startAngle;
  final double? sweepAngle;

  CustomAnimCircle(
      {this.backgroundColor = Colors.green,
      this.startAngle = 0,
      this.sweepAngle});

  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
    _drawCanvas(canvas, size);
  }

  _initPaint() {
    _paint = Paint()
      ..color = backgroundColor ?? Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;
  }

  _drawCanvas(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double _radius = min(centerX, centerY);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: _radius),
        startAngle ?? 0,
        sweepAngle ?? pi*2,
        true,
        _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
