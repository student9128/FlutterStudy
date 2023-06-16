import 'package:flutter/material.dart';

class HeadingLocationPage extends StatefulWidget {
  const HeadingLocationPage({super.key});

  @override
  State<HeadingLocationPage> createState() => _HeadingLocationPageState();
}

class _HeadingLocationPageState extends State<HeadingLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('监听设备朝向'),
      ),
    );
  }
}
