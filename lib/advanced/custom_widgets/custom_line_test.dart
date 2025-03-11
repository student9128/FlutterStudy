import 'dart:math';

import 'package:flutter/material.dart';

class CustomLineTest extends CustomPainter{
  late Paint _axisPaint,_linePaint,_basePaint;
  static const double _mPadding=0;
  late double startX,endX,startY,endY;
  late double _disWidth,_disHeight;
  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
    _initAxisLine(size);
    _drawAxisLine(canvas);
    _drawLine(canvas);
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    double width = 120;
    double height = 100;
    double midWidth = width * 0.6; // 控制梯形上宽度的参数
    double cornerRadius = 16.0; // 圆角半径

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(midWidth, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    // 绘制圆角
    RRect roundedRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, width, height),
      topLeft: Radius.circular(cornerRadius),
      topRight: Radius.circular(cornerRadius),
      bottomLeft: Radius.zero,
      bottomRight: Radius.zero,
    );

    canvas.drawPath(path, paint);
    canvas.drawRRect(roundedRect, paint);
  }

void _initPaint() {
  _axisPaint = Paint()
    ..isAntiAlias=true
    ..strokeWidth=1
    ..strokeCap=StrokeCap.square
    ..color=Colors.red
    ..style=PaintingStyle.stroke;
  _linePaint= Paint()
    ..isAntiAlias=true
    ..strokeWidth=2
    ..strokeCap=StrokeCap.round
    ..color=Colors.lightGreen
    ..style=PaintingStyle.stroke;
  _basePaint= Paint()
    ..isAntiAlias=true
    ..strokeWidth=1
    ..strokeCap=StrokeCap.round
    ..color=Colors.lightGreenAccent
    ..style=PaintingStyle.stroke;
}
  void _initAxisLine(Size size) {
    startX = _mPadding;
    endX = size.width-_mPadding;
    startY=size.height-_mPadding;
    endY=_mPadding;
    _disWidth=endX-startX;
    _disHeight=startY-endY;
  }
  void _drawAxisLine(Canvas canvas) {
    canvas.drawLine(Offset(startX, startY), Offset(endX, startY), _axisPaint); //x轴
    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), _axisPaint); //y轴
  }
  void _drawLine(Canvas canvas){
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(90, 0);
    Rect rect = Rect.fromLTWH(80,0,  20,  20);
    path.addArc(rect, -pi/2, pi/4);
    path.lineTo(150, 150);
    canvas.drawPath(path, _linePaint);
    // canvas.drawLine(Offset(90, 0), Offset(90, 20), _basePaint);
    // canvas.drawRect(rect, _axisPaint);

  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
