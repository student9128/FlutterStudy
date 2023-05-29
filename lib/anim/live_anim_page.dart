import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study_list/anim/bezier_animation.dart';
import 'package:flutter_study_list/anim/custom_live_anim_1.dart';
import 'package:flutter_study_list/anim/drifting_emoji.dart';
import 'package:flutter_study_list/anim/live_anim_1.dart';
import 'dart:ui' as ui;

class LiveAnimPage extends StatefulWidget {
  const LiveAnimPage({Key? key}) : super(key: key);

  @override
  State<LiveAnimPage> createState() => _LiveAnimPageState();
}

class _LiveAnimPageState extends State<LiveAnimPage> with TickerProviderStateMixin{
  List<Widget> _list1 = [];
  late AnimationController wareController;
  late AnimationController mainController;
  late AnimationController secondController;

  late Animation<double> waveAnimation;
  late Animation<double> mainAnimation;
  late Animation<double> secondAnimation;
  ui.FrameInfo? frame;
  late ui.Image image;
  List<ui.Image> list=[];
  bool hasInitialized=false;
  @override
  void initState() {
    super.initState();
    _initData();
    _iniX();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // _addAnim1();
    });
    wareController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    waveAnimation = Tween<double>(begin: 0.1, end: 0.5).animate(wareController);
    wareController.forward();
    mainController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    mainAnimation = Tween(begin: 0.0, end: 300.0).animate(mainController);
    mainAnimation.addListener(() { 
      // debugPrint('value=${mainAnimation.value}');
      setState(() {
        
      });
    });
    mainController.repeat();
  }
    // 从Asset加载图片到ui.Image
  Future<ui.Image> loadImageFromAsset(String assetName) async {
    ByteData data = await rootBundle.load(assetName);
    Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(data.buffer.asUint8List(), completer.complete);
    return completer.future;
  }

  _addAnim1() {
    Future.delayed(Duration(milliseconds: Random.secure().nextInt(600)), () {
      _list1.add(LiveAnim1(width: 100, height: 500,iconName: 'test${Random.secure().nextInt(6)+1}',onAnimEnd: (){
        // _list1.removeAt(0);
      },));
      debugPrint('list size is ${_list1.length}');
      if(mounted){
      setState(() {
      });
      _addAnim1();
      }
    });
  }
  _iniX() async {
    await loadImage("assets/images/test5.webp");
    image=frame!.image;
    list.add(image);
    await loadImage("assets/images/test1.webp");
    list.add(frame!.image);
    hasInitialized = true;
  }

  Future<void> loadImage(String name) async {
       ByteData logoBytes = await rootBundle.load(name);
    Uint8List logoUnit8 = logoBytes.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(logoUnit8,
        targetWidth: 30, targetHeight: 30);
    frame = await codec.getNextFrame();
  }
   _initData()async{
    ByteData logoBytes = await rootBundle.load("assets/images/test1.webp");
    Uint8List logoUnit8 = logoBytes.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(logoUnit8,targetWidth: 20,targetHeight: 20);
    frame = await codec.getNextFrame();
    setState(() {
      
    });
  }

  @override
  void dispose() {
    wareController.dispose();
    mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LiveAnimPage'),
      ),
      // body: Container(child: hasInitialized?BezierAnimation(image: image):Container(width: 20,height: 20,color: Colors.red),),
      // body:Container(
      //   color: Colors.green,
      //   alignment: Alignment.centerLeft,
      //   // alignment: Alignment.bottomLeft,
      //   child: hasInitialized? DriftingEmoji(image: image,height: 300,):Container(width: 20,height: 20,color: Colors.red,)
      // )

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Positioned(
            //     right: 0,
            //     bottom: 0,
            //     child:Container(
            //       width: MediaQuery.of(context).size.width,
            //      height: 500,
            //      child: Stack(
            //        children: _list1,
            //      ),
            //     ))
              Container(
              width: 125,
              height: 300,
              color: Colors.green.withOpacity(0.8),
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: list.length>=2 ? CustomLiveAnim(image: list) : SizedBox(),
            ),
            
            // Container(
            //   color: Colors.amber,
            //   child: hasInitialized?BezierAnimation(image: image):Container(width: 20,height: 20,color: Colors.red),
            // )
            
          ],
        ),
      ),
    );
  }
}
