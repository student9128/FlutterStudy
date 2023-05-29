import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_list/util/asset_utils.dart';

class LiveAnim1 extends StatefulWidget {
  const LiveAnim1(
      {Key? key, required this.width, required this.iconName, this.onAnimEnd, required this.height})
      : super(key: key);
  final double width;
  final double height;
  final Function? onAnimEnd;
  final String iconName;

  @override
  State<LiveAnim1> createState() => _LiveAnim1State();
}

class _LiveAnim1State extends State<LiveAnim1> with TickerProviderStateMixin {
  Matrix4 _matrix4 = Matrix4.identity();
  late AnimationController _animationController;
  Tween<double> scaleTween = Tween(begin: 0.0, end: 1.0);
  Tween<double> opacityTween = Tween(begin: 1.0, end: 0.0);
  late Tween<double> translateTween;
  late Animation _opacityAnimation;
  late Animation _translateAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initAnim();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _initAnim() {
    //r 100
    // point0: 0,0
    // c1: -10,-50
    // point1: 0,-100
    // c2: 10,-150
    // point2: 0,-200
    // c3: -10,-250
    // p3: 0,-300
    // c4: 10,-350
    // p4: 0,-400
    // c5: -10,-450
    // p5: 0,-500
    // Offset p0=Offset(0, 0);
    // Offset c0=Offset(-10, -50);
    // Offset p1=Offset(0, 100);
    // var t = _translateAnimation.value;
    // var x = (pow(1 - t, 2) * p0.dx + 2 * t * (1 - t) * c0.dx + pow(t, 2) * p1.dx) -5.toDouble();
    // var y = (pow(1 - t, 2) * p0.dy + 2 * t * (1 - t) * c0.dy + pow(t, 2) * p1.dy) -50.toDouble();
    // _matrix4.translate(x);
    // _matrix4.translate(x);
    
    _animationController =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    _scaleAnimation = scaleTween.animate(
        CurveTween(curve: Interval(0.0, 0.1, curve: Curves.linear))
            .animate(_animationController));
    translateTween = Tween(begin: 0.0, end: -widget.height + widget.width / 2);
    _translateAnimation = translateTween.animate(
        CurveTween(curve: Interval(0.05, 1.0, curve: Curves.linear))
            .animate(_animationController));
    _opacityAnimation = opacityTween.animate(
        CurveTween(curve: Interval(0.9, 1.0, curve: Curves.linear))
            .animate(_animationController));
    _animationController.addStatusListener((status) {
      if (_animationController.isCompleted) {
        // _animationController.reverse();
        _animationController.reset();
        widget.onAnimEnd?.call();
        // } else if (_animationController.isDismissed) {
        //   _animationController.forward();
      }
    });
    _animationController.addListener(() {
      setState(() {});
    });
    _translateAnimation.addListener(() { 
        Offset p0=Offset(0, 0);
    Offset c0=Offset(-10, -50);
    Offset p1=Offset(0, 100);
    var t = _translateAnimation.value;
    var x = (pow(1 - t, 2) * p0.dx + 2 * t * (1 - t) * c0.dx + pow(t, 2) * p1.dx) -5.toDouble();
    var y = (pow(1 - t, 2) * p0.dy + 2 * t * (1 - t) * c0.dy + pow(t, 2) * p1.dy) -50.toDouble();
    debugPrint('x==$x,y==$y,t==$t');
    });
  }


  // 移动轨迹点，即移动物的中心点
// 当前移动距离
  Offset transSize = Offset(0.0, 0.0);

  /// 初始化动画
  // _initAnim() {
  //   _animationController =
  //       AnimationController(duration: Duration(seconds: 5), vsync: this);
  //   _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  //   _animation.addListener(() {
  //     // t 动态变化的值
  //     var t = _animation.value;
  //     debugPrint('hello=====$t');
  //     if (mounted) {
  //       setState(() {
  //         _matrix4 = Matrix4.identity();
  //         _matrix4.translate(transSize.dx, -widget.height*t, 0.0);
  //         // 设置缩小倍数
  //         _matrix4.scale((1 - t) > 0.5 ? 1.0 : (1 - t));
  //         // 设置旋转角度
  //         double rotate = pi / 2 * t;
  //         // _matrix4..rotateX(rotate > rotate * 0.8 ? rotate * 0.8 : rotate);
  //         // _matrix4..rotateY(rotate > rotate * 0.8 ? -rotate * 0.8 : -rotate);
  //         // _matrix4..rotateZ(rotate > rotate * 0.8 ? -rotate * 0.8 : -rotate);
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.bottomCenter,
      // color: Colors.blue.withOpacity(0.8),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              // return ScaleTransition(
              //    scale: _scaleAnimation,
              //    child: Image.asset(
              //      AssetUtils.getAssetImageWebP("test1"),
              //      width: widget.width / 2,
              //      height: widget.width / 2,
              //    ),
              //  );
              //  return Opacity(opacity: _opacityAnimation.value,child:Image.asset(
              //    AssetUtils.getAssetImageWebP("test1"),
              //    width: widget.width / 2,
              //    height: widget.width / 2,
              //  ) ,);
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.translate(
                  offset:
                  Offset(
                      0.0, double.parse(_translateAnimation.value.toString())),
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Image.asset(
                      AssetUtils.getAssetImageWebP(widget.iconName),
                      width: widget.width / 2,
                      height: widget.width / 2,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      // child: Stack(
      //   children: [
      //     Transform(
      //       transform: _matrix4,
      //       child: Image.asset(
      //         AssetUtils.getAssetImageWebP('test1'),
      //         width: widget.width / 2,
      //         height: widget.width / 2,
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
