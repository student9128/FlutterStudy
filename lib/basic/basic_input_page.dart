import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicInputPage extends StatefulWidget {
  const BasicInputPage({ Key? key }) : super(key: key);

  @override
  State<BasicInputPage> createState() => _BasicInputPageState();
}

class _BasicInputPageState extends State<BasicInputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input'),),
      body: Container(),
    );
  }
}