import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:flutter_study_list/advanced/amap/constants.dart';

class AMapPage extends StatefulWidget {
  const AMapPage({super.key});

  @override
  State<AMapPage> createState() => _AMapPageState();
}

class _AMapPageState extends State<AMapPage> {
  late AMapController mapController;
  AMapFlutterLocation mapLocationPlugin = AMapFlutterLocation();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      startLocation();
    });
    mapLocationPlugin.onLocationChanged().listen((result) {
      debugPrint('result====$result');
      mapLocationPlugin.stopLocation();
      mapController.moveCamera(CameraUpdate.newLatLng(LatLng(
          double.parse('${result['latitude'] ?? 0}'),
          double.parse('${result['longitude'] ?? 0}'))));
    });
  }
  @override
  void dispose() {
    super.dispose();
    mapLocationPlugin.stopLocation();
    mapLocationPlugin.destroy();
  }
  void setLocationOption(){
    if (null != mapLocationPlugin) {
      AMapLocationOption locationOption = AMapLocationOption();

      ///是否单次定位
      locationOption.onceLocation = true;

      ///是否需要返回逆地理信息
      locationOption.needAddress = true;

      ///逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.DEFAULT;

      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      ///设置Android端连续定位的定位间隔
      locationOption.locationInterval = 2000;

      ///设置Android端的定位模式<br>
      ///可选值：<br>
      ///<li>[AMapLocationMode.Battery_Saving]</li>
      ///<li>[AMapLocationMode.Device_Sensors]</li>
      ///<li>[AMapLocationMode.Hight_Accuracy]</li>
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

      ///设置iOS端的定位最小更新距离<br>
      locationOption.distanceFilter = -1;

      ///设置iOS端期望的定位精度
      /// 可选值：<br>
      /// <li>[DesiredAccuracy.Best] 最高精度</li>
      /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
      /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
      /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
      /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
      locationOption.desiredAccuracy = DesiredAccuracy.Best;

      ///设置iOS端是否允许系统暂停定位
      locationOption.pausesLocationUpdatesAutomatically = false;

      ///将定位参数设置给定位插件
      mapLocationPlugin.setLocationOption(locationOption);
    }
  }
  void startLocation(){
    setLocationOption();
    mapLocationPlugin.startLocation();

  }
  void stopLocation(){
    mapLocationPlugin.stopLocation();
  }

  void onMapCreated(AMapController controller) {
    mapController = controller;
    getApprovalNumber();
  }

  void getApprovalNumber() async {
    String? contentApprovalNumber =
        await mapController.getMapContentApprovalNumber();
    String? satelliteImageApprovalNumber =
        await mapController.getSatelliteImageApprovalNumber();
    debugPrint(
        'contentApprovalNumber=$contentApprovalNumber,satelliteImageApprovalNumber=$satelliteImageApprovalNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('高德地图地图示例'),
      ),
      body: Container(
          child: Stack(
        children: [
          Container(
            child: AMapWidget(
              privacyStatement: AMapPrivacyStatement(
                  hasContains: true, hasShow: true, hasAgree: true),
              apiKey: AMapApiKey(
                  androidKey: ConstantConfigs.apiKey, iosKey: ''),
              onMapCreated: onMapCreated,
               myLocationStyleOptions: MyLocationStyleOptions(
        true,
        circleFillColor: Colors.lightBlue,
        circleStrokeColor: Colors.blue,
        circleStrokeWidth: 1,
      )
            ),
          )
        ],
      )),
    );
  }
}
