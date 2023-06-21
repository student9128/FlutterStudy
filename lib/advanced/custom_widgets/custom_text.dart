import 'package:flutter/material.dart';

class CustomTextPainter extends CustomPainter {
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double radius;
  final String text;
  CustomTextPainter(
      {this.textStyle,
      this.backgroundColor,
      this.radius = 0,
      required this.text});
  late Paint _backgroundPaint;
  late TextPainter _textPaint;
  late TextStyle _textStyle;
  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();
    _drawCanvas(canvas, size);
  }

  _initPaint() {
    _backgroundPaint = Paint()
      ..color = backgroundColor ?? Colors.green
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    _textPaint = TextPainter(textAlign: TextAlign.center, ellipsis: '.')
      ..textDirection = TextDirection.ltr;
    _textStyle = textStyle ??
        const TextStyle(
          color: Colors.white,
          fontSize: 12,
        );
  }

  _drawCanvas(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)),
        _backgroundPaint);

    _textPaint.text = TextSpan(text: text, style: _textStyle);
    _textPaint.layout();
    final offset = Offset(size.width / 2 - _textPaint.width / 2,
        size.height / 2 - _textPaint.height / 2);
    _textPaint.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomTextPainter oldDelegate) {
    return text != oldDelegate.text ||
        backgroundColor != oldDelegate.backgroundColor ||
        radius != oldDelegate.radius ||
        textStyle != oldDelegate.textStyle;
  }
}
