import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_study_list/advanced/custom_widgets/custom_circle.dart';
import 'package:permission_handler/permission_handler.dart';

class BaiduMapTestPage extends StatefulWidget {
  const BaiduMapTestPage({super.key});

  @override
  State<BaiduMapTestPage> createState() => _BaiduMapTestPageState();
}

class _BaiduMapTestPageState extends State<BaiduMapTestPage> {
  late BMFMapController mapController;
  LocationFlutterPlugin baiduLocationPlugin = LocationFlutterPlugin();
  List<BMFMarker> markerList = [];

  @override
  void initState() {
    super.initState();
    requestPermission();
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
    // _handleLocation();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   startLocation();
    // });
  }

  // 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      // 权限申请通过
      startLocation();
    } else {
      debugPrint('无法获取定位权限');
      // showToast('无法获取定位权限');
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  startLocation() async {
    debugPrint('startLocation');

    /// 设置android端和ios端定位参数
    /// android 端设置定位参数
    /// ios 端设置定位参数
    Map iosMap = initIOSOptions().getMap();
    Map androidMap = initAndroidOptions().getMap();

    await baiduLocationPlugin.prepareLoc(androidMap, iosMap);
    baiduLocationPlugin.stopLocation();
    baiduLocationPlugin.startLocation();
  }

  BaiduLocationIOSOption initIOSOptions() {
    BaiduLocationIOSOption options = BaiduLocationIOSOption(
        coordType: BMFLocationCoordType.bd09ll,
        BMKLocationCoordinateType: 'BMKLocationCoordinateTypeBMK09LL',
        desiredAccuracy: BMFDesiredAccuracy.best);
    return options;
  }

  /// 设置地图参数
  BaiduLocationAndroidOption initAndroidOptions() {
    BaiduLocationAndroidOption options = BaiduLocationAndroidOption(
        coorType: 'bd09ll',
        locationMode: BMFLocationMode.hightAccuracy,
        isNeedAddress: true,
        isNeedAltitude: true,
        isNeedLocationPoiList: true,
        isNeedNewVersionRgc: true,
        isNeedLocationDescribe: true,
        openGps: true,
        locationPurpose: BMFLocationPurpose.sport,
        coordType: BMFLocationCoordType.bd09ll);
    return options;
  }

  _handleLocation() {
    baiduLocationPlugin.seriesLocationCallback(
        callback: (BaiduLocation result) {
      debugPrint(
          'result=${result.address},${result.city},${result.latitude},${result.longitude}');
      var currentPosition =
          BMFCoordinate(result.latitude ?? 0, result.longitude ?? 0);

      // BMFMarker marker = BMFMarker.icon(
      //     // draggable: true,
      //     // enabled: true,
      //     position: currentPosition,
      //     icon: 'assets/images/icon_car.png',
      //     title: 'flutterMarker',
      //     selected: true,
      //     canShowCallout: true,
      //     identifier: 'flutter_marker');
      // BMFMarker marker1 = BMFMarker.icon(
      //     position: BMFCoordinate(39.917215, 116.380341),
      //     icon: 'assets/images/icon_car.png',
      //     title: 'carMarker',
      //     identifier: 'car_marker');
      // List<BMFMarker> list = [marker];
      // marker.scaleX = 6;
      // marker.scaleY = 6;
      // mapController.addMarker(marker);
      mapController.setMapClickedMarkerCallback(callback: (BMFMarker marker) {
        debugPrint(
            'marker=${marker.centerOffset},${marker.title},${marker.position}');
        mapController.setCenterCoordinate(marker.position, true);
        mapController.setZoomTo(19);
        BMFCoordinate info =
            BMFCoordinate(marker.position.latitude, marker.position.longitude);
      });
      // mapController.addMarkers(list);
      BMFCircle circle = BMFCircle(
          center: currentPosition,
          radius: 50,
          //设置半径大小
          width: 1,
          strokeColor: Colors.red.withOpacity(0.3),
          fillColor: Colors.red.withOpacity(0.3));
      mapController.addCircle(circle);
      mapController.setCenterCoordinate(currentPosition, true);
      // BMFText bmfText = BMFText(
      //     text: 'hello world',
      //     position: currentPosition,
      //     bgColor: Colors.blue,
      //     fontColor: Colors.red,
      //     fontSize: 40,
      //     typeFace: BMFTypeFace(
      //         familyName: BMFFamilyName.sMonospace,
      //         textStype: BMFTextStyle.BOLD_ITALIC),
      //     alignY: BMFVerticalAlign.ALIGN_TOP,
      //     alignX: BMFHorizontalAlign.ALIGN_LEFT,
      //     rotate: 30.0);
      // mapController.addText(bmfText);
      BMFLocation location = BMFLocation(
          coordinate: BMFCoordinate(
            result.latitude ?? 0,
            result.longitude ?? 0,
          ),
          altitude: 0,
          horizontalAccuracy: 5,
          verticalAccuracy: -1.0,
          accuracy: 10.0,
          speed: -1.0,
          course: -1.0);
      BMFUserLocation userLocation = BMFUserLocation(
        location: location,
      );
      mapController.updateLocationData(userLocation);
      BMFUserLocationDisplayParam displayParam = BMFUserLocationDisplayParam(
          locationViewOffsetX: 0,
          locationViewOffsetY: 0,
          accuracyCircleFillColor: Colors.red,
          accuracyCircleStrokeColor: Colors.blue,
          isAccuracyCircleShow: true,
          enableDirection: true,
          userTrackingMode: BMFUserTrackingMode.Heading,
          locationViewImage: 'assets/images/emoji14.png',
          locationViewHierarchy:
              BMFLocationViewHierarchy.LOCATION_VIEW_HIERARCHY_TOP);
      mapController.updateLocationViewWithParam(displayParam);
      addRandomMarker(result.latitude ?? 0, result.longitude ?? 0);

      baiduLocationPlugin.stopLocation();
    });
  }

  addRandomMarker(double lat, double lon) async {
    if (markerList.isNotEmpty) {
      mapController.removeMarkers(markerList);
    }
    List<List<double>> points =
        generateRandomPoints(lat, lon, 3000, Random().nextInt(20) + 20);
    for (List<double> p in points) {
      // debugPrint('p==${p[0]}, ${p[1]}');
      Uint8List markerData = await createImage();
      BMFMarker marker1 = BMFMarker.iconData(
          position: BMFCoordinate(p[0], p[1]),
          iconData: markerData,
          title: 'baiduMarker',
          identifier: 'baidu_marker');
      markerList.add(marker1);
      mapController.addMarker(marker1);
    }
  }

  Future<Uint8List> createImage() async {
    double pixelRatio = window.devicePixelRatio;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final size = Size(28 * pixelRatio, 30 * pixelRatio);
    final width = size.width * pixelRatio;
    final height = size.height * pixelRatio;
    final paintBounds = Rect.fromPoints(Offset.zero, Offset(width, height));
    final clipRect = Rect.fromLTWH(0, 0, width, height);

    canvas.clipRect(clipRect);
    CustomCirclePainter painter = CustomCirclePainter(
      text: '测试',
      backgroundColor: Colors.primaries
          .elementAt(Random.secure().nextInt(Colors.primaries.length)),
      radius: 12 * pixelRatio,
    );
    painter.paint(canvas, size);
    final picture = recorder.endRecording();
    final image =
        await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  generateRandomPoints(double lat, double lng, double radius, int count) {
    // Convert radius from meters to degrees
    double radiusInDegrees = radius / 111000;

    List<List<double>> points = [];

    for (int i = 0; i < count; i++) {
      // Generate random angles
      double randomAngle = Random().nextDouble() * pi * 2;
      double randomRadius = sqrt(Random().nextDouble()) * radiusInDegrees;

      // Calculate the new point's coordinates
      double newLat = lat + (randomRadius * cos(randomAngle));
      double newLng = lng + (randomRadius * sin(randomAngle));

      points.add([newLat, newLng]);
    }

    return points;
  }

  /// 创建完成回调
  void _onBMFMapCreated(BMFMapController controller) async {
    mapController = controller;
    mapController.showUserLocation(true);

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
    /// 地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
    mapController.setMapOnDrawMapFrameCallback(
        callback: (BMFMapStatus mapStatus) {
//       print('地图渲染每一帧\n mapStatus = ${mapStatus.toMap()}');
        });
    /// 地图区域即将改变时会调用此接口
    /// mapStatus 地图状态信息
    mapController.setMapRegionWillChangeCallback(
        callback: (BMFMapStatus mapStatus) {
          print('地图区域即将改变时会调用此接口1\n mapStatus = ${mapStatus.toMap()}');
        });

    /// 地图区域改变完成后会调用此接口
    /// mapStatus 地图状态信息
    mapController.setMapRegionDidChangeCallback(
        callback: (BMFMapStatus mapStatus) {
          print('地图区域改变完成后会调用此接口2\n mapStatus = ${mapStatus.toMap()}');
        });

    /// 地图区域即将改变时会调用此接口
    /// mapStatus 地图状态信息
    /// reason 地图改变原因
    mapController.setMapRegionWillChangeWithReasonCallback(callback:
        (BMFMapStatus mapStatus, BMFRegionChangeReason regionChangeReason) {
      print(
          '地图区域即将改变时会调用此接口3\n mapStatus = ${mapStatus.toMap()}\n reason = ${regionChangeReason.index}');
    });

    /// 地图区域改变完成后会调用此接口
    /// mapStatus 地图状态信息
    /// reason 地图改变原因
    mapController.setMapRegionDidChangeWithReasonCallback(callback:
        (BMFMapStatus mapStatus, BMFRegionChangeReason regionChangeReason) {
      print(
          '地图区域改变完成后会调用此接口4\n mapStatus = ${mapStatus.toMap()}\n reason = ${regionChangeReason.index}');
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
      appBar: AppBar(
        title: Text('百度地图调试页面'),
      ),
      body:Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BMFMapWidget(
              onBMFMapCreated: (controller) {
                _onBMFMapCreated(controller);
              },
              mapOptions: _initMapOptions(),
            )),
        Container(width: 10,height: 10,color: Colors.red,)
      ],) ,
    );
  }
}
