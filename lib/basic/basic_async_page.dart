import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicAsyncPage extends StatefulWidget {
  const BasicAsyncPage({ Key? key }) : super(key: key);

  @override
  State<BasicAsyncPage> createState() => _BasicAsyncPageState();
}

class _BasicAsyncPageState extends State<BasicAsyncPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Async'),),
      body: Container(),
    );
  }
}