import 'package:flutter/material.dart';

class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);
  @override
  State<BasicPage> createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('basicPage'),);
  }
}
