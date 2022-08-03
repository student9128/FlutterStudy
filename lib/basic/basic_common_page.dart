import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_list/constant/constants.dart';

class BasicWidgetCommonPage extends StatefulWidget {
  const BasicWidgetCommonPage({ Key? key,required  this.pageListIndex }) : super(key: key);
  ///当前组件集合所在的索引
  final int pageListIndex;

  @override
  State<BasicWidgetCommonPage> createState() => _BasicWidgetCommonPageState();
}

class _BasicWidgetCommonPageState extends State<BasicWidgetCommonPage> {
  List<String> _list=[];
  @override
  void initState() {
    super.initState();
    debugPrint('BasicWidgetCommonPage=======${widget.pageListIndex}');
    if (widget.pageListIndex < Constants.basicWidgetPageList.length) {
      _list = Constants.basicWidgetPageList.elementAt(widget.pageListIndex);
    }
    debugPrint('BasicWidgetCommonPage=======${_list.length}');
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Constants.basicBtnList[widget.pageListIndex])),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 16, maxCrossAxisExtent: 200.0),
            itemCount: _list.length+1,
            itemBuilder: ((context, index) {
              return index == _list.length
                  ? Container(
                      height: 16,
                    )
                  : Container(
                      margin:const EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(_list[index]),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 16)),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.primaries.elementAt(Random.secure()
                                      .nextInt(Colors.primaries.length))))),
                    );
            })),
      ),
    );
  }
}