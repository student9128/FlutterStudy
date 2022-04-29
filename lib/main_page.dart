import 'package:flutter/material.dart';
import 'package:flutter_study_list/advanced_page.dart';
import 'package:flutter_study_list/anim_page.dart';
import 'package:flutter_study_list/basic_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex=0;
  Widget _currBody = BasicPage();
  _onTap(int index) {
    switch (index) {
      case 0:
        _currBody = BasicPage();;
        break;
      case 1:
        _currBody = AnimPage();
        break;
      case 2:
        _currBody = AdvancedPage();
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Study'),),
      body: _currBody,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (int index){
          _onTap(index);
          setState(() {
          _currentIndex=index;
          });
        },
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: '基础', icon: Icon(Icons.dashboard)),
          BottomNavigationBarItem(label: '动画', icon: Icon(Icons.donut_small)),
          BottomNavigationBarItem(label: '进阶', icon: Icon(Icons.explore)),
        ],
      ),
    );
  }
}
