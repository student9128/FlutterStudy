import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_study_list/util/asset_utils.dart';
import 'package:flutter_study_list/widget/KFButton.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {
  final List<String> _tabList = [
    'Android',
    'Java',
    'Flutter',
    'Kotlin',
    'iOS',
    'Swift',
    'Object-C',
    'Python'
  ];
  late TabController _tabController;
  late TabController _subTabController;
  late PageController _pageController;
  late PageController _subPageController;
  int currentIndex = 0;
  ScrollDragController? _drag;
  DragStartDetails? dragStartDetails;
  int currentSelectedAnimIndex = 8;
  final List<Map<String, dynamic>> _bottomTabList = [
    {
      'icon': 'emoji13',
      'title': 'Hello',
      'checked': true,
      'enableAnim': false,
      'curve': Curves.easeInCirc
    },
    {
      'icon': 'emoji2',
      'title': 'Flutter',
      'checked': false,
      'enableAnim': false,
      'curve': Curves.easeInCirc
    },
    {
      'icon': 'emoji3',
      'title': 'Android',
      'checked': false,
      'enableAnim': false,
      'curve': Curves.easeInCirc
    },
    {
      'icon': 'emoji4',
      'title': 'iOS',
      'checked': false,
      'enableAnim': false,
      'curve': Curves.easeInCirc
    },
    {
      'icon': 'emoji15',
      'title': 'World',
      'checked': false,
      'enableAnim': false,
      'curve': Curves.easeInCirc
    },
  ];
  List<Map<String, dynamic>> curveList = [
    {
      'name': 'Curves.bounceIn',
      'value': Curves.bounceIn,
    },
    {
      'name': 'bounceInOut',
      'value': Curves.bounceInOut,
    },
    {
      'name': 'bounceOut',
      'value': Curves.bounceOut,
    },
    {
      'name': 'decelerate',
      'value': Curves.decelerate,
    },
    {
      'name': 'linear',
      'value': Curves.linear,
    },
    {
      'name': 'linearToEaseOut',
      'value': Curves.linearToEaseOut,
    },
    {
      'name': 'ease',
      'value': Curves.ease,
    },
    {
      'name': 'easeInOut',
      'value': Curves.easeInOut,
    },
    {
      'name': 'easeInCirc',
      'value': Curves.easeInCirc,
    },
    {
      'name': 'easeInBack',
      'value': Curves.easeInBack,
    },
    {
      'name': 'easeInCubic',
      'value': Curves.easeInCubic,
    },
    {
      'name': 'easeInOutCubicEmphasized',
      'value': Curves.easeInOutCubicEmphasized,
    },
    {
      'name': 'easeInOutExpo',
      'value': Curves.easeInOutExpo,
    },
    {
      'name': 'easeIn',
      'value': Curves.easeIn,
    },
    {
      'name': 'easeInOutCirc',
      'value': Curves.easeInOutCirc,
    },
    {
      'name': 'easeInOutSine',
      'value': Curves.easeInOutSine,
    },
    {'name': 'easeInOutQuint', 'value': Curves.easeInOutQuint},
  ];

  double _sliderBorderRadiusValue = 0;
  double _tabHeight = 64;
  double _tabHeightX = 80;
  double _minBottomTabRadius = 10;
  double _currentBottomTabRadius = 10;
  bool _showBottomSheet = false;
  bool _showAnimBottomSheet = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
    _subTabController = TabController(length: _tabList.length, vsync: this);
    _pageController = PageController(viewportFraction: 1.0, initialPage: 0);
    _subPageController = PageController(viewportFraction: 1.0, initialPage: 0);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('TabBarPage'),
        // bottom: TabBar(
        //   tabs: _tabList.map((e) => Text(e)).toList(),
        //   controller: _tabController,
        //   indicatorColor: Colors.red,
        //   indicatorSize: TabBarIndicatorSize.tab,
        //   isScrollable: true,
        //   labelColor: Colors.red,
        //   unselectedLabelColor: Colors.white,
        //   indicatorWeight: 3.0,
        //   labelStyle: const TextStyle(height: 1, color: Colors.yellow),
        // ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    TabBar(
                      tabs: _tabList.map((e) => Text(e)).toList(),
                      controller: _tabController,
                      indicatorColor: Colors.green,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.black,
                      indicatorWeight: 1.0,
                      labelStyle: TextStyle(height: 2),
                      onTap: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                        _pageController.jumpToPage(index);
                      },
                    ),
                    Container(
                      width: sw - 32,
                      height: _tabHeight,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(_currentBottomTabRadius)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _bottomTabList.map((e) {
                          return CustomBottomTab(
                              iconName: e['icon'],
                              title: e['title'],
                              isChecked: e['checked'],
                              enableAnim: e['enableAnim'],
                              curve: e['curve'],
                              onTap: () {
                                var index = _bottomTabList.indexOf(e);
                                for (int i = 0;
                                    i < _bottomTabList.length;
                                    i++) {
                                  if (index == i) {
                                    setState(() {
                                      _bottomTabList[i]['checked'] = true;
                                      _bottomTabList[i]['enableAnim'] = true;
                                    });
                                  } else {
                                    setState(() {
                                      _bottomTabList[i]['checked'] = false;
                                      _bottomTabList[i]['enableAnim'] = false;
                                    });
                                  }
                                }
                              });
                        }).toList(),
                      ),
                    ),
                    Container(
                      width: sw - 32,
                      height: _tabHeight,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffE3C770),
                          borderRadius:
                              BorderRadius.circular(_currentBottomTabRadius)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _bottomTabList.map((e) {
                          return CustomBottomTab(
                              iconName: e['icon'],
                              title: e['title'],
                              isChecked: e['checked'],
                              // enableAnim: e['enableAnim'],
                              curve: e['curve'],
                              onTap: () {
                                var index = _bottomTabList.indexOf(e);
                                for (int i = 0;
                                    i < _bottomTabList.length;
                                    i++) {
                                  if (index == i) {
                                    setState(() {
                                      _bottomTabList[i]['checked'] = true;
                                      _bottomTabList[i]['enableAnim'] = true;
                                    });
                                  } else {
                                    setState(() {
                                      _bottomTabList[i]['checked'] = false;
                                      _bottomTabList[i]['enableAnim'] = false;
                                    });
                                  }
                                }
                              });
                        }).toList(),
                      ),
                    ),
                    Container(
                      width: sw - 32,
                      height: _tabHeight,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffB5D5C5),
                          borderRadius:
                              BorderRadius.circular(_currentBottomTabRadius)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _bottomTabList.map((e) {
                          return CustomBottomTab(
                              iconName: e['icon'],
                              iconSize: 36,
                              // title: e['title'],
                              isChecked: e['checked'],
                              enableAnim: e['enableAnim'],
                              curve: e['curve'],
                              onTap: () {
                                var index = _bottomTabList.indexOf(e);
                                for (int i = 0;
                                    i < _bottomTabList.length;
                                    i++) {
                                  if (index == i) {
                                    setState(() {
                                      _bottomTabList[i]['checked'] = true;
                                      _bottomTabList[i]['enableAnim'] = true;
                                    });
                                  } else {
                                    setState(() {
                                      _bottomTabList[i]['checked'] = false;
                                      _bottomTabList[i]['enableAnim'] = false;
                                    });
                                  }
                                }
                              });
                        }).toList(),
                      ),
                    ),
                    Container(
                      width: sw - 32,
                      height: _tabHeight,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Color(0xff89CFF3),
                          borderRadius:
                              BorderRadius.circular(_currentBottomTabRadius)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _bottomTabList.map((e) {
                          return CustomBottomTab(
                              iconName: e['icon'],
                              iconSize: 36,
                              // title: e['title'],
                              isChecked: e['checked'],
                              enableAnim: e['enableAnim'],
                              showCustomSelectedIcon: true,
                              curve: e['curve'],
                              onTap: () {
                                var index = _bottomTabList.indexOf(e);
                                for (int i = 0;
                                    i < _bottomTabList.length;
                                    i++) {
                                  if (index == i) {
                                    setState(() {
                                      _bottomTabList[i]['checked'] = true;
                                      _bottomTabList[i]['enableAnim'] = true;
                                    });
                                  } else {
                                    setState(() {
                                      _bottomTabList[i]['checked'] = false;
                                      _bottomTabList[i]['enableAnim'] = false;
                                    });
                                  }
                                }
                              });
                        }).toList(),
                      ),
                    ),
                    Container(
                      width: sw - 32,
                      height: _tabHeight,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffE6B9DE),
                          borderRadius:
                              BorderRadius.circular(_currentBottomTabRadius),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(3, 3),
                                color: Colors.black,
                                blurRadius: 0.1)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _bottomTabList.map((e) {
                          return CustomBottomTab(
                              iconName: e['icon'],
                              iconSize: 36,
                              // title: e['title'],
                              isChecked: e['checked'],
                              enableAnim: e['enableAnim'],
                              showCustomSelectedIcon: true,
                              curve: e['curve'],
                              onTap: () {
                                var index = _bottomTabList.indexOf(e);
                                for (int i = 0;
                                    i < _bottomTabList.length;
                                    i++) {
                                  if (index == i) {
                                    setState(() {
                                      _bottomTabList[i]['checked'] = true;
                                      _bottomTabList[i]['enableAnim'] = true;
                                    });
                                  } else {
                                    setState(() {
                                      _bottomTabList[i]['checked'] = false;
                                      _bottomTabList[i]['enableAnim'] = false;
                                    });
                                  }
                                }
                              });
                        }).toList(),
                      ),
                    ),
                    Container(
                      width: sw,
                      height: _tabHeightX,
                      // color: Colors.cyanAccent.withOpacity(0.2),
                      margin: EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: sw,
                              height: 56,
                              decoration: BoxDecoration(
                                  color: Color(0xffEEF5FF),
                                  borderRadius: BorderRadius.circular(
                                      _currentBottomTabRadius),
                                  ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: _bottomTabList.map((e) {
                                  var index = _bottomTabList.indexOf(e);
                                  if(index==2){
                                    return Container(width: sw/5.3*1.3,);
                                  }
                                  return CustomBottomTab(
                                    tabWidth: sw/5.3,
                                      iconName: e['icon'],
                                      iconSize: 36,
                                      // title: e['title'],
                                      isChecked: e['checked'],
                                      enableAnim: false,
                                      showCustomSelectedIcon: false,
                                      curve: e['curve'],
                                      onTap: () {
                                      });
                                }).toList(),
                              ),
                            ),
                          ),
                          Positioned(
                              left: sw / 2 - 35,
                              top: 0,
                              child: KFButton(
                                width: 70,
                                height: 70,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: Color(0xffEEF5FF),
                                ),
                                child: Image.asset(
                                  AssetUtils.getAssetImagePNG('emoji16'),
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.contain,

                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 100,
                  right: 26,
                  child: Column(
                    children: [
                      KFButton(
                        onTap: () {
                          setState(() {
                            _showBottomSheet = true;
                          });
                        },
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0xff004225),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 1,
                                  color: Color(0xff706233))
                            ]),
                        child: Text(
                          '设置',
                          style: TextStyle(
                              color: Color(0xffC6A969),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      KFButton(
                        margin: EdgeInsets.only(top: 10),
                        onTap: () {
                          setState(() {
                            _showAnimBottomSheet = true;
                          });
                        },
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0xffAE445A),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 1,
                                  color: Color(0xff706233))
                            ]),
                        child: Text(
                          '动画',
                          style: TextStyle(
                              color: Color(0xffC6A969),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
              _showBottomSheet
                  ? Positioned(
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: sw,
                        height: 250,
                        decoration: BoxDecoration(
                            color: Color(0xff675D50),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                KFButton(
                                  onTap: () {
                                    setState(() {
                                      _showBottomSheet = false;
                                    });
                                  },
                                  padding: EdgeInsets.all(16),
                                  // color: Colors.red,
                                  child: Icon(
                                    Icons.clear,
                                    size: 30,
                                    color: Color(0xffA9907E),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 4.0,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 10.0),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 16.0),
                                    activeTrackColor: Colors.yellow,
                                    inactiveTrackColor: Color(0xffF6F1E9),
                                    thumbColor: Colors.red,
                                    overlayColor: Colors.blue.withOpacity(0.2),
                                    valueIndicatorShape:
                                        DropSliderValueIndicatorShape(),
                                    valueIndicatorTextStyle:
                                        TextStyle(color: Colors.white),
                                    trackShape: RectangularSliderTrackShape(),
                                    showValueIndicator:
                                        ShowValueIndicator.always,
                                    valueIndicatorColor:
                                        Colors.blue, // 修改值指示器的颜色
                                  ),
                                  child: Slider(
                                    value: _sliderBorderRadiusValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _sliderBorderRadiusValue = newValue;
                                        _currentBottomTabRadius =
                                            (_sliderBorderRadiusValue *
                                                        (_tabHeight / 2 -
                                                            _minBottomTabRadius) +
                                                    _minBottomTabRadius)
                                                .floorToDouble();
                                      });
                                    },
                                  ),
                                )),
                                Container(
                                  width: 50,
                                  child: Text(
                                    '${(_sliderBorderRadiusValue * (_tabHeight / 2 - _minBottomTabRadius) + _minBottomTabRadius).toStringAsFixed(0)}',
                                    style: TextStyle(color: Color(0xffDED0B6)),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                  : SizedBox(),
              _showAnimBottomSheet
                  ? Positioned(
                      bottom: 0,
                      child: Container(
                        height: 300,
                        width: sw,
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 20),
                        decoration: BoxDecoration(
                            color: Color(0xff675D50),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                KFButton(
                                  onTap: () {
                                    setState(() {
                                      _showAnimBottomSheet = false;
                                    });
                                  },
                                  padding: EdgeInsets.all(16),
                                  // color: Colors.red,
                                  child: Icon(
                                    Icons.clear,
                                    size: 30,
                                    color: Color(0xffA9907E),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: curveList.map((e) {
                                  var index = curveList.indexOf(e);
                                  return KFButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.primaries.elementAt(
                                            index % Colors.primaries.length),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        border: Border.all(
                                            color: currentSelectedAnimIndex ==
                                                    index
                                                ? Colors.black
                                                : Colors.transparent)),
                                    onTap: () {
                                      var curve = curveList[index]['value'];
                                      debugPrint('curve======$curve');
                                      setState(() {
                                        currentSelectedAnimIndex = index;
                                        _bottomTabList.forEach((element) {
                                          element['curve'] = curve;
                                        });
                                      });
                                    },
                                    child: Text(curveList[index]['name']),
                                  );
                                }).toList(),
                              ),
                            ))
                          ],
                        ),
                      ))
                  : SizedBox()
            ],
          ))
        ],
      ),
    );
  }

  KFButton _buildBottomTab(
      {String iconName = '',
      String title = '',
      bool isChecked = false,
      Function? onTap}) {
    return KFButton(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetUtils.getAssetImagePNG(iconName),
            width: 24,
            height: 24,
          ),
          Container(
            margin: EdgeInsets.only(top: 3),
            child: Text(
              title,
              style: TextStyle(
                  color: isChecked ? Colors.cyan : Colors.grey.shade500),
            ),
          )
        ],
      ),
    );
  }
}

