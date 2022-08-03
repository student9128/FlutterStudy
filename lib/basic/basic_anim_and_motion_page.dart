import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicAnimMotionPage extends StatefulWidget {
  const BasicAnimMotionPage({ Key? key }) : super(key: key);

  @override
  State<BasicAnimMotionPage> createState() => _BasicAnimMotionPageState();
}

class _BasicAnimMotionPageState extends State<BasicAnimMotionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('动画和Motion'),),
      body: Container(),
    );
  }
}