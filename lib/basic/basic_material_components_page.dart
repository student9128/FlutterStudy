import 'package:flutter/material.dart';

class BasicMaterialComponentsPage extends StatefulWidget {
  const BasicMaterialComponentsPage({ Key? key }) : super(key: key);

  @override
  State<BasicMaterialComponentsPage> createState() => _BasicMaterialComponentsPageState();
}

class _BasicMaterialComponentsPageState extends State<BasicMaterialComponentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Material Components'),),
      body: Container(),
    );
  }
}