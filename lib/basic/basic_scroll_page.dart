import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicScrollPage extends StatefulWidget {
  const BasicScrollPage({ Key? key }) : super(key: key);

  @override
  State<BasicScrollPage> createState() => _BasicScrollPageState();
}

class _BasicScrollPageState extends State<BasicScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('滚动'),),
      body: Container(),
    );
  }
}