import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  CustomTabBar(
      {Key? key,
      this.hasCorner = false,
      this.borderRadius = 10,
      this.centerOffsetY = 0})
      : super(key: key);
  bool hasCorner;
  double borderRadius;
  double centerOffsetY;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;
    return Container(
      width: sw,
      height: 128,
      child: CustomPaint(
        painter: CustomTabBarPainter(
            hasCorner: widget.hasCorner,
            borderRadius: widget.borderRadius,
            centerOffsetY: widget.centerOffsetY),
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

  CustomTabBarPainter(
      {this.padding = 0,
      this.hasCorner = false,
      this.borderRadius = 10,
      this.centerOffsetY = 0});

  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
    _initAxis(size);
    _drawAxisLine(canvas);
    _drawCanvas(canvas, size);
  }

  _initPaint() {
    _paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;
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
    double _r = 10;
    // var _R = size.width/5.2*1.2/2;
    double _R = size.width / 5.2 * 1.2 / 2;
    // debugPrint('chazhi===${_R-_r},,$_R');
    var _circleRadius = size.width / 5.2 / 2; //图标所在圆
    var points = <Offset>[];
    points.add(Offset(startX, startY));
    points.add(Offset(endX, startY));
    points.add(Offset(endX, endY));
    var pointX1 = startX + _disWidth / 2 + _R;
    var pointY1 = endY;
    var pointX2 = startX + _disWidth / 2 - _R;
    var pointY2 = endY;
    var pointX3 = startX + _disWidth / 2;
    var pointY3 = endY + _disHeight / 2;
    points.add(Offset(pointX1, pointY1));
    points.add(Offset(pointX3, pointY3));
    points.add(Offset(pointX2, pointY2));
    // var centerX = startX+_disWidth/2;
    // var centerY = startY-_disHeight/2;
    // points.add(Offset(centerX, centerY));

    points.add(Offset(startX, endY));
    _path.moveTo(startX, endY + _disHeight / 2);
    if(centerOffsetY>_R+_r){
      // if(centerOffsetY>=_R+_r){
      //   _r=10;
      // }else if (centerOffsetY-_R <_r) {
      //   _r = _r - (1 - ( (centerOffsetY-_R) / _r) * _r);
      // }
      // if(hasCorner){
      //   var _corderRadiusCenterY = centerY - _r;
      //   var yy=_r*2+_R-centerOffsetY;
      //   var _corderRadiusCenterX =
      //       centerX - sqrt((_r + _R) * (_r + _R) - yy*yy);
      //   var _corderRadiusCenterX2 =
      //       centerX + sqrt((_r + _R) * (_r + _R) - yy*yy);
      //   var _currentCenterY = centerY+_R-(centerOffsetY-(_R+_r));//大圆圆心坐标
      //   debugPrint('center=sY=$startY,endY=$endY,R=$_R,r=$_r,centerY=$centerY,offsetY=$centerOffsetY,_corderRadiusCenterY=${_corderRadiusCenterY},_currentCenterY=${_currentCenterY}');
      //   var h = _currentCenterY-_corderRadiusCenterY;
      //   _path.arcTo(Rect.fromCircle(center: Offset(_corderRadiusCenterX, _corderRadiusCenterY), radius:_r), pi/2, -pi / 2 + asin(centerOffsetY / (_r + _R)), false);
      //   _path.arcTo(Rect.fromCircle(center: Offset(centerX,  _currentCenterY), radius: _R),pi+acos((centerX-_corderRadiusCenterX)/(_R+_r)),asin((centerX-_corderRadiusCenterX)/(_R+_r))*2, false);
      //   _path.arcTo(Rect.fromCircle(center: Offset(_corderRadiusCenterX2, _corderRadiusCenterY), radius:_r), pi/2, -pi / 2 + asin(centerOffsetY / (_r + _R)), false);
      //
      // }

    }else{
      // if (centerOffsetY > _R) {
      //   _r = _r - (1 - ((_R - centerOffsetY) / _r) * _r);
      //   // _r = _r*_r;
      // }
      var _corderRadiusCenterY = centerY + _r;
      if (hasCorner) {
        var _corderRadiusCenterX =
            centerX - sqrt((_r + _R) * (_r + _R) - centerOffsetY * centerOffsetY);
        var _corderRadiusCenterX2 =
            centerX + sqrt((_r + _R) * (_r + _R) - centerOffsetY * centerOffsetY);
        debugPrint('centerX===$_R=$centerOffsetY=$_corderRadiusCenterX,${asin(centerOffsetY / (_r + _R))},${pi / 2 - asin(centerOffsetY / (_r + _R))}');
        _path.arcTo(Rect.fromCircle(center: Offset(_corderRadiusCenterX, _corderRadiusCenterY), radius:_r), -pi / 2, pi / 2 - asin(centerOffsetY / (_r + _R)), false);
        _path.arcTo(Rect.fromCircle(center: Offset(centerX, _corderRadiusCenterY - centerOffsetY), radius: _R), pi - asin(centerOffsetY / _R), -pi + asin(centerOffsetY / _R) * 2, false);
        _path.arcTo(
            Rect.fromCircle(
                center: Offset(_corderRadiusCenterX2, _corderRadiusCenterY),
                radius: _r),
            pi + asin(centerOffsetY / _R),
            pi / 2 - asin(centerOffsetY / (_r + _R)),
            false);
      } else {
        _path.lineTo(centerX - _R, centerY);
        _path.arcTo(Rect.fromCircle(center: Offset(centerX, centerY), radius: _R),
            pi, -pi, false);
      }
    }

    _path.lineTo(endX, centerY);
    _path.lineTo(endX, startY);
    _path.lineTo(startX, startY);
    _path.close();
    // _path.addArc(Rect.fromCircle(center: Offset(startX+_disWidth/2-_R-10, endY+_disHeight/2+10), _R: 10),-pi/2,pi);
    // _path.addArc(Rect.fromCircle(center: Offset(startX+_disWidth/2, endY+_disHeight/2), _R: _R),pi,-pi);

    // _path.relativeLineTo(_disWidth/2-_R,0);
    // _path.relativeLineTo(0,_disHeight/2);
    // _path.relativeLineTo(-_disWidth,0);
    // _path.relativeLineTo(0,-_disHeight/2);
    _paint..color = Colors.red;
    canvas.drawPath(_path, _paint);
    pointX3 = pointX2 + 0.5 * (pointX1 - pointX2);
    pointY3 = endY + 0.5 * (0 - endY);

    final path = Path();
    path.moveTo(50, 50);
    path.relativeLineTo(100, 0);
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    path.arcTo(Rect.fromLTWH(150, 50, 100, 100), -pi / 2, pi / 2, false);
    paint..color = Colors.green;
    _paint..color = Colors.yellow;
    canvas.drawCircle(Offset(startX + _disWidth / 2, endY + _disHeight / 2),
        _circleRadius, _paint);
    _paint
      ..color = Colors.green
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawPoints(PointMode.points, points, _paint);
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(startX + _disWidth / 2, endY + _disHeight / 2), _R, _paint);
    canvas.drawCircle(Offset(centerX - _R - 10, centerY), 10, _paint);

    var pointsX = <Offset>[];
    pointsX.add(Offset(20, centerY+(centerOffsetY-(_R+_r))));
    pointsX.add(Offset(centerX, centerY+(centerOffsetY-(_R+_r))));
    var paintX=Paint()
      ..color = Colors.green
      ..strokeWidth = 1
      ..style = PaintingStyle.fill..isAntiAlias=true;
    canvas.drawPoints(PointMode.polygon, pointsX, paintX);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
