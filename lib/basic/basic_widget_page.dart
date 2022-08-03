import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_list/constant/constants.dart';

class BasicWidgetPage extends StatefulWidget {
  const BasicWidgetPage({ Key? key }) : super(key: key);

  @override
  State<BasicWidgetPage> createState() => _BasicWidgetPageState();
}

class _BasicWidgetPageState extends State<BasicWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('基础组件'),),
      body: ListView.builder(
        itemCount: Constants.basicWidgetList.length+1,
        itemBuilder: ((context, index) {
          return index==Constants.basicWidgetList.length? Container(height: 16,):Container(
            margin:const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ElevatedButton(
                onPressed: () {},
                child: Text(Constants.basicWidgetList[index]),
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