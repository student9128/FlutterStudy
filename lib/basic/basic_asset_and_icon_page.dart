import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicAssetsAndIconPage extends StatefulWidget {
  const BasicAssetsAndIconPage({ Key? key }) : super(key: key);

  @override
  State<BasicAssetsAndIconPage> createState() => _BasicAssetsAndIconPageState();
}

class _BasicAssetsAndIconPageState extends State<BasicAssetsAndIconPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assets,图片,Icon'),),
      body: Container(),
    );
  }
}