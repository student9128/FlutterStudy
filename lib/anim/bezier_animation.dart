import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class BezierAnimation extends StatefulWidget {
  const BezierAnimation({Key? key,required this.image});
  final ui.Image image;
  @override
  _BezierAnimationState createState() => _BezierAnimationState();
}

class _BezierAnimationState extends State<BezierAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  final startPoint = Offset(50, 300);
  final endPoint = Offset(300, 300);
  final controlPoint1 = Offset(150, 200);
  final controlPoint2 = Offset(250, 400);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);
    final curvedAnimation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut);
    animation = Tween(begin: 0.0, end: 1.0).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BezierPainter(animation.value,widget.image),
      child: Container(),
    );
  }
}

class BezierPainter extends CustomPainter {
  final double progress;
  final ui.Image image;
  // final image = Image.asset('assets/image.jpg');

  BezierPainter(this.progress,this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = ui.Paint()..color=Colors.green..style=ui.PaintingStyle.stroke..strokeWidth=1;
    final path = Path();
    final startPoint = Offset(50, 300);
    final endPoint = Offset(300, 300);
    final controlPoint1 = Offset(150, 200);
    final controlPoint2 = Offset(250, 400);
    canvas.drawRect(Rect.fromCenter(center: Offset(150, 200), width: 10, height: 10),paint);
    canvas.drawRect(Rect.fromCenter(center: Offset(250, 400), width: 10, height: 10),paint..color=Colors.red);
    canvas.drawRect(Rect.fromCenter(center: Offset(50, 300), width: 10, height: 10),paint..color=Colors.yellow);
    canvas.drawRect(Rect.fromCenter(center: Offset(300, 300), width: 10, height: 10),paint..color=Colors.pink);
    canvas.drawLine(Offset(10, 300), Offset(350, 300), paint..color=Colors.cyan);

    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    canvas.drawPath(path, Paint()..style=PaintingStyle.stroke..color=Colors.blue..strokeWidth=2);
      final measure  =path.computeMetrics().first;
    // final measure = PathMetrics.ofPath(path, forceClosed: false).first;
    
    final position = measure.getTangentForOffset(measure.length * progress);
    if(position!=null){
    canvas.drawImage(image, position.position - Offset(50, 50), Paint());
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
