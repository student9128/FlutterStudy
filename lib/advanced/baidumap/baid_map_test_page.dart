import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
class BaiduMapTestPage extends StatefulWidget {
  const BaiduMapTestPage({super.key});

  @override
  State<BaiduMapTestPage> createState() => _BaiduMapTestPageState();
}

class _BaiduMapTestPageState extends State<BaiduMapTestPage> {
  late BMFMapController mapController;
  /// 创建完成回调
  void _onBMFMapCreated(BMFMapController controller) async {
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
  BMFMapOptions _initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
        center: BMFCoordinate(39.917215, 116.380341),
        zoomLevel: 12,
        mapPadding: BMFEdgeInsets(top: 0, left: 0, right: 0, bottom: 0));
    return mapOptions;
  }
  Widget _createMapContainer() {
    return SizedBox(
        height: 300,
        child: BMFMapWidget(
          onBMFMapCreated: (controller) {
            _onBMFMapCreated(controller);
          },
          mapOptions: _initMapOptions(),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百度地图调试页面'),),
      body: BMFMapWidget(
        onBMFMapCreated: (controller){
          _onBMFMapCreated(controller);
        },
        mapOptions: _initMapOptions(),
      ),
    );
  }
}
