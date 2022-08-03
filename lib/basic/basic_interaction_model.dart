import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicInteractionModelPage extends StatefulWidget {
  const BasicInteractionModelPage({ Key? key }) : super(key: key);

  @override
  State<BasicInteractionModelPage> createState() => _BasicInteractionModelPageState();
}

class _BasicInteractionModelPageState extends State<BasicInteractionModelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('交互模型'),),
      body: Container(),
    );
  }
}