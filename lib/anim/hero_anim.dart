import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/anim/hero_anim_second_page.dart';
import 'package:flutter_study_list/anim/page_transition_anim.dart';
import 'package:flutter_study_list/routes/application.dart';

class HeroAnim extends StatefulWidget {
  const HeroAnim({ Key? key }) : super(key: key);

  @override
  State<HeroAnim> createState() => _HeroAnimState();
}

class _HeroAnimState extends State<HeroAnim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HeroAnim'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Application.router.navigateTo(context,"heroAnimSecondPage");
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => HeroAnimSecondPage()));
              },
              child: Hero(
                  tag: "hello",
                  child: FlutterLogo(
                    size: 100,
                  ))),
          ElevatedButton(onPressed:(){
            Navigator.of(context).push(PageRouteBuilder(pageBuilder:
                (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return ClipPath(
                    clipper: CirclePath(animation.value),
                    child: child,
                  );
                },
                child: PageTransitionAnim(),
              );
            }));
          }, child: Text('页面切换动画'))
        ],
      ),
    );
  }
}
class CirclePath extends CustomClipper<Path> {
  CirclePath(this.value);

  final double value;

  @override
  Path getClip(Size size) {
    var path = Path();
    double radius =
        value * sqrt(size.height * size.height + size.width * size.width);
    path.addOval(Rect.fromLTRB(
        size.width - radius, -radius, size.width + radius, radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}