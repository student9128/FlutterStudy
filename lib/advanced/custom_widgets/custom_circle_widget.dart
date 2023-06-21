import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_study_list/advanced/custom_widgets/custom_circle.dart';

class CustomCircleWidget extends StatelessWidget {
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double radius;
  final double width;
  final double height;
  final String text;
  const CustomCircleWidget(
      {Key? key,
      this.textStyle,
      this.backgroundColor,
      this.radius = 0,
      required this.text,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: CustomCirclePainter(
          text: text,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          radius: radius),
    );
  }
}
