import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_list/basic/text_page.dart';
import 'constant/constants.dart';
class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);
  @override
  State<BasicPage> createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  List<Widget> _listWidget = [];
  @override
  initState() {
    super.initState();
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
        itemCount: Constants.basicBtnList.length+1,
        itemBuilder: ((context, index) {
          return index==Constants.basicBtnList.length? Container(height: 16,):Container(
            margin:const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ElevatedButton(
                onPressed: () {},
                child: Text(Constants.basicBtnList[index]),
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
