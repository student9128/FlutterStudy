import 'package:flutter/material.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
        title: const Text('BottomNavBarPage'),
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
    ),);
  }
}
