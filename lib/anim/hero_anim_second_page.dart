import 'package:flutter/material.dart';

class HeroAnimSecondPage extends StatefulWidget {
  const HeroAnimSecondPage({ Key? key }) : super(key: key);

  @override
  State<HeroAnimSecondPage> createState() => _HeroAnimSecondPageState();
}

class _HeroAnimSecondPageState extends State<HeroAnimSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
       appBar: AppBar(
        title: const Text('HeroAnimDetailPage'),
      ),
      body: Column(
        children: [
          Hero(
            tag: 'hello',
            child: FlutterLogo(
              size: 200,
              textColor: Colors.amber.shade700,
              // style: FlutterLogoStyle.horizontal,
            ),
          ),
          Text('哈哈')
        ],
      ),
      
    );
  }
}