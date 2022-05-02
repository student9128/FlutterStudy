import 'package:flutter/material.dart';

class CustomLine extends CustomPainter{
  static const double _mPadding=20;
  late double startX,endX,startY,endY;
  late double _disWidth,_disHeight;
  late Paint _axisPaint,_linePaint;
  late TextPainter _axisTextPaint;
  int rulerCount=16;
  final Path _path = Path();
  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
    _initAxisLine(size);
    _drawRulerAndText(canvas);
    _drawLine(canvas);
    _drawAxisLine(canvas);
  }

  _initPaint() {
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
    _axisTextPaint=TextPainter(textAlign: TextAlign.center,ellipsis:'.')
    ..textDirection=TextDirection.ltr;
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
  _drawRulerAndText(Canvas canvas) {
    double _dis = _disWidth / rulerCount;
    for (var i = 0; i < rulerCount; i++) {
      canvas.drawLine(Offset(startX + _dis * (i), startY),
          Offset(startX + _dis * (i), startY - 10), _axisPaint); //x轴
      canvas.drawLine(Offset(startX, startY - _dis * (i)),
          Offset(startX + 10, startY - _dis * (i)), _axisPaint);
      _axisTextPaint.text =
          TextSpan(text: i.toString(), style: TextStyle(color: Colors.amber));
      _axisTextPaint.layout(minWidth: _dis, maxWidth: _dis);
      if(i==0){
_axisTextPaint.paint(canvas, Offset(startX-_axisTextPaint.width,startY));
      }else{
      _axisTextPaint.paint(canvas,
          Offset(startX + _dis * i - _axisTextPaint.width / 2, startY)); //x轴
      _axisTextPaint.paint(
          canvas,
          Offset(startX - _axisTextPaint.width,
              startY - _dis * i - _axisTextPaint.height / 2)); //y轴
      }
      _initPath(i, _dis,canvas);
     
    }
  }
  _initPath(int index, double scale,Canvas canvas) {
    // print('index=$index,scale=$scale');
    if (index == 0) {
      _path.moveTo(startX, startY);
    } else {
      var tempX = startX + scale * index;
      var tempY = startY - (index % 2 == 0 ? scale : scale * 12);
      // _path.lineTo(tempX, tempY);
      var preX = startX + scale * (index - 1);
      var preY = startY - (index % 2 != 0 ? scale : scale * 12);
      _path.cubicTo(
          (tempX + preX) / 2, preY, (preX + tempX) / 2, tempY, tempX, tempY);
    }
  }
  _drawLine(Canvas canvas){
    var pathMetrics = _path.computeMetrics();
    var list = pathMetrics.toList();
    var length = list.length;
    print('length=$length');
    Path path = Path();
    for (var i = 0; i < length; i++) {
      var extractPath=list[i].extractPath(0, list[i].length,startWithMoveTo: true);
      path.addPath(extractPath, Offset(0,0));
    }
    _drawShader(canvas, path);
    canvas.drawPath(path, _linePaint);
  }
  _drawShader(Canvas canvas,Path shadowPath){
    var shader = LinearGradient(colors:[Colors.red,Colors.green,Colors.blue,Colors.yellow.withOpacity(0.5)],
    begin: Alignment.topCenter,end: Alignment.bottomCenter).createShader(Rect.fromLTRB(startX,endY, endX, startY));
    shadowPath..lineTo(startX+_disWidth, startY)
    ..lineTo(startX, startY)
    ..close();
    canvas.drawPath(shadowPath, Paint()..shader=shader..isAntiAlias=true..style=PaintingStyle.fill);
    

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return true;
  }
  
}