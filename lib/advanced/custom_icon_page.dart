import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_study_list/advanced/custom_widgets/custom_circle_widget.dart';
import 'package:flutter_study_list/advanced/custom_widgets/custom_text.dart';
import 'package:flutter_study_list/advanced/custom_widgets/custom_text_widget.dart';

class CustomIconPage extends StatefulWidget {
  const CustomIconPage({super.key});

  @override
  State<CustomIconPage> createState() => _CustomIconPageState();
}

class _CustomIconPageState extends State<CustomIconPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CustomIconPage'),),
      body: Wrap(
        children: [
          Container(
            width: 100,
            height: 40,
            child: CustomTextWidget(width: 100,height: 30,text: '测试',backgroundColor: Colors.amber,radius: 20,),
          ),
            Container(
            width: 50,
            height: 60,
            child: CustomCircleWidget(width: 0,height: 0,text: '测试',backgroundColor: Colors.blue,radius: 25,),
          ),
           Container(
            width: 50,
            height: 70,
            child: CustomCircleWidget(width: 0,height: 0,text: '测试',backgroundColor: Colors.blue,radius: 25,),
          ),
           Container(
            width: 40,
            height: 50,
            child: CustomCircleWidget(width: 0,height: 0,text: '测试',backgroundColor: Colors.blue,radius: 25,),
          ),
        ],
      ),
    );
  }
}