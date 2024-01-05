import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
enum TabType{
  notch,
  raised,
  none
}
class CustomTabBar2 extends StatefulWidget {
  CustomTabBar2(
      {Key? key,
      this.hasCorner = false,
      this.borderRadius = 10,
      this.centerOffsetY = 10,
      this.tabType=TabType.none})
      : super(key: key);
  bool hasCorner;
  double borderRadius;
  double centerOffsetY;
  TabType tabType;

  @override
  State<CustomTabBar2> createState() => _CustomTabBar2State();
}

class _CustomTabBar2State extends State<CustomTabBar2> {
  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;
    return Container(
      width: sw,
      height: 128,
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.green,),
      child: CustomPaint(
        painter: CustomTabBarPainter(
            hasCorner: widget.hasCorner,
            borderRadius: widget.borderRadius,
            centerOffsetY: widget.centerOffsetY,
            tabType: widget.tabType),
      ),
    );
  }
}

class CustomTabBarPainter extends CustomPainter {
  late Paint _paint, _axisPaint;
  late double startX, endX, startY, endY, _currentCenterX, _currentCenterY;
  late double _disWidth, _disHeight;
  final Path _path = Path();
  double padding;
  bool hasCorner;
  double borderRadius;
  double centerOffsetY;
  TabType tabType;
  CustomTabBarPainter(
      {this.padding = 0,
      this.hasCorner = false,
      this.borderRadius = 10,
      this.centerOffsetY = 10,this.tabType=TabType.none});

  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
    _initAxis(size);
    // _drawAxisLine(canvas);
    _drawCanvas(canvas, size);
  }

  _initPaint() {
    _paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true..blendMode;
    _axisPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;
  }

  _initAxis(Size size) {
    startX = padding;
    endX = size.width - padding;
    startY = size.height - padding;
    endY = padding;
    _disWidth = endX - startX;
    _disHeight = startY - endY;
  }

  void _drawAxisLine(Canvas canvas) {
    canvas.drawLine(
        Offset(startX, startY), Offset(endX, startY), _axisPaint); //x轴
    canvas.drawLine(
        Offset(startX, startY), Offset(startX, endY), _axisPaint); //y轴
  }

  _drawCanvas(Canvas canvas, Size size) {
    var centerX = startX + _disWidth / 2;
    var centerY = endY + _disHeight / 2;
    var moduleWidth = size.width / 5.2;
    // var _R = size.width/5.2*1.2/2;
    double _R = size.width / 5.2 * 1.2 / 2;
    // debugPrint('chazhi===${_R-_r},,$_R');
    var _circleRadius = size.width / 5.2 / 2; //图标所在圆
    _path.moveTo(startX, endY + _disHeight / 2);
    if (centerOffsetY <= 0) {
      centerOffsetY = 0;
    } else if (centerOffsetY >= _R/4*3) {
      centerOffsetY = _R/4*3;
    }

//     canvas.saveLayer(Offset.zero & size, Paint()); // 新建层
//     _paint..color = Color(0xffAAD7D9)..style=PaintingStyle.fill;
//     canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(startX, centerY, _disWidth, _disHeight/2)), _paint);
//     _paint..color = Colors.red..blendMode=BlendMode.clear;
//     canvas.drawCircle(Offset(centerX, centerY), _R, _paint);
// canvas.restore();
    if(tabType==TabType.none){
      _paint..color = Color(0xffAAD7D9)..style=PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(startX, centerY, _disWidth, _disHeight/2)), _paint);
    }else if(tabType==TabType.notch){
      canvas.saveLayer(Offset.zero & size, Paint()); // 新建层
      _paint..color = Color(0xffAAD7D9)..style=PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(startX, centerY, _disWidth, _disHeight/2)), _paint);
      _paint..color = Colors.red..blendMode=BlendMode.srcOut;
      canvas.drawArc(Rect.fromCircle(center: Offset(centerX, centerY), radius: _R), pi,-pi,true,_paint);
      canvas.restore();
    }else{
    canvas.saveLayer(Offset.zero & size, Paint()); // 新建层
    _paint..color = Color(0xffAAD7D9)..style=PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(startX, centerY, _disWidth, _disHeight/2)), _paint);
    // _paint..color = Colors.red..blendMode=BlendMode.src;
    canvas.drawCircle(Offset(centerX, centerY), _R, _paint);
    canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
