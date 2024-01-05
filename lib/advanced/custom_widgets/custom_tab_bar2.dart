import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/basic/material_components/tab_bar_page.dart';
import 'package:flutter_study_list/util/asset_utils.dart';
import 'package:flutter_study_list/widget/KFButton.dart';

enum TabType { notch, raised, none }

class CustomTabBar2 extends StatefulWidget {
  CustomTabBar2(
      {Key? key,
      this.hasCorner = false,
      this.borderRadius = 10,
      this.centerOffsetY = 10,
      this.tabType = TabType.none,
      this.topLeft = 0,
      this.topRight = 0,
      this.bottomLeft = 0,
      this.bottomRight = 0})
      : super(key: key);
  bool hasCorner;
  double borderRadius;
  double centerOffsetY;
  TabType tabType;
  double topLeft;
  double topRight;
  double bottomLeft;
  double bottomRight;

  @override
  State<CustomTabBar2> createState() => _CustomTabBar2State();
}

class _CustomTabBar2State extends State<CustomTabBar2> {
  final List<Map<String, dynamic>> _bottomTabList = [
    {
      'icon': 'emoji13',
      'title': 'Hello',
      'checked': true,
      'enableAnim': false,
      'curve': Curves.easeInCirc
    },
    {
      'icon': 'emoji2',
      'title': 'Flutter',
      'checked': false,
      'enableAnim': false,
      'curve': Curves.easeInCirc
    },
    {
      'icon': 'emoji3',
      'title': 'Android',
      'checked': false,
      'enableAnim': false,
      'curve': Curves.easeInCirc
    },
    {
      'icon': 'emoji4',
      'title': 'iOS',
      'checked': false,
      'enableAnim': false,
      'curve': Curves.easeInCirc
    },
    {
      'icon': 'emoji15',
      'title': 'World',
      'checked': false,
      'enableAnim': false,
      'curve': Curves.easeInCirc
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;
    debugPrint("${MediaQuery.of(context).size.width}");
    return Stack(
      children: [
        Container(
          width: sw,
          height: 128,
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.green,),
          child: CustomPaint(
            painter: CustomTabBarPainter(
                hasCorner: widget.hasCorner,
                borderRadius: widget.borderRadius,
                centerOffsetY: widget.centerOffsetY,
                tabType: widget.tabType,
                topLeft: widget.topLeft,
                topRight: widget.topRight,
                bottomLeft: widget.bottomLeft,
                bottomRight: widget.bottomRight),
          ),
        ),
        Container(
          width: sw,
          height: 128,
          alignment: Alignment.bottomCenter,
          // color: Colors.red,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double realWidth = constraints.maxWidth;
            print('Inner container width: $realWidth');
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _bottomTabList.map((e) {
                var index = _bottomTabList.indexOf(e);
                var middle = _bottomTabList.length ~/ 2;
                print('Inner container width:$index $middle');
                if (index == middle) {
                  return Container(width: realWidth / 5.2 * 1.2, height: 64);
                }
                return CustomBottomTab(
                    // color: index%2==0?Colors.red:Colors.cyanAccent,
                    tabHeight: 64,
                    tabWidth: index == middle
                        ? realWidth / 5.2 * 1.2
                        : realWidth / 5.2,
                    iconName: e['icon'],
                    title: e['title'],
                    isChecked: e['checked'],
                    enableAnim: e['enableAnim'],
                    curve: e['curve'],
                    onTap: () {
                      var index = _bottomTabList.indexOf(e);
                      for (int i = 0; i < _bottomTabList.length; i++) {
                        if (index == i) {
                          setState(() {
                            _bottomTabList[i]['checked'] = true;
                            _bottomTabList[i]['enableAnim'] = true;
                          });
                        } else {
                          setState(() {
                            _bottomTabList[i]['checked'] = false;
                            _bottomTabList[i]['enableAnim'] = false;
                          });
                        }
                      }
                    });
              }).toList(),
            );
          }),
        ),
        Positioned(
            left: (sw - 20) / 2 - 64 / 2,
            bottom: 32,
            child: Container(
              width: 64,
              height: 64,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  32,
                ),
                color: Color(0xff7FC7D9),
              ),
              child: Image.asset(AssetUtils.getAssetImagePNG('emoji16')),
            ))
      ],
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
  double topLeft;
  double topRight;
  double bottomLeft;
  double bottomRight;
  double centerOffsetY;
  TabType tabType;

  CustomTabBarPainter(
      {this.padding = 0,
      this.hasCorner = false,
      this.borderRadius = 10,
      this.centerOffsetY = 10,
      this.tabType = TabType.none,
      this.topLeft = 0,
      this.topRight = 0,
      this.bottomLeft = 0,
      this.bottomRight = 0});

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
      ..isAntiAlias = true
      ..blendMode;
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
    } else if (centerOffsetY >= _R / 4 * 3) {
      centerOffsetY = _R / 4 * 3;
    }

//     canvas.saveLayer(Offset.zero & size, Paint()); // 新建层
//     _paint..color = Color(0xffAAD7D9)..style=PaintingStyle.fill;
//     canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(startX, centerY, _disWidth, _disHeight/2)), _paint);
//     _paint..color = Colors.red..blendMode=BlendMode.clear;
//     canvas.drawCircle(Offset(centerX, centerY), _R, _paint);
// canvas.restore();
    if (tabType == TabType.none) {
      _paint
        ..color = Color(0xffAAD7D9)
        ..style = PaintingStyle.fill
        ..isAntiAlias = true;
      canvas.drawRRect(
          RRect.fromRectAndCorners(
              Rect.fromLTWH(startX, centerY, _disWidth, _disHeight / 2),
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
              bottomLeft: Radius.circular(bottomLeft),
              bottomRight: Radius.circular(bottomRight)),
          _paint);
    } else if (tabType == TabType.notch) {
      // canvas.saveLayer(Offset.zero & size, Paint()..isAntiAlias=true); // 新建层
      var _paintX = Paint()
        ..color = Color(0xffAAD7D9)
        ..style = PaintingStyle.fill
        // ..strokeWidth=1
        ..isAntiAlias = true;
      canvas.saveLayer(Rect.fromLTWH(startX, endY, _disWidth, _disHeight),
          _paintX); // 新建层

      canvas.drawRRect(
          RRect.fromRectAndCorners(
              Rect.fromLTWH(startX, centerY, _disWidth, _disHeight / 2),
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
              bottomLeft: Radius.circular(bottomLeft),
              bottomRight: Radius.circular(bottomRight)),
          _paintX);
      _paintX
        ..color = Color(0xffAAD7D9)
        ..blendMode = BlendMode.srcOut;
      canvas.drawArc(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: _R),
          pi,
          -pi,
          true,
          _paintX);
      canvas.restore();
    } else {
      // canvas.saveLayer(Offset.zero & size, Paint()..isAntiAlias=true); // 新建层
      var _paintX = Paint()
        ..color = Color(0xffAAD7D9)
        ..style = PaintingStyle.fill
        ..isAntiAlias = true;
      canvas.drawRRect(
          RRect.fromRectAndCorners(
              Rect.fromLTWH(startX, centerY, _disWidth, _disHeight / 2),
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
              bottomLeft: Radius.circular(bottomLeft),
              bottomRight: Radius.circular(bottomRight)),
          _paintX);
      // _paint..color = Colors.red..blendMode=BlendMode.src;
      canvas.drawCircle(Offset(centerX, centerY), _R, _paintX);
      // canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
