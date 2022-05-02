import 'dart:ui';

import 'package:flutter/material.dart';

class LineChatPainter extends CustomPainter {
  late Paint _outlinePaint, _axisXPaint, _valuePaint,_testPaint;
  late TextPainter _leftlabelPainter;
  List<int> _yTitle = [40, 30, 20, 10, 0, -10];
  List<double> _yData =  [29.2, 29.8, 35.3, 29.2, 29.4, 29.1, 29.3, 10.2, 29.5, 29.2, 29.2, 29, 29.3, 29.2, 29.4, 29.1, 29.3, 29.2, 29.5, 29.2];
  final int averageY = 5;
  final int gapY = 10;
  final double _yTitlePadding = 5;
  LineChatPainter({Listenable? repaint})
      : super(repaint: repaint) {
    _outlinePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    _axisXPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    _valuePaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeCap=StrokeCap.round
      ..strokeWidth = 2
      ..isAntiAlias=true;
    _leftlabelPainter = TextPainter()..textDirection = TextDirection.ltr;
    _testPaint=Paint()
    ..color=Colors.yellow
    ..style=PaintingStyle.stroke
    ..strokeWidth=1;
  }
  @override
  void paint(Canvas canvas, Size size) {
    print('${this},,,$size');
    var tempHeight=size.height-20;
    canvas.drawRect(Rect.fromLTRB(0, 20, size.width, size.height), _outlinePaint);
    // double textWidth=0;
    // for (var i = 0; i < _yData.length; i++) {
    //   _leftlabelPainter.text=TextSpan(text:i==_yData.length-1?'${_yData[i]}':'${_yData[i]},',style: TextStyle(color: Colors.red));
    //   _leftlabelPainter.layout();
    //   if(i>0){
    //   textWidth+=_leftlabelPainter.width;
    //   }
    //   if(i>_yData.length/2){
    //   _leftlabelPainter.paint(canvas, Offset(textWidth,_leftlabelPainter.height/2*3));
    //   if(i==_yData.length/2+1){textWidth=0;}
    //   }else{
    //   _leftlabelPainter.paint(canvas, Offset(textWidth,_leftlabelPainter.height/2));
    //   }
      
    // }
    for (var i = 0; i < 4; i++) {
      print('size.height-20/averageY*(i+1)=${i}=${tempHeight/averageY*(i+1)}');
      canvas.drawLine(Offset(0,tempHeight/averageY*(i+1)+20), Offset(size.width,tempHeight/averageY*(i+1)+20), _axisXPaint);
    }
    canvas.drawLine(Offset(0,0), Offset(size.width/2,0), _testPaint);
    canvas.drawLine(Offset(0,50), Offset(size.width/2,50), _testPaint);
    for (var i = 0; i <=5; i++) {
      _leftlabelPainter.text=TextSpan(text:(tempHeight/averageY*(i)+20).toString(),style: TextStyle(color: Colors.deepPurpleAccent));
      _leftlabelPainter.layout();
      _leftlabelPainter.paint(canvas, Offset(0,tempHeight/5*i-_leftlabelPainter.height/2+20));
      _leftlabelPainter.text=TextSpan(text:_yTitle[i].toString(),style: TextStyle(color: Colors.red));
      _leftlabelPainter.layout();
      print('_leftlabelPainter.width=${i}====${_leftlabelPainter.width},,,${tempHeight/5*i}');
      _leftlabelPainter.paint(canvas, Offset(-_leftlabelPainter.width,tempHeight/5*i-_leftlabelPainter.height/2+20));
    }
    var points = <Offset>[];
    for (var i = 0; i < _yData.length; i++) {
      points.add(Offset(size.width/_yData.length*i,translateValue(size.height,_yData[i])));
    }
    canvas.drawPoints(PointMode.polygon, points, _valuePaint);
    canvas.drawPoints(PointMode.points, points, Paint()..color=Colors.green..style=PaintingStyle.stroke..strokeWidth=5..strokeCap=StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant LineChatPainter oldDelegate) {
    return oldDelegate._yData!=_yData;
  }
  double translateValue(double height,double rawValue){
    var temp=(height-20)/5;
    var valueSum=averageY*gapY;
    var scale = (height-20)/valueSum;//1个数据是多高
    var reslut = rawValue*scale;
    print('reslut==$reslut,height=$height');
    // return height-reslut-height/averageY;
    return height-temp-reslut;

  }
  
}