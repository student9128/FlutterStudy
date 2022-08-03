import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicPaintAndEffectPage extends StatefulWidget {
  const BasicPaintAndEffectPage({ Key? key }) : super(key: key);

  @override
  State<BasicPaintAndEffectPage> createState() => _BasicPaintAndEffectPageState();
}

class _BasicPaintAndEffectPageState extends State<BasicPaintAndEffectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('绘制和效果'),),
      body: Container(),
    );
  }
}