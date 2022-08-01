import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/anim/hero_anim_second_page.dart';
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
      body: ElevatedButton(
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
    );
  }
}