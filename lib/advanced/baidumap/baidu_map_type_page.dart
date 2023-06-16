import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_study_list/advanced/baidumap/map_base_page_state.dart';

class BaiduMapTypePage extends StatefulWidget {
  const BaiduMapTypePage({super.key});

  @override
  State<BaiduMapTypePage> createState() => _BaiduMapTypePageState();
}

class _BaiduMapTypePageState extends State<BaiduMapTypePage> {
  late BMFMapController mapController;

  @override
  void initState() {
    super.initState();
  }

  void onBMFMapCreated(BMFMapController controller) async {
    mapController = controller;
    mapController.setMapDidLoadCallback(callback: () {
      debugPrint('setMapDidLoadCallback 地图加载完成');
    });
  }

  /// 设置地图参数
  BMFMapOptions initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(39.917215, 116.380341),
      zoomLevel: 14,
      maxZoomLevel: 21,
      minZoomLevel: 4,
    );
    return mapOptions;
  }

  // /// 设置地图参数
  // @override
  // BMFMapOptions initMapOptions() {
  //   BMFCoordinate center = BMFCoordinate(39.965, 116.404);
  //   BMFMapOptions mapOptions = BMFMapOptions(
  //       mapType: BMFMapType.Standard,
  //       zoomLevel: 12,
  //       maxZoomLevel: 21,
  //       minZoomLevel: 4,
  //       logoPosition: BMFLogoPosition.LeftBottom,
  //       mapPadding: BMFEdgeInsets(top: 0, left: 50, right: 50, bottom: 0),
  //       overlookEnabled: true,
  //       overlooking: -15,
  //       center: center);
  //   return mapOptions;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百度地图类型')),
      body: BMFMapWidget(
        onBMFMapCreated: onBMFMapCreated,
        mapOptions: initMapOptions(),
      ),
    );
  }
}
