import 'dart:math';
import 'dart:ui';

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
      _forgeLinePaint,
      xPaint,
      yPaint;
  late TextPainter _axisTextPaint;
  int count = 16;

  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
    _initData();
    _initAxisLine(size);
    _draw(canvas, size);
  }

  _initPaint() {
    _linePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..blendMode;
    _basePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..blendMode;
    _axisPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;
    xPaint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;
    yPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;
    _axisTextPaint = TextPainter()..textDirection = TextDirection.ltr;
  }

  _initData() {}

  _initAxisLine(Size size) {
    startX = _mPadding;
    endX = size.width - _mPadding;
    startY = size.height - _mPadding;
    endY = _mPadding;
    _disWidth = endX - startX;
    _disHeight = startY - endY;
  }

  _draw(Canvas canvas, Size size) {
    _drawAxis(canvas);
    double unitX = _disWidth/count;
    double unitY = _disHeight/count;
    List<Offset> points = [];
    points.add(Offset(startX, startY));
    points.add(Offset(startX, startY-unitY*4));
    points.add(Offset(startX+unitX*4, startY-unitY*4));
    points.add(Offset(startX+unitX*4, startY));
    canvas.drawPoints(PointMode.points, points, _basePaint);
    canvas.drawPoints(PointMode.polygon, points, _linePaint);
    final path = Path();
    path.moveTo(startX, startY);
    path.cubicTo(startX, startY-unitY*4, startX+unitX*4, startY-unitY*4, startX+unitX*4, startY);
    // path.lineTo(150, 190);
    // path.lineTo(180, 150);
    canvas.drawPath(path, _linePaint);
    final path2 = Path();
    double p0X=startX;
    double p0Y=startY-unitY*8;
    debugPrint('unitX=$unitX,unitY=$unitY,$p0X,$p0Y');
    _linePaint..color = Colors.indigoAccent;
    canvas.drawLine(Offset(p0X, p0Y),Offset(endX, p0Y), _linePaint);
    path2.moveTo(p0X,p0Y);
    path2.quadraticBezierTo(p0X+unitX*4, p0Y-unitY*4,p0X+unitX*8, p0Y);
    // path2.quadraticBezierTo(p0X+unitX*8, p0Y,p0X+unitX*12, p0Y+unitY*4);
    path2.quadraticBezierTo(p0X+unitX*12, p0Y+unitY*4,p0X+unitX*16, p0Y);
    _linePaint..color = Colors.greenAccent;
    canvas.drawPath(path2, _linePaint);
    List<Offset> points3 = [];
    List<Offset> points4 = [];
    List<Offset> pointsX = [];
    pointsX.add(Offset(p0X, p0Y));
    pointsX.add(Offset(p0X+unitX*4, p0Y-unitY*4));
    pointsX.add(Offset(p0X+unitX*8, p0Y));
    pointsX.add(Offset(p0X+unitX*12, p0Y+unitY*4));
    pointsX.add(Offset(p0X+unitX*16, p0Y));
    _basePaint..color=Colors.cyanAccent;
    canvas.drawPoints(PointMode.points, pointsX, _basePaint);
    for (int i = 0; i < count; i++) {
      canvas.drawLine(Offset(startX, startY - (_disHeight / count) * i), Offset(endX, startY - (_disHeight / count) * i), xPaint);
      canvas.drawLine(Offset(startX + (_disWidth / count) * i, startY), Offset(startX + (_disWidth / count) * i, endY), yPaint);
      _axisTextPaint.text = TextSpan(text: i.toString(),style: TextStyle(color: Colors.deepPurpleAccent));
      _axisTextPaint.layout();
      _axisTextPaint.paint(
          canvas, Offset(startX-_axisTextPaint.width,i==0?startY:startY - (_disHeight / count) * i-_axisTextPaint.height/2));
      _axisTextPaint.paint(
          canvas, Offset(i==0?startX-_axisTextPaint.width:startX + (_disWidth / count) * i-_axisTextPaint.width/2, startY));
      if (i <= 4) {
        points3.add(Offset(startX + unitX * i, p0Y - i * unitY));
      } else if (i > 4 && i <= 12) {
        points3.add(Offset(startX + unitX * i, p0Y - 4 * unitY + (i - 4) * unitY));
      } else {
        points3.add(Offset(startX + unitX * i, p0Y + 4 * unitY - (i - 12) * unitY));
      }
    }
    _basePaint..color=Colors.brown..strokeWidth=7;
    canvas.drawPoints(PointMode.points, points3, _basePaint);
    _basePaint..color=Colors.orange;
    canvas.drawPoints(PointMode.points, points4, _linePaint);
    final path3 = Path();
    Path path4 = Path();
    Path path5 = Path();
    // path3.moveTo(points4[0].dx, points4[0].dy);
    path3.moveTo(points3[0].dx, points3[0].dy);
    path4.moveTo(points3[0].dx, points3[0].dy);

    Offset a = points3[0];
    Offset b = points3[0];
    Offset c = points3[1];
    var factor=0.1;
    for (int i = 1; i < points3.length; i++) {
      double x1 = (c.dx - a.dx) * factor + b.dx;
      double y1 = (c.dy - a.dy) * factor + b.dy;
      a = b;
      b = c;
      c = points3[min(points3.length - 1, i + 1)];
      double x2 = (a.dx - c.dx) * factor + b.dx;
      double y2 = (a.dy - c.dy) * factor + b.dy;
      path3.cubicTo(x1, y1, x2, y2, b.dx, b.dy);
    }
    path4=generatePath(points3, 0.1, path4);
    // points4.add(Offset(unitX,unitY*8));
    path5.moveTo(unitX*2,unitY*2);
    points4.add(Offset(unitX*2,unitY*2));
    points4.add(Offset(unitX*4,unitY*8));
    // points4.add(Offset(unitX*4.5,unitY*6));
    points4.add(Offset(unitX*10,unitY*2));
    points4.add(Offset(unitX*16,unitY*8));
    path5=generatePath(points4, 0.35, path5);

    // for (int i = 1; i < points4.length - 2; i++) {
    //   final x0 = points4[i].dx;
    //   final y0 = points4[i].dy;
    //   final x1 = points4[i + 1].dx;
    //   final y1 = points4[i + 1].dy;
    //
    //   final cx0 = x0 + (x1 - points4[i - 1].dx) / 6;
    //   final cy0 = y0 + (y1 - points4[i - 1].dy) / 6;
    //   final cx1 = x1 - (points4[i + 2].dx - x0) / 6;
    //   final cy1 = y1 - (points4[i + 2].dy - y0) / 6;
    //
    //   if(i%4==0){
    //
    //   path3.cubicTo(cx0, cy0, cx1, cy1, x1, y1);
    //   }
    // }
    _linePaint..color=Colors.blue..strokeWidth=10..strokeCap=StrokeCap.round..strokeJoin=StrokeJoin.round;
    canvas.drawPath(path3, _linePaint);
    _linePaint..color=Colors.cyanAccent..strokeWidth=2..strokeCap=StrokeCap.round..strokeJoin=StrokeJoin.round;
    canvas.drawPath(path4, _linePaint);
    _linePaint..color=Colors.lightGreen..strokeWidth=2..strokeCap=StrokeCap.round..strokeJoin=StrokeJoin.round;
    canvas.drawPath(path5, _linePaint);
  }

  Path generatePath(List<Offset> points3,double factor, Path path4) {
    var temp=Offset.zero;
     for(int i = 1; i < points3.length; i++){
     var current = Offset(points3[i].dx,points3[i].dy);
     var pre = Offset(points3[i-1].dx,points3[i-1].dy);
     var next = Offset(points3[i+1<points3.length?i+1:i].dx,points3[i+1<points3.length?i+1:i].dy);
     var control1 =pre+temp;
    temp =((next-pre)/2)*factor;
      debugPrint('next-pre=${next-pre}');
    if((next-pre).dx<=20){
      debugPrint('next-pre=${next-pre}走吗了');
      temp = Offset(0, temp.dy);
    }
     var control2 =current-temp;
     path4.cubicTo(control1.dx, control1.dy, control2.dx, control2.dy, current.dx, current.dy);
    }
     return path4;
  }

  _drawAxis(Canvas canvas) {
    canvas.drawLine(
        Offset(startX, startY), Offset(endX, startY), _axisPaint); //x轴
    canvas.drawLine(
        Offset(startX, startY), Offset(startX, endY), _axisPaint); //y轴
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
