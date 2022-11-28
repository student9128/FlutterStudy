import 'package:flutter/material.dart';

class WavyPainter extends CustomPainter {
  // 波浪的曲度
  final double waveHeight;
  // 进度 [0-1]
  final double progress;
  // 对波浪区域进行X轴方向的偏移，实现滚动效果
  final double offsetX;

  final Color color;

  WavyPainter(this.progress, this.offsetX, this.color, {this.waveHeight = 24});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.5
      ..color = color;
    drawWave(canvas, size.center(Offset(0, 0)), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawWave(Canvas canvas, Offset center, double radius, Paint paint) {
    // 圆形裁剪
    canvas.save();
    Path clipPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.clipPath(clipPath);

    // 反向计算点的纵坐标
    double wavePointY = (1 - progress) * radius * 2;

    // point3为中心点，波浪的直径为圆的半径，一共5个点，加上两个闭环点（p六、p7）
    Offset point1 = Offset(center.dx - radius * 3 + offsetX, wavePointY);
    Offset point2 = Offset(center.dx - radius * 2 + offsetX, wavePointY);
    Offset point3 = Offset(center.dx - radius + offsetX, wavePointY);
    Offset point4 = Offset(center.dx + offsetX, wavePointY);
    Offset point5 = Offset(center.dx + radius + offsetX, wavePointY);

    Offset point6 = Offset(point5.dx, center.dy + radius + waveHeight);
    Offset point7 = Offset(point1.dx, center.dy + radius + waveHeight);

    // 贝塞尔曲线控制点
    Offset c1 =
        Offset(center.dx - radius * 2.5 + offsetX, wavePointY + waveHeight);
    Offset c2 =
        Offset(center.dx - radius * 1.5 + offsetX, wavePointY - waveHeight);
    Offset c3 =
        Offset(center.dx - radius * 0.5 + offsetX, wavePointY + waveHeight);
    Offset c4 =
        Offset(center.dx + radius * 0.5 + offsetX, wavePointY - waveHeight);

    // 链接贝塞尔曲线
    Path wavePath = Path()
      ..moveTo(point1.dx, point1.dy)
      ..quadraticBezierTo(c1.dx, c1.dy, point2.dx, point2.dy)
      ..quadraticBezierTo(c2.dx, c2.dy, point3.dx, point3.dy)
      ..quadraticBezierTo(c3.dx, c3.dy, point4.dx, point4.dy)
      ..quadraticBezierTo(c4.dx, c4.dy, point5.dx, point5.dy)
      ..lineTo(point6.dx, point6.dy)
      ..lineTo(point7.dx, point7.dy)
      ..close();

    // 绘制
    canvas.drawPath(wavePath, paint);
    canvas.restore();
  }
}