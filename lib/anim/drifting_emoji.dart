import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DriftingEmoji extends StatefulWidget {
  const DriftingEmoji({Key? key,required this.image,required this.height}) : super(key: key);
  final ui.Image image;
  final double height;

  @override
  _DriftingEmojiState createState() => _DriftingEmojiState();
}

class _DriftingEmojiState extends State<DriftingEmoji>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  final _random = Random();

  // 贝塞尔曲线控制点坐标列表
  List<Offset> _controlPoints = [];

  // 随机生成贝塞尔曲线的控制点坐标
  void _generateControlPoints() {
    double x1 = _random.nextDouble() * 100 + 50;
    double y1 = widget.height - _random.nextDouble() * 200 - 50;
    double x2 = _random.nextDouble() * 100 + 150;
    double y2 = widget.height - _random.nextDouble() * 100 - 300;
    double x3 = _random.nextDouble() * 50 + 250;
    double y3 = widget.height - _random.nextDouble() * 50 - 450;
    debugPrint('x1=$x1,y1=$y1,x2=$x2,y2=$y2,x3=$x3,y3=$y3');

    _controlPoints = [
      Offset(x1, y1),
      Offset(x2, y2),
      Offset(x3, y3),
    ];
  }

  @override
  void initState() {
    super.initState();
    if(mounted){
    }
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    _generateControlPoints();

     });

    // 创建动画控制器并定义动画
    _controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // 动画结束后重置状态
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // _generateControlPoints();
        // _controller.reset();
      }
    });

    // 启动动画
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_controlPoints.length>0){
    debugPrint('dx=${_controlPoints.last.dx},dy=${_controlPoints.last.dy - 50}');
    }
    return _controlPoints.length>0?AnimatedContainer(
      width: 100,height: 100,
      decoration: BoxDecoration(
        // color: Colors.red
      ),
      duration: const Duration(seconds: 4),
      curve: Curves.easeInOut,
      // transform: Matrix4.translationValues(
      //   _controlPoints.last.dx,
      //   _controlPoints.last.dy - 50,
      //   0,
      // ),
      child: CustomPaint(
        painter: DriftingEmojiPainter(
          animationValue: _animation.value,
          controlPoints: _controlPoints,
          image: widget.image
        ),
        // size: const Size(80, 80),
      ),
    ):SizedBox();
  }
}

class DriftingEmojiPainter extends CustomPainter {
  final double animationValue;
  final List<Offset> controlPoints;
  final ui.Image image;

  DriftingEmojiPainter({
    required this.animationValue,
    required this.controlPoints,
    required this.image
  });

  @override
  void paint(Canvas canvas, Size size) async {
    Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
    ..strokeWidth=1;
    // canvas.drawColor(Colors.blue, BlendMode.color);
    debugPrint('w=${size.width},h=${size.height},${animationValue}');

    Path path = Path();
    path.moveTo(0, 0);
    path.cubicTo(
      controlPoints[0].dx,
      controlPoints[0].dy,
      controlPoints[1].dx,
      controlPoints[1].dy,
      controlPoints[2].dx,
      controlPoints[2].dy,
    );
    // path.lineTo(0, size.height);
    // path.close();
    // canvas.drawPath(path, paint);
    canvas.drawPath(path, paint);
    paint.color=Colors.yellow;
    canvas.drawRect(Rect.fromCenter(center: Offset(controlPoints[0].dx,controlPoints[0].dy), width: 10, height: 10), paint);
    paint.color=Colors.red;
    canvas.drawRect(Rect.fromCenter(center: Offset(controlPoints[1].dx,controlPoints[1].dy), width: 10, height: 10), paint);
    paint.color=Colors.blue;
    canvas.drawRect(Rect.fromCenter(center: Offset(controlPoints[2].dx,controlPoints[2].dy), width: 10, height: 10), paint);
    canvas.save();
    canvas.translate(animationValue*200, animationValue*-300);

    // 加载Asset图片
    // final image =
    //     await loadImageFromAsset('assets/images/test1.webp');
    canvas.drawImage(image, const Offset(0, 0), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(DriftingEmojiPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }

  // 从Asset加载图片到ui.Image
  Future<ui.Image> loadImageFromAsset(String assetName) async {
    final ByteData data = await rootBundle.load(assetName);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(data.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
