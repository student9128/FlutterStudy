import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AMapLocationPage extends StatefulWidget {
  const AMapLocationPage({super.key});

  @override
  State<AMapLocationPage> createState() => _AMapLocationPageState();
}

class _AMapLocationPageState extends State<AMapLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('高德地图定位'),),
    );
  }
}