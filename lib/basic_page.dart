import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_list/basic/text_page.dart';
import 'package:flutter_study_list/constant/route_names.dart';
import 'package:flutter_study_list/routes/application.dart';
import 'package:flutter_study_list/util/list_to_map_utils.dart';
import 'constant/constants.dart';
class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);
  @override
  State<BasicPage> createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  List<Map<String, String>> _mList=[];
  @override
  initState() {
    super.initState();
    _mList=combineList2Map(Constants.basicBtnList, basicPageName);
    // var random = Random.secure();
    // for (var i = 0; i < Constants.basicBtnList.length; i++) {
    //   _listWidget.add(ElevatedButton(
    //       onPressed: () {
    //         Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Constants.basicPageList[i]));
    //       },
    //       style: ButtonStyle(
    //           backgroundColor: MaterialStateProperty.all(Colors.primaries
    //               .elementAt(random.nextInt(Colors.primaries.length)))),
    //       child: Text(Constants.basicBtnList[i])));
    // }
  }
  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(child:Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
    //   child: Wrap(
    //     spacing:10,
    //     runSpacing: 10,
    //     children: _listWidget
    //   ),
    // ),);
    return ListView.builder(
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
                  Application.router.navigateTo(context,'/basicWidgetCommonPage?pageListIndex=$index&pageName=$pageName');},
                child: Text(_mList[index]['title']!),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    backgroundColor: MaterialStateProperty.all(Colors.primaries
                        .elementAt(Random.secure()
                            .nextInt(Colors.primaries.length))))),
          );
        }));
  }
}
