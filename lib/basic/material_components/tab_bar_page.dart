import 'package:flutter/material.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({ Key? key }) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin{
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
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    });
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
          labelStyle: const TextStyle(height: 1,color: Colors.yellow),
        ),
      ),
      body:Column(
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
          ),
          Container(
            height: 200,
            child:  TabBarView(
                controller: _tabController,
                children: _tabList.map((e) => Center(child: Text(e),)).toList()),
          )

        ],
      ) ,
    );
  }
}