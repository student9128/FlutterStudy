import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicTextPage extends StatefulWidget {
  const BasicTextPage({ Key? key }) : super(key: key);

  @override
  State<BasicTextPage> createState() => _BasicTextPageState();
}

class _BasicTextPageState extends State<BasicTextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text'),),
      body: Container(),
    );
  }
}