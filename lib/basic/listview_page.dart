import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({ Key? key }) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title:const Text('ListView') ,),
      body: Container(),
      
    );
  }
}