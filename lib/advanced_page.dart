import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_list/constant/constants.dart';
import 'package:flutter_study_list/constant/route_names.dart';
import 'package:flutter_study_list/routes/application.dart';
import 'package:flutter_study_list/util/list_to_map_utils.dart';

class AdvancedPage extends StatefulWidget {
  const AdvancedPage({Key? key}) : super(key: key);

  @override
  State<AdvancedPage> createState() => _AdvancedPageState();
}

class _AdvancedPageState extends State<AdvancedPage> {
  List<Map<String, String>> _mList=[];
  @override
  void initState() {
    super.initState();
   _mList=combineList2Map(Constants.advancedBtnList, advancedPageName);
  }
  @override
  Widget build(BuildContext context) {
   return ListView.builder(
        itemCount: _mList.length+1,
        itemBuilder: ((context, index) {
          return index==_mList.length? Container(height: 16,):Container(
            margin:const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ElevatedButton(
                onPressed: () {Application.router.navigateTo(context,_mList[index]['pageName']!);},
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
