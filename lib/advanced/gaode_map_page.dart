import 'dart:math';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_study_list/advanced/amap/constants.dart';
import 'package:flutter_study_list/constant/constants.dart';
import 'package:flutter_study_list/constant/route_names.dart';
import 'package:flutter_study_list/routes/application.dart';
import 'package:flutter_study_list/util/list_to_map_utils.dart';
import 'package:permission_handler/permission_handler.dart';
class GaoDeMapPage extends StatefulWidget {
  const GaoDeMapPage({super.key});

  @override
  State<GaoDeMapPage> createState() => _GaoDeMapPageState();
}

class _GaoDeMapPageState extends State<GaoDeMapPage> {
  List<Map<String, String>> _mList=[];
   @override
  void initState() {
    super.initState();
    initAMap();
    _mList=combineList2Map(Constants.aMapList, aMapPageName);
  }
  initAMap(){
     /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    /// <b>必须保证在调用定位功能之前调用， 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// [hasContains] 隐私声明中是否包含高德隐私政策说明
    ///
    /// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// <b>必须保证在调用定位功能之前调用, 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);

    requestPermission();
    AMapFlutterLocation.setApiKey(ConstantConfigs.apiKey, '');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('高德地图'),),body: ListView.builder(
        itemCount: _mList.length+1,
        itemBuilder: ((context, index) {
          return index==_mList.length? Container(height: 16,):Container(
            margin:const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ElevatedButton(
                onPressed: () {
                  debugPrint("current===${_mList}\n pageName=${_mList[index]['pageName']!}");
                  // Application.router.navigateTo(context,_mList[index]['pageName']!);},
                  var pageName = _mList[index]['pageName']!;
                  pageName = pageName.substring(1,pageName.length);
                  debugPrint('pageName=$pageName');
                  Application.router.navigateTo(context,pageName);},
                child: Text(_mList[index]['title']!),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    backgroundColor: MaterialStateProperty.all(Colors.primaries
                        .elementAt(Random.secure()
                            .nextInt(Colors.primaries.length))))),
          );
        })),);
  }
   /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
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
}