import 'package:flutter/material.dart';

class SeriesLocationPage extends StatefulWidget {
  const SeriesLocationPage({super.key});

  @override
  State<SeriesLocationPage> createState() => _SeriesLocationPageState();
}

class _SeriesLocationPageState extends State<SeriesLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('连续定位'),
      ),
    );
  }
}
