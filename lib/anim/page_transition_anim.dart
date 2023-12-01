import 'package:flutter/material.dart';

class PageTransitionAnim extends StatefulWidget {
  const PageTransitionAnim({super.key});

  @override
  State<PageTransitionAnim> createState() => _PageTransitionAnimState();
}

class _PageTransitionAnimState extends State<PageTransitionAnim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageTransitionAnim'),
      ),
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        child: Column(
          children: [],
        ),
      ) ,
    );
  }
}
