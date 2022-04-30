import 'package:flutter/material.dart';

class CustomWidgetPage extends StatefulWidget {
  const CustomWidgetPage({ Key? key }) : super(key: key);

  @override
  State<CustomWidgetPage> createState() => _CustomWidgetPageState();
}

class _CustomWidgetPageState extends State<CustomWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text('CustomWidget'),),
     body: Container(child: Text('custom'),), 
    );
  }
}