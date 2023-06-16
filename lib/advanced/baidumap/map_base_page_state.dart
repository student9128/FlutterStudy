import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'dart:async';

/// State 基类
class BMFBaseMapState<T extends StatefulWidget> extends State<T> {
  late BMFMapController mapController;

  late Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(),
    );
  }

  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller) async {
    mapController = controller;

    // Map? map1 = await myMapController.getNativeMapCopyright();
    // print('获取原生地图版权信息：$map1');
    // Map? map2 = await myMapController.getNativeMapApprovalNumber();
    // print('获取原生地图审图号：$map2');
    // Map? map3 = await myMapController.getNativeMapQualification();
    // print('获取原生地图测绘资质：$map3');

    /// 地图加载回调
    mapController.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成');
    });
  }

  /// 设置地图参数
  BMFMapOptions initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(39.917215, 116.380341),
      zoomLevel: 12,
    );
    return mapOptions;
  }

  /// 创建地图
  Container generateMap() {
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: BMFMapWidget(
        onBMFMapCreated: onBMFMapCreated,
        mapOptions: initMapOptions(),
      ),
    );
  }

  /// 创建控制栏
  Widget generateControlBar() {
    throw UnimplementedError();
  }
}
