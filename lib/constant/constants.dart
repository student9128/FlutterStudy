import 'package:flutter/material.dart';
import 'package:flutter_study_list/basic/button_page.dart';
import 'package:flutter_study_list/basic/listview_page.dart';
import 'package:flutter_study_list/basic/text_page.dart';

class Constants {
  static String title = 'title';
  static String pageName = 'pageName';

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
  static List<Map<String, String>> basicList = [
    {title: '基础组件', pageName: '/basicWidgetPage'},
    {title: '', pageName: ''}
  ];
  static List<Widget> basicPageList = [
    const TextPage(),
    const ButtonPage(),
    const ListViewPage()
  ];
  static List<String> basicWidgetList = [
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
  static List<String> basicMaterialComponentsList = [
    'Scaffold',
    'Appbar',
    'BottomNavigationBar',
    'TabBar',
    'TabBarView',
    'MaterialApp',
    'WidgetsApp',
    'Drawer'
  ];
  static List<String> basicCupertinoComponentsList = [
    'CupertinoActivityIndicator',
    'CupertinoAlertDialog',
    'CupertinoButton',
    'CupertinoDialog',
    'CupertinoDialogAction',
    'CupertinoSlider',
    'CupertinoSwitch',
    'CupertinoPageTransition',
    'CupertinoFullscreenDialogTransition',
    'CupertinoNavigationBar',
    'CupertinoTabBar',
    'CupertinoPageScaffold',
    'CupertinoTabScaffold',
    'CupertinoTabView'
  ];
  static List<String> basicLayoutList = [
    'Container',
    'Padding',
    'Center',
    'Align',
    'FittedBox',
    'AspectRatio',
    'ConstrainedBox',
    'Baseline',
    'FractionallySizedBox',
    'IntrinsicHeight',
    'IntrinsicWidth',
    'LimitedBox',
    'Offstage',
    'OverflowBox',
    'SizedBox',
    'SizedOverflowBox',
    'Transform',
    'CustomSingleChildLayout',
    'Row',
    'Column',
    'Stack',
    'IndexedStack',
    'Flow',
    'Table',
    'Wrap',
    'ListBody',
    'ListView',
    'CustomMultiChildLayout',
    'LayoutBuilder'
  ];
  static List<String> basicTextList = ['Text', 'RichText', 'DefaultTextStyle'];
  static List<String> basicAssetsIconList = [
    'Image',
    'Icon',
    'RawImage',
    'AssetBundle'
  ];
  static List<String> basicInputList = [
    'Form',
    'FormField',
    'RawKeyboardListener',
  ];
  static List<String> basicAnimationAndMotionList = [
    'AnimatedContainer',
    'AnimatedCrossFade',
    'Hero',
    'AnimatedBuilder',
    'DecoratedBoxTransition',
    'FadeTransition',
    'PositionedTransition',
    'RotationTransition',
    'ScaleTransition',
    'SizeTransition',
    'SlideTransition',
    'AnimatedDefaultTextStyle',
    'AnimatedListState',
    'AnimatedModalBarrier',
    'AnimatedOpacity',
    'AnimatedPhysicalModel',
    'AnimatedPositioned',
    'AnimatedSize',
    'AnimatedWidget',
    'AnimatedWidgetBaseState'
  ];
  static List<String> basicInteractionModelList = [
    'LongPressDraggable',
    'GestureDetector',
    'DragTarget',
    'Dismissible',
    'IgnorePointer',
    'AbsorbPointer',
    'Navigator',
    'Scrollable'
  ];
  static List<String> basicStyleList = ['Padding', 'Theme', 'MediaQuery'];
  static List<String> basicPaintAndEffectList = [
    'Opacity',
    'Transform',
    'DecoratedBox',
    'FractionalTranslation',
    'RotatedBox',
    'ClipOval',
    'ClipPath',
    'ClipRect',
    'CustomPaint',
    'BackdropFilter'
  ];
  static List<String> basicAsyncList = ['FutureBuilder', 'StreamBuilder'];
  static List<String> basicScrollList = [
    'ListView',
    'NestedScrollView',
    'GridView',
    'SingleChildScrollView',
    'Scrollable',
    'Scrollbar',
    'CustomScrollView',
    'NotificationListener',
    'ScrollConfiguration',
    'RefreshIndicator'
  ];
  static List<String> basicAccessibilityList = [
    'Semantics',
    'MergeSemantics',
    'ExcludeSemantics'
  ];

  ///用来存储二级页面集合
  static List<List<String>> basicWidgetPageList = [
    basicWidgetList,
    basicMaterialComponentsList,
    basicCupertinoComponentsList,
    basicLayoutList,
    basicTextList,
    basicAssetsIconList,
    basicInputList,
    basicAnimationAndMotionList,
    basicInteractionModelList,
    basicStyleList,
    basicPaintAndEffectList,
    basicAsyncList,
    basicScrollList,
    basicAccessibilityList
  ];
  static List<String> animBtnList = [
    'BasicAnim',
    'AnimatedList',
    'HeroAnim',
    'ShareAnim',
    'TweenForTextAnim',
    '仿直播间动画'
  ];
  static List<String> advancedBtnList = [
    '自定义组件-画线',
    '测试',
    '测试demo',
    '可以上下左右滑动的表格',
    'pdfViewer',
    'ListView自动加载数据',
    '百度地图',
    '高德地图'
  ];
  static List<String> aMapList=[
    '高德定位',
    '高德地图'
  ];
  static List<String> baiduMapList = [
    '单次定位',
    '连续定位',
    '圆形地理围栏',
    '多边形地理围栏',
    '监听设备朝向',
    '地图类型示例',
    '百度地图调试页面'
  ];
}
