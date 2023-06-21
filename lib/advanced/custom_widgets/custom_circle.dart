import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomCirclePainter extends CustomPainter {
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double radius;
  final String text;
  final bool showBorder;
  CustomCirclePainter(
      {this.textStyle,
      this.backgroundColor,
      this.radius = 0,
      this.showBorder=false,
      required this.text});
  late Paint _backgroundPaint,_reflectionPaint;
  late TextPainter _textPaint;
  late TextStyle _textStyle;
  final Path _path = Path();
  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
    _drawCanvas(canvas, size);
  }

  _initPaint() {
    _backgroundPaint = Paint()
      ..color = backgroundColor ?? Colors.green
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    _reflectionPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1);
    _textPaint = TextPainter(textAlign: TextAlign.center, ellipsis: '.')
      ..textDirection = TextDirection.ltr;
    _textStyle = textStyle ??
        const TextStyle(
          color: Colors.white,
          fontSize: 12,
        );
  }
   final double blurSigma = 10.0;

  _drawCanvas(Canvas canvas, Size size){
    double centerX=size.width/2;
    double centerY=size.height/2;
    double _radius=radius;
    if(size.width>size.height){
      centerX=size.height/2;
      if(radius>centerX){
        _radius=centerX;
      }
    }else{
      centerY=size.width/2;
      if(radius>centerY){
        _radius=centerY;
      }
    }
    debugPrint('size====${size.width},${size.height},radius=$_radius');
    // final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    // canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)),
    //     _backgroundPaint);
    double temp=_radius*sin(pi/12);
    double tempY=_radius*cos(pi/12);
    debugPrint('temp=$temp,$tempY');
    _path.moveTo(size.width/2, size.height-3);
    _path.lineTo(centerX-temp, centerY+tempY);
    _path.lineTo(centerX+temp, centerY+tempY);
    _path.close();
    var rect=Rect.fromCenter(center: Offset(centerX, size.height-3), width: 20, height: 6);

    double startAngle=pi/12+pi/2;
    double sweepAngle=pi*2-pi/6;
    canvas.drawOval(rect,_reflectionPaint);
    // canvas.drawPath(_path, _backgroundPaint..color=Colors.blue);
    // canvas.drawArc(Rect.fromLTWH(0, 0, centerX*2, centerY*2), 0, pi, false, Paint()..color=Colors.pink);
    _path.reset();
    _path.arcTo(Rect.fromCircle(center: Offset(centerX, centerY), radius: _radius), startAngle, sweepAngle, true);
    _path.lineTo(size.width/2, size.height-3);
    _path.close();
    canvas.drawPath(_path, _backgroundPaint);
    if(showBorder){
    canvas.drawPath(_path, Paint()..color=Colors.amber..style=PaintingStyle.stroke..strokeWidth=2..strokeJoin=StrokeJoin.round);
    }

    
    


    _textPaint.text = TextSpan(text: text, style: _textStyle);
    _textPaint.layout();
    final offset = Offset(size.width / 2 - _textPaint.width / 2,
        size.width / 2 - _textPaint.height / 2);
    _textPaint.paint(canvas, offset);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
