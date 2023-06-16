import 'package:flutter/material.dart';

class PolygonGeoFencePage extends StatefulWidget {
  const PolygonGeoFencePage({super.key});

  @override
  State<PolygonGeoFencePage> createState() => _PolygonGeoFencePageState();
}

class _PolygonGeoFencePageState extends State<PolygonGeoFencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('多边形地理围栏'),
      ),
    );
  }
}
