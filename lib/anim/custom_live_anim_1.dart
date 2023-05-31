import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
class CustomLiveAnim extends StatefulWidget {
  const CustomLiveAnim({Key? key, required this.image,this.onAnimEnd}) : super(key: key);
  final ui.Image image;
  final Function? onAnimEnd;
  @override
  State<CustomLiveAnim> createState() => _CustomLiveAnimState();
}

class _CustomLiveAnimState extends State<CustomLiveAnim> with TickerProviderStateMixin{
  late Animation<double> mainAnimation;
  late AnimationController mainController;
  late AnimationController scaleController;
  Tween<double> scaleTween = Tween(begin: 0.0, end: 1.0);
  Tween<double> opacityTween = Tween(begin: 1.0, end: 0.0);
    late Animation _opacityAnimation;
  late Animation _translateAnimation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    debugPrint('hello=======${widget.key.toString()}');
     mainController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
         final curvedAnimation = CurvedAnimation(
        parent: mainController,
        curve:Interval(0.05, 1.0,curve: Curves.easeIn),
        reverseCurve: Curves.easeIn);
     _scaleAnimation= scaleTween.animate(CurveTween(curve: Interval(0, 0.05,curve: Curves.linear)).animate(mainController));
     _opacityAnimation= opacityTween.animate(CurveTween(curve: Interval(0.8, 0.85,curve: Curves.linear)).animate(mainController));
      mainAnimation = Tween(begin: 0.0, end: 1.0).animate(curvedAnimation)..addListener(() { 
        setState(() {
          
        });
      });
      mainController.forward();
      mainController.addStatusListener((status) {
      if (mainController.isCompleted) {
        widget.onAnimEnd?.call();
      }
    });
  }
  @override
  void dispose() {
    mainController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 400,
      child:CustomPaint(
      painter:CustomLiveAnimPainter(progress: mainAnimation.value,scaleProgress: _scaleAnimation.value,opacityProgress:_opacityAnimation.value, image:widget.image)
    ));
  }
}
class CustomLiveAnimPainter extends CustomPainter{
  late Paint _paint;
    // 对波浪区域进行X轴方向的偏移，实现滚动效果
  // final double offsetX;
    // 进度 [0-1]
  final double progress;
  final double scaleProgress;
  final double opacityProgress;
  // 波浪的曲度
  final double waveHeight;
  final ui.Image image;
  CustomLiveAnimPainter({required this.progress,required this.image,this.scaleProgress=1.0,this.opacityProgress=1.0,this.waveHeight = 15});
  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
    drawWave(canvas, size.center(Offset(0, 0)), size.width / 2, _paint,size);
  }
  _initPaint() {
    _paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.red.withOpacity(0.8);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

   void drawWave(Canvas canvas, Offset center, double radius, Paint paint,Size size) {
   Rect srcRect=Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    if(scaleProgress<1.0){
    canvas.save();
    canvas.drawImageRect(image, srcRect, Rect.fromCenter(center: Offset(center.dx, size.height-30/2), width: 30*scaleProgress, height: 30*scaleProgress), paint);
    canvas.restore();
    }else{

    // 反向计算点的纵坐标
    // double wavePointY = (1 - progress) * radius * 2;
    double wavePointX=(1-0.5)*radius*2;//改为纵向的
    // debugPrint('centerX=${center.dx},centerY=${center.dy},wavePointX=${wavePointX}');

//每个点相隔一个radius
    double y1 = size.height;
    double cy1 = size.height - 2 / radius;
    double count = size.height / radius;
    double y2 = size.height - radius;
    int cCount=(count+0.5)>count.ceil()?count.ceil():count.floor();
    List<Offset> list=[];
    List<Offset> cList=[];
    for(int i=0;i<=cCount;i++){
      list.add(Offset(wavePointX,size.height-i*radius));
    }
    for(int i=0;i<cCount;i++){
      if(i%2==0){
      cList.add(Offset(wavePointX-waveHeight,size.height-(i+0.5)*radius));
      }else{
      cList.add(Offset(wavePointX+waveHeight,size.height-(i+0.5)*radius));
      }
    }
    // debugPrint('count=$count,cCount=$cCount,cList.size=${cList.length},list.size=${list.length},cC0=${cList[0]},${cList[1]},list=${list[0]},${list[1]},${list[2]},radius=$radius');
    Path _path=Path();
    _path.moveTo(wavePointX, y1);
    for(int i=1;i<list.length;i++){
      _path.quadraticBezierTo(cList[i-1].dx, cList[i-1].dy, list[i].dx, list[i].dy);
    }
     // canvas.drawRect(Rect.fromCenter(center: cList[0], width: 10, height: 10), paint..color=Colors.yellowAccent);
     // canvas.drawRect(Rect.fromCenter(center: cList[1], width: 10, height: 10), paint..color=Colors.yellowAccent);
     // canvas.drawRect(Rect.fromCenter(center: cList[2], width: 10, height: 10), paint..color=Colors.yellowAccent);
     // canvas.drawRect(Rect.fromCenter(center: list[0], width: 10, height: 10), paint..color=Colors.tealAccent);
     // canvas.drawRect(Rect.fromCenter(center: list[1], width: 10, height: 10), paint..color=Colors.tealAccent);
     // canvas.drawRect(Rect.fromCenter(center: list[2], width: 10, height: 10), paint..color=Colors.tealAccent);
     // canvas.drawRect(Rect.fromCenter(center: list[3], width: 10, height: 10), paint..color=Colors.tealAccent);
     // canvas.drawPath(_path, paint..color=Colors.indigo);
     var _measure=_path.computeMetrics().first;
     final _position = _measure.getTangentForOffset(_measure.length * progress);
     if(_position!=null){
      //  debugPrint('position====${opacityProgress}');
      //  canvas.drawImage(image, _position.position-Offset(image.width/2.0,image.height/1.0), Paint()..isAntiAlias=true..color=Color.fromRGBO(255,0, 0, opacityProgress));
      // Rect srcRect=Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
      Rect dstRect=Rect.fromLTWH(0,0,30, 30);
      final offsetDstRect=dstRect.translate(_position.position.dx-30/2, _position.position.dy-30/1.0);
       canvas.drawImageRect(image,srcRect,offsetDstRect, Paint()..isAntiAlias=true..color=Color.fromRGBO(255,0, 0, opacityProgress));
       // canvas.drawLine(Offset(size.width/2,0), Offset(size.width/2,size.height/2), paint);
       // canvas.drawLine(Offset(0,size.height/2), Offset(size.width/2,size.height/2), paint);
     }

    

    // point3为中心点，波浪的直径为圆的半径，一共5个点，加上两个闭环点（p六、p7）
    // Offset point1 = Offset(wavePointX,center.dy - radius * 3);
    // Offset point2 = Offset(wavePointX,center.dy - radius * 2);
    // Offset point3 = Offset(wavePointX,center.dy - radius);
    // Offset point4 = Offset(wavePointX,center.dy);
    // Offset point5 = Offset(wavePointX,center.dy + radius);
    // canvas.drawRect(Rect.fromCenter(center: Offset(wavePointX,0), width: 20, height: 20), paint..color=Colors.purpleAccent);
    // canvas.drawRect(Rect.fromCenter(center: Offset(wavePointX,size.height), width: 20, height: 20), paint..color=Colors.pink);
    // canvas.drawRect(Rect.fromCenter(center: point1, width: 10, height: 10), paint..color=Colors.blue);
    // canvas.drawRect(Rect.fromCenter(center: point2, width: 10, height: 10), paint..color=Colors.white);
    // canvas.drawRect(Rect.fromCenter(center: point3, width: 10, height: 10), paint..color=Colors.yellow);
    // canvas.drawRect(Rect.fromCenter(center: point4, width: 10, height: 10), paint..color=Colors.pink);
    // canvas.drawRect(Rect.fromCenter(center: point5, width: 10, height: 10), paint..color=Colors.amber.shade700);

    // // Offset point6 = Offset(point5.dx, center.dy + radius + waveHeight);
    // // Offset point7 = Offset(point1.dx, center.dy + radius + waveHeight);

    // // 贝塞尔曲线控制点
    // Offset c1 =
    //     Offset(wavePointX + waveHeight,center.dy - radius * 2.5);
    // Offset c2 =
    //     Offset(wavePointX - waveHeight,center.dy - radius * 1.5);
    // Offset c3 =
    //     Offset(wavePointX + waveHeight,center.dy - radius * 0.5);
    // Offset c4 =
    //     Offset(wavePointX - waveHeight,center.dy + radius * 0.5);

    // // 链接贝塞尔曲线
    // Path wavePath = Path()
    //   ..moveTo(point3.dx, point3.dy)
    //   // ..quadraticBezierTo(c1.dx, c1.dy, point2.dx, point2.dy)
    //   // ..quadraticBezierTo(c2.dx, c2.dy, point3.dx, point3.dy)
    //   ..quadraticBezierTo(c3.dx, c3.dy, point4.dx, point4.dy)
    //   ..quadraticBezierTo(c4.dx, c4.dy, point5.dx, point5.dy);

    // // 绘制
    // canvas.drawPath(wavePath, paint..color=Colors.red);
    //   canvas.drawPoints(
    //     ui.PointMode.points,
    //     [
    //       point1,
    //       point2,
    //       point3,
    //       point4,
    //       point5,
    //       // point6,
    //       // point7,
    //       c1,
    //       c2,
    //       c3,
    //       c4
    //     ],
    //     paint..color = Colors.blue);
    // var measure=wavePath.computeMetrics().first;
    //   final position = measure.getTangentForOffset(measure.length * progress);
    // if(position!=null){
    // canvas.drawImage(image, position.position-Offset(image.width/2.0,image.height/2.0), Paint()..isAntiAlias=true..color=Color.fromRGBO(255,0, 0, opacityProgress));
    // canvas.drawLine(Offset(size.width/2,0), Offset(size.width/2,size.height/2), paint);
    // canvas.drawLine(Offset(0,size.height/2), Offset(size.width/2,size.height/2), paint);
    // }
    }
  }

}