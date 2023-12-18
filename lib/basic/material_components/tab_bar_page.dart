import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBarPage'),
        bottom: TabBar(
          tabs: _tabList.map((e) => Text(e)).toList(),
          controller: _tabController,
          indicatorColor: Colors.red,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.white,
          indicatorWeight: 3.0,
          labelStyle: const TextStyle(height: 1, color: Colors.yellow),
        ),
      ),
      body: Column(
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
            height: 400,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                var maxScrollExtent = notification.metrics.maxScrollExtent;
                var pixels = notification.metrics.pixels;
                var depth = notification.depth;
                debugPrint(
                    'outer======depth=======$depth,pixels=$pixels,maxScrollExtent=$maxScrollExtent,'
                        'OverscrollNotification=${notification is OverscrollNotification},\n'
                        'ScrollEndNotification=${notification is ScrollEndNotification},\n'
                        'UserScrollNotification=${notification is UserScrollNotification},\n'
                        'ScrollUpdateNotification=${notification is ScrollUpdateNotification},\n'
                        'ScrollStartNotification=${notification is ScrollStartNotification}');
                // if (notification is UserScrollNotification) {
                //   if (notification.direction == ScrollDirection.reverse &&
                //       _subTabController.index == _subTabController.length - 1) {
                //     _drag =
                //         _pageController.position.drag(DragStartDetails(), () {
                //       _drag = null;
                //     });
                //   }
                //   if(notification.direction == ScrollDirection.forward &&_subTabController.index == _subTabController.length - 1){
                //     _drag =
                //         _pageController.position.drag(DragStartDetails(), () {
                //           _drag = null;
                //         });
                //   }
                // }
                // if (notification is OverscrollNotification) {
                //   if (notification.dragDetails != null && _drag != null) {
                //     _drag?.update(notification.dragDetails!);
                //   }
                // }
                // if (notification is ScrollEndNotification) {
                //   if (notification.dragDetails != null && _drag != null) {
                //     _drag?.end(notification.dragDetails!);
                //   }
                // }
                // return true;
                // if(notification.depth==0&&_subTabController.index!=_subTabController.length-1){
                //     debugPrint("🐸🐸🐸🐸🐸🐸=======");
                //   return false;
                // }
                if (notification is ScrollStartNotification) {
                  dragStartDetails = notification.dragDetails;
                }

                // if (notification is OverscrollNotification) {
                //   if (_drag == null && dragStartDetails != null) {
                //     ScrollPositionWithSingleContext a = _pageController.position
                //         as ScrollPositionWithSingleContext;
                //     _drag = a.drag(dragStartDetails!, () {
                //       _drag = null;
                //     }) as ScrollDragController;
                //   }
                //   if (notification.dragDetails != null) {
                //     _drag?.update(notification.dragDetails!);
                //   }
                // }
                // if (notification is ScrollUpdateNotification) {
                //   return false;
                // }
                // if (notification is ScrollEndNotification) {
                //   // dragStartDetails = null;
                //   if (notification.dragDetails != null) {
                //     _drag?.end(notification.dragDetails!);
                //   }
                // }
                //
                // if (notification is UserScrollNotification) {
                //   debugPrint("direction========${notification.direction}");
                //   switch (notification.direction) {
                //     case ScrollDirection.forward:
                //       debugPrint("forward,${notification.metrics}");
                //       _drag?.update(DragUpdateDetails(globalPosition: Offset(notification.metrics.maxScrollExtent, 0)));
                //       break;
                //     case ScrollDirection.idle:
                //       _drag?.cancel();
                //       break;
                //     case ScrollDirection.reverse:
                //       debugPrint("reverse");
                //       break;
                //   }
                // }
                // return false;
                return true;
              },
              child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                    _tabController.animateTo(index);
                  },
                  children: _tabList
                      .map((String e) => e == 'Java'
                          ? Center(
                              child: Column(
                              children: [
                                TabBar(
                                  tabs: _tabList.map((e) => Text(e)).toList(),
                                  controller: _subTabController,
                                  indicatorColor: Colors.blue,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  isScrollable: true,
                                  labelColor: Colors.lightGreenAccent,
                                  unselectedLabelColor: Colors.black,
                                  indicatorWeight: 1.0,
                                  labelStyle: TextStyle(height: 2),
                                  onTap: (index) {
                                    _subPageController.jumpToPage(index);
                                  },
                                ),
                                Expanded(
                                  child: PageView(
                                    controller: _subPageController,
                                    children: _tabList
                                        .map((e) => Center(
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    onPageChanged: (index) {
                                      _subTabController.animateTo(index);
                                    },
                                  ),
                                ),
                              ],
                            ))
                          : Center(child: Text(e)))
                      .toList()),
            ),
          )
        ],
      ),
    );
  }
}
