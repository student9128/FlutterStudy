import 'package:flutter/material.dart';
import 'package:flutter_study_list/basic/button_page.dart';
import 'package:flutter_study_list/basic/listview_page.dart';
import 'package:flutter_study_list/basic/text_page.dart';

class Constants {
  static String title='title';
  static String pageName='pageName';
  static List<String> basicBtnList = [
    '基础组件',
    'Material Components',
    'Cupertino(iOS风格的widget)',
    'Layout',
    'Text',
    'Assets、图片、Icons',
    'Input',
    '动画和Motion',
    '交互模型',
    '样式',
    '绘制和效果',
    'Async',
    '滚动',
    '辅助功能'
  ];
  static List<Map<String,String>> basicList=[{title:'基础组件',pageName:'basicWidgetPage'},{title:'',pageName:''}];
  static List<Widget> basicPageList = [
    const TextPage(),
    const ButtonPage(),
    const ListViewPage()
  ];
  static List<String> basicSubList = [
    'Container',
    'Row',
    'Column',
    'Image',
    'Text',
    'Icon',
    'RaisedButton',
    'Scaffold',
    'Appbar',
    'FlutterLogo',
    'Placeholder'
  ];
}
