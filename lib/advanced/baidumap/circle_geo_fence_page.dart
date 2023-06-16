import 'package:flutter/material.dart';

class CircleGeoFencePage extends StatefulWidget {
  const CircleGeoFencePage({super.key});

  @override
  State<CircleGeoFencePage> createState() => _CircleGeoFencePageState();
}

class _CircleGeoFencePageState extends State<CircleGeoFencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆形地理围栏'),
      ),
    );
  }
}
