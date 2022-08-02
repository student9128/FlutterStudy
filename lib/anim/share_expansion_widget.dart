import 'dart:math' as math;

import 'package:flutter/material.dart';

class ShareExpansionWidget extends StatelessWidget {
  const ShareExpansionWidget({ Key? key,required this.maxRadius,this.child }) :clipRectSize=2.0*(maxRadius/math.sqrt2);
final double maxRadius;
final double clipRectSize;
final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(child: child,),
        ),
      ),
    );
  }
}