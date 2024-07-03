import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:core';

typedef SwiperBuilder = Widget Function(int index);

class CustomSwiperWidget extends StatefulWidget {
  const CustomSwiperWidget(
      {super.key,
      required this.swiperBuilder,
      required this.data,
      required this.height,
      this.onTap});

  final SwiperBuilder swiperBuilder;
  final Function(int index)? onTap;
  final List data;
  final double height;

  @override
  State<CustomSwiperWidget> createState() => _CustomSwiperWidgetState();
}

class _CustomSwiperWidgetState extends State<CustomSwiperWidget> {
  late PageController pageController;
  int maxCount = 0x7fffffff;
  int _currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0 + widget.data.length * 200);
    initTimer();
  }

  void initTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (pageController.positions.isNotEmpty) {
        var currentPage = pageController.page;
        if (currentPage != null) {
          var cIndex = pageController.page!.toInt();
          pageController.animateToPage(cIndex + 1,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
        }
        // if(pageController.page.toString().split(".").length >1){
        //   var i = int.parse(pageController.page.toString().split(".")[0])+ 1;
        //   pageController.animateToPage(i == 3 ? 0 : i,
        //       duration: Duration(milliseconds: widget.scrollTime),
        //       curve: Curves.linear);
        // }else{
        //   var i = int.parse(pageController.page.toString())+ 1;
        //   pageController.animateToPage(i == 3 ? 0 : i,
        //       duration: Duration(milliseconds: widget.scrollTime),
        //       curve: Curves.linear);
        // }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    pageController.dispose();
    super.dispose();
  }

  Row _buildIndicator() {
    List<Widget> listWidget = [];
    for (int i = 0; i < widget.data.length; i++) {
      listWidget.add(Container(
        width: _currentIndex == i ? 15 : 8,
        height: 4,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            color: _currentIndex == i ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(2)),
      ));
    }
    return Row(
      children: listWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            debugPrint('onPanDown===========onTap');
          },
          onPanDown: (DragDownDetails details) {
            debugPrint('onPanDown===========');
            timer?.cancel();
          },
          onPanCancel: () {
            initTimer();
            debugPrint(
                'onPanDown===========onPanEnd,${pageController.page?.toInt()}');
          },
          child: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                physics: const ClampingScrollPhysics(),
                itemCount: maxCount,
                itemBuilder: (context, index) {
                  return widget.swiperBuilder(index % widget.data.length);
                },
                onPageChanged: (index) {
                  debugPrint('index========$index');
                  setState(() {
                    _currentIndex = index % widget.data.length;
                  });
                  // if (index == 0) {
                  //   pageController.jumpToPage(_dataList.length - 2);
                  // }
                  // if (index == _dataList.length - 1) {
                  //   pageController.jumpToPage(1);
                  // }
                },
              ),
              Positioned(bottom: 10, right: 16 + 10, child: _buildIndicator())
            ],
          )),
    );
  }
}
