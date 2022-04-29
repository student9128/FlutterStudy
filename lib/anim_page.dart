import 'package:flutter/material.dart';

class AnimPage extends StatefulWidget {
  const AnimPage({Key? key}) : super(key: key);

  @override
  State<AnimPage> createState() => _AnimPageState();
}

class _AnimPageState extends State<AnimPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('animPage'));
  }
}
