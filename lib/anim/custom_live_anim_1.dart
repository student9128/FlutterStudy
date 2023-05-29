import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
class CustomLiveAnim extends StatefulWidget {
  const CustomLiveAnim({ Key? key,required this.image }) : super(key: key);
final ui.Image image;
  @override
  State<CustomLiveAnim> createState() => _CustomLiveAnimState();
}

class _CustomLiveAnimState extends State<CustomLiveAnim> with TickerProviderStateMixin{
  late Animation<double> mainAnimation;
  late AnimationController mainController;
  @override
  void initState() {
    super.initState();
     mainController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
         final curvedAnimation = CurvedAnimation(
        parent: mainController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut);
      mainAnimation = Tween(begin: 0.0, end: 1.0).animate(curvedAnimation)..addListener(() { 
        setState(() {
          
        });
      });
      mainController.repeat();
  }
  @override
  void dispose() {
    mainController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter:CustomLiveAnimPainter(progress: mainAnimation.value, image:widget.image)
    );
  }
}
class CustomLiveAnimPainter extends CustomPainter{
  late Paint _paint;
    // 对波浪区域进行X轴方向的偏移，实现滚动效果
  // final double offsetX;
    // 进度 [0-1]
  final double progress;
  // 波浪的曲度
  final double waveHeight;
  final ui.Image image;
  CustomLiveAnimPainter({required this.progress,required this.image,this.waveHeight = 24});
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
    // 圆形裁剪
    // canvas.save();
    // Path clipPath = Path()
      // ..addOval(Rect.fromCircle(center: center, radius: radius));
    // canvas.clipPath(clipPath);

    // 反向计算点的纵坐标
    // double wavePointY = (1 - progress) * radius * 2;
    double wavePointX=(1-0.5)*radius*2;//改为纵向的
    debugPrint('centerX=${center.dx},centerY=${center.dy},wavePointX=${wavePointX}');
    

    // point3为中心点，波浪的直径为圆的半径，一共5个点，加上两个闭环点（p六、p7）
    Offset point1 = Offset(wavePointX,center.dy - radius * 3);
    Offset point2 = Offset(wavePointX,center.dy - radius * 2);
    Offset point3 = Offset(wavePointX,center.dy - radius);
    Offset point4 = Offset(wavePointX,center.dy);
    Offset point5 = Offset(wavePointX,center.dy + radius);
    canvas.drawRect(Rect.fromCenter(center: point1, width: 10, height: 10), paint..color=Colors.blue);
    canvas.drawRect(Rect.fromCenter(center: point2, width: 10, height: 10), paint..color=Colors.white);
    canvas.drawRect(Rect.fromCenter(center: point3, width: 10, height: 10), paint..color=Colors.yellow);
    canvas.drawRect(Rect.fromCenter(center: point4, width: 10, height: 10), paint..color=Colors.pink);
    canvas.drawRect(Rect.fromCenter(center: point5, width: 10, height: 10), paint..color=Colors.amber.shade700);

    // Offset point6 = Offset(point5.dx, center.dy + radius + waveHeight);
    // Offset point7 = Offset(point1.dx, center.dy + radius + waveHeight);

    // 贝塞尔曲线控制点
    Offset c1 =
        Offset(wavePointX + waveHeight,center.dy - radius * 2.5);
    Offset c2 =
        Offset(wavePointX - waveHeight,center.dy - radius * 1.5);
    Offset c3 =
        Offset(wavePointX + waveHeight,center.dy - radius * 0.5);
    Offset c4 =
        Offset(wavePointX - waveHeight,center.dy + radius * 0.5);

    // 链接贝塞尔曲线
    Path wavePath = Path()
      ..moveTo(point3.dx, point3.dy)
      // ..quadraticBezierTo(c1.dx, c1.dy, point2.dx, point2.dy)
      // ..quadraticBezierTo(c2.dx, c2.dy, point3.dx, point3.dy)
      ..quadraticBezierTo(c3.dx, c3.dy, point4.dx, point4.dy)
      ..quadraticBezierTo(c4.dx, c4.dy, point5.dx, point5.dy);
      // ..lineTo(point6.dx, point6.dy)
      // ..lineTo(point7.dx, point7.dy)
      // ..close();
      // Matrix4.compose(translation, rotation, scale)
      // Matrix4.fromList(values)
      // Matrix4.translationValues(x, y, z)
      // Matrix4.translation(translation)
      // Matrix4 m=Matrix4.identity();
      // m.add(o)
      // m.translate(x)

    // 绘制
    canvas.drawPath(wavePath, paint..color=Colors.red);
      canvas.drawPoints(
        ui.PointMode.points,
        [
          point1,
          point2,
          point3,
          point4,
          point5,
          // point6,
          // point7,
          c1,
          c2,
          c3,
          c4
        ],
        paint..color = Colors.blue);
    var measure=wavePath.computeMetrics().first;
      final position = measure.getTangentForOffset(measure.length * progress);
      //  final position = measure.getTangentForOffset(offsetX);
    if(position!=null){
      debugPrint('position====${position.position},point1=$point1');
    canvas.drawImage(image, position.position-Offset(image.width/2.0,image.height/2.0), Paint()..isAntiAlias=true);
    canvas.drawLine(Offset(size.width/2,0), Offset(size.width/2,size.height/2), paint);
    canvas.drawLine(Offset(0,size.height/2), Offset(size.width/2,size.height/2), paint);
    }
    // // canvas.drawImage(image,Offset(offsetX,0), paint);
    // debugPrint('offsetX=$offsetX,wavePointY=$wavePointY');
    // canvas.drawImageNine(image, center, dst, paint)
    // canvas.drawImageRect(image, src, dst, paint)
    // canvas.restore();
  }

}