import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:core';

typedef SwiperBuilder = Widget Function(int index);

class CustomSwiperWidget extends StatefulWidget {
  const CustomSwiperWidget(
      {super.key,
      required this.swiperBuilder,
      required this.data,
      required this.height});

  final SwiperBuilder swiperBuilder;
  final List data;
  final double height;

  @override
  State<CustomSwiperWidget> createState() => _CustomSwiperWidgetState();
}

class _CustomSwiperWidgetState extends State<CustomSwiperWidget> {
  late PageController pageController;
  List _dataList = [];
  int maxCount = 0x7fffffff;

  @override
  void initState() {
    super.initState();
    initDataList();
    pageController = PageController(initialPage: 0+widget.data.length*200);
  }

  void initDataList() {
    if (widget.data.length > 1) {
      _dataList.add(widget.data.last);
      _dataList.addAll(widget.data);
      _dataList.add(widget.data.first);
    } else {
      _dataList.addAll(widget.data);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: widget.height,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapUp: (TapUpDetails details){
            debugPrint('onTapUp===========');
          },
          onPanDown: (DragDownDetails details){
            debugPrint('onPanDown===========');
          },
          onPanCancel: (){
            debugPrint('onPanDown===========onPanEnd');
          },
          child:PageView.builder(
            controller: pageController,
            physics: const ClampingScrollPhysics(),
            itemCount: maxCount,
            itemBuilder: (context, index) {
              return widget.swiperBuilder(index%widget.data.length);
            },
            onPageChanged: (index) {
              debugPrint('index========$index');
              // if (index == 0) {
              //   pageController.jumpToPage(_dataList.length - 2);
              // }
              // if (index == _dataList.length - 1) {
              //   pageController.jumpToPage(1);
              // }
            },
          ),),
        );
  }
}
