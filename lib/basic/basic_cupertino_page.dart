import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicCupertinoPage extends StatefulWidget {
  const BasicCupertinoPage({ Key? key }) : super(key: key);

  @override
  State<BasicCupertinoPage> createState() => _BasicCupertinoPageState();
}

class _BasicCupertinoPageState extends State<BasicCupertinoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cupertino(iOS风格的widget)'),),
      body: Container(),
    );
  }
}