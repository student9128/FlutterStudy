import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicStylePage extends StatefulWidget {
  const BasicStylePage({ Key? key }) : super(key: key);

  @override
  State<BasicStylePage> createState() => _BasicStylePageState();
}

class _BasicStylePageState extends State<BasicStylePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('样式'),),
      body: Container(),
    );
  }
}