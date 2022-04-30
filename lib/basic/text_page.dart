import 'package:flutter/material.dart';

class TextPage extends StatefulWidget {
  const TextPage({ Key? key }) : super(key: key);

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Text') ,),
      body: Container(),
      
    );
  }
}