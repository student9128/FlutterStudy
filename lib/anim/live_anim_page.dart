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

class _LiveAnimPageState extends State<LiveAnimPage>
    with TickerProviderStateMixin {
  List<Widget> _list1 = [];
  List<Widget> _listData = [];
  List<Key> _listTemp = [];
  late AnimationController wareController;
  late AnimationController mainController;
  late AnimationController secondController;

  late Animation<double> waveAnimation;
  late Animation<double> mainAnimation;
  late Animation<double> secondAnimation;
  ui.FrameInfo? frame;
  late ui.Image image;
  List<ui.Image> list = [];
  bool hasInitialized = false;
  int count = 0;
  @override
  void initState() {
    super.initState();
    // _initData();
    // _iniX();
    _initX();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _addAnim();
      setState(() {
        
      });
    });
    wareController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    waveAnimation = Tween<double>(begin: 0.1, end: 0.5).animate(wareController);
    wareController.forward();
    mainController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    mainAnimation = Tween(begin: 0.0, end: 300.0).animate(mainController);
    // mainAnimation.addListener(() {
    //   setState(() {

    //   });
    // });
  }

  _initX() async {
    for (int i = 0; i < 50; i++) {
      var image = await loadImageX(
          "assets/images/emoji${Random.secure().nextInt(15) + 1}.png");
      list.add(image);
    }
    // list.add(frame!.image);
    hasInitialized = true;
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
    Future.delayed(
        Duration(milliseconds: (Random.secure().nextInt(5000)) + 1000), () {
      _list1.add(LiveAnim1(
        width: 100,
        height: 500,
        iconName: 'test${Random.secure().nextInt(6) + 1}',
        onAnimEnd: () {
          // _list1.removeAt(0);
        },
      ));
      debugPrint('list size is ${_list1.length}');
      if (mounted) {
        setState(() {});
        _addAnim1();
      }
    });
  }

  var index = 0;
  int countX=0;
  _addAnim() {
    var second = Random.secure().nextInt(800) + 200;
    debugPrint('second=$second====${DateTime.now()},list[index]=$index');
    Future.delayed(Duration(milliseconds: second), () {
      if (hasInitialized) {
        countX=countX+1;
        _listData.add(CustomLiveAnim(
                key: Key('animKey$countX'),
                  image: list[index],
                  onAnimEnd: () {
                  _listTemp.add(Key('animKey$countX'));
                    // _listData.removeWhere((element) => element.key==Key('animKey${countX}'));
                  },
                ));
      }
      debugPrint('list size is before ${_listData.length},${_listTemp.length}');
      if (mounted) {
        for(int i=0;i<_listTemp.length;i++){
          debugPrint('--------${_listTemp[i]}');
          _listData.removeAt(0);
        }
        _listTemp.clear();
      debugPrint('list size is after ${_listData.length},${_listTemp.length}');
        setState(() {
          index = Random.secure().nextInt(50);
          debugPrint('index=$index');
          _addAnim();
        });

      }
    });
  }

  _iniX() async {
    // await loadImage("assets/images/test5.webp");
    // image=frame!.image;
    // list.add(image);
    await loadImage("assets/images/test1.webp");
    // list.add(frame!.image);
    hasInitialized = true;
    mainController.repeat();
  }

  Future<ui.Image> loadImageX(String name) async {
    ByteData logoBytes = await rootBundle.load(name);
    Uint8List logoUnit8 = logoBytes.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(logoUnit8);
    frame = await codec.getNextFrame();
    return frame!.image;
  }

  Future<void> loadImage(String name) async {
    // ByteData logoBytes = await rootBundle.load(name);
    // Uint8List logoUnit8 = logoBytes.buffer.asUint8List();
    // for (int i = 1; i <=30; i++) {
    //   ui.Codec codec = await ui.instantiateImageCodec(logoUnit8,
    //       targetWidth: i, targetHeight:i);
    //   frame = await codec.getNextFrame();
    //   list.add(frame!.image);
    // }
  }
  _initData() async {
    ByteData logoBytes = await rootBundle.load("assets/images/test1.webp");
    Uint8List logoUnit8 = logoBytes.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(logoUnit8,
        targetWidth: 20, targetHeight: 20);
    frame = await codec.getNextFrame();
    setState(() {});
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
        // padding: EdgeInsets.only(top: 50),
        child:Column(children: [
          // Image.asset('assets/images/emoji1.png',width: 30,height: 30,),
          Stack(children: _listData)
        ],) ,
        // child: Stack(
        //   children: [
        //     // Positioned(
        //     //     right: 0,
        //     //     bottom: 0,
        //     //     child:Container(
        //     //       width: MediaQuery.of(context).size.width,
        //     //      height: 500,
        //     //      child: Stack(
        //     //        children: _list1,
        //     //      ),
        //     //     ))
        //       Container(
        //       width: 200,
        //       height: 300,
        //       color: Colors.green.withOpacity(0.8),
        //       margin: const EdgeInsets.only(top: 50, bottom: 20),
        //       child: hasInitialized ? CustomLiveAnim(image: image!) : SizedBox(),
        //     ),

        //     // Container(
        //     //   color: Colors.amber,
        //     //   child: hasInitialized?BezierAnimation(image: image):Container(width: 20,height: 20,color: Colors.red),
        //     // )

        //   ],
        // ),
      ),
    );
  }
}
