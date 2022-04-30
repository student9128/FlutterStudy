import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({ Key? key }) : super(key: key);

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title:const Text('Button') ,),
      body: Container(),
      
    );
  }
}