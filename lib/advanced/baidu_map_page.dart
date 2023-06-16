import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/constant/constants.dart';
import 'package:flutter_study_list/constant/route_names.dart';
import 'package:flutter_study_list/routes/application.dart';
import 'package:flutter_study_list/util/list_to_map_utils.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
class BaiduMapPage extends StatefulWidget {
  const BaiduMapPage({Key? key}) : super(key: key);

  @override
  State<BaiduMapPage> createState() => _BaiduMapPageState();
}

class _BaiduMapPageState extends State<BaiduMapPage> {
  List<Map<String, String>> _mList=[];
  @override
  void initState() {
    super.initState();
    initBaiduMap();
    _mList=combineList2Map(Constants.baiduMapList, baiduMapPageName);
  }
  initBaiduMap() async {
    BMFMapSDK.setAgreePrivacy(true);
    await BMFAndroidVersion.initAndroidVersion();
    // BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
    Map? map = await BMFMapVersion.nativeMapVersion;
    print('获取原生地图版本号：$map');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baidu Map'),),
      body: ListView.builder(
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
        })),
    );
  }
}
