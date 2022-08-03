import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicAccessibilityPage extends StatefulWidget {
  const BasicAccessibilityPage({ Key? key }) : super(key: key);

  @override
  State<BasicAccessibilityPage> createState() => _BasicAccessibilityPageState();
}

class _BasicAccessibilityPageState extends State<BasicAccessibilityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('辅助功能'),),
      body: Container(),
    );
  }
}