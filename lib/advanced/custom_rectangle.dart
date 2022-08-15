import 'dart:math';

import 'package:flutter/material.dart';

class CustomRectangle extends CustomPainter{
  final double animation;
  const CustomRectangle({Key? key,required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
 final rectWidth = 300.0, rectHeight = 100.0;
 List<Color> colors = [Colors.red,Colors.blue,Colors.green,Colors.yellow];
  Rect rect = Offset(
          size.width / 2 - rectWidth / 2, size.height / 2 - rectHeight / 2) &
      Size(rectWidth, rectHeight);
  final paint = Paint()
    ..shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colors,
      transform: GradientRotation(
        animation * 2 * pi,
      ), //改变 transform 值实现渐变旋转效果
    ).createShader(rect)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8.0;
  canvas.drawRect(rect, paint);



  }
  _initPaint(){

  }

  @override
  bool shouldRepaint(covariant CustomRectangle oldDelegate) {
    return oldDelegate.animation != animation;
  }
  
}