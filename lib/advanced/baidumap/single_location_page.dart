import 'package:flutter/material.dart';

class SingleLocationPage extends StatefulWidget {
  const SingleLocationPage({Key? key}) : super(key: key);

  @override
  State<SingleLocationPage> createState() => _SingleLocationPageState();
}

class _SingleLocationPageState extends State<SingleLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SingleLocation'),),
    );
  }
}