class CustomBottomTab extends StatefulWidget {
  CustomBottomTab(
      {Key? key,
      this.iconName = '',
      this.title = '',
      this.isChecked = false,
      this.enableAnim = false,
      this.showCustomSelectedIcon = false,
      this.curve,
      this.iconSize,
      this.tabWidth,
      this.tabHeight,
      this.onTap})
      : super(key: key);
  final String iconName;
  final String title;
  final bool isChecked;
  final bool enableAnim;
  final bool showCustomSelectedIcon;
  final Curve? curve;
  final double? iconSize;
  final double? tabWidth;
  final double? tabHeight;
  Function? onTap;

  @override
  State<CustomBottomTab> createState() => _CustomBottomTabState();
}

class _CustomBottomTabState extends State<CustomBottomTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  int _count = 0;
  bool _animStop = false;

  @override
  void initState() {
    super.initState();
    debugPrint("initstate===widget.enableAnim=${widget.enableAnim}");
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animation.addListener(() {
      setState(() {});
    });
    _animationController.addStatusListener((status) {
      if (_count == 3) {
        _count = 0;
        _animationController.stop();
        return;
      }
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        ++_count;
        _animationController.forward();
      }
    });
  }

  @override
  void didUpdateWidget(covariant CustomBottomTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enableAnim != oldWidget.enableAnim && widget.enableAnim) {
      _animation = Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
          parent: _animationController,
          curve: widget.curve ?? Curves.easeInCirc));
      _animationController.forward();
    } else {
      _count = 0;
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KFButton(
      width: widget.tabWidth,
      height: widget.tabHeight,
      onTap: () {
        widget.onTap?.call();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _animation,
              builder: (context, build) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Image.asset(
                    AssetUtils.getAssetImagePNG(
                        widget.showCustomSelectedIcon && widget.enableAnim
                            ? 'emoji16'
                            : widget.iconName),
                    width: widget.iconSize ?? 24,
                    height: widget.iconSize ?? 24,
                  ),
                );
              }),
          widget.title.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: widget.isChecked
                            ? Colors.cyan
                            : Colors.grey.shade500),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  CustomTabBar({Key? key, required this.tabList}) : super(key: key);
  List<Widget> tabList;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  double _tabBarHeight = 72;

  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;
    return Container(
      width: sw,
      height: _tabBarHeight,
      decoration: BoxDecoration(color: Colors.redAccent),
      child: Stack(
        children: [
          Row(
            children: widget.tabList.map((e) {
              return Container(
                width: sw / widget.tabList.length,
                height: sw / widget.tabList.length,
                child: Text('e'),
              );
            }).toList(),
          ),
          Positioned(
              child: Container(
            width: sw / widget.tabList.length,
            height: sw / widget.tabList.length,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ))
        ],
      ),
    );
  }
}
