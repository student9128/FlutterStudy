import 'package:flutter/material.dart';
import 'package:flutter_study_list/advanced/custom_rectangle.dart';
import 'package:flutter_study_list/advanced/custom_widgets/custom_line.dart';
import 'package:flutter_study_list/advanced/custom_widgets/custom_line2.dart';

class CustomWidgetPage extends StatefulWidget {
  const CustomWidgetPage({ Key? key }) : super(key: key);

  @override
  State<CustomWidgetPage> createState() => _CustomWidgetPageState();
}

class _CustomWidgetPageState extends State<CustomWidgetPage> with SingleTickerProviderStateMixin{
   late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
      controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    ))
      ..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: const Text('CustomWidget'),),
     body: SingleChildScrollView(child:Column(
       children: [
         Container(
           margin: const EdgeInsets.only(left: 50),
           child:  CustomPaint(
           foregroundPainter: LineChatPainter(),
           size: const Size(300, 300),
         ),
         ),
         Container(
           color: Colors.grey,
           margin: const EdgeInsets.only(left: 20,top: 30),
           child:  CustomPaint(
           foregroundPainter: CustomLine(),
           size: Size(MediaQuery.of(context).size.width-40, MediaQuery.of(context).size.width),
         ),
         ),
         Container(
          width: 300,
          height: 300,
          margin: const EdgeInsets.only(top:0),
          child: CustomPaint(
            painter: CustomRectangle(animation: animation.value),
          ),
         )
       
       ],
     ),) , 
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}