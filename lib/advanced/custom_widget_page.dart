import 'package:flutter/material.dart';
import 'package:flutter_study_list/advanced/custom_rectangle.dart';
import 'package:flutter_study_list/advanced/custom_widgets/custom_line.dart';
import 'package:flutter_study_list/advanced/custom_widgets/custom_line2.dart';
import 'package:flutter_study_list/advanced/custom_widgets/progress_ball.dart';
import 'package:flutter_study_list/advanced/custom_widgets/wave_painter.dart';

class CustomWidgetPage extends StatefulWidget {
  const CustomWidgetPage({ Key? key }) : super(key: key);

  @override
  State<CustomWidgetPage> createState() => _CustomWidgetPageState();
}
class _CustomWidgetPageState extends State<CustomWidgetPage> with TickerProviderStateMixin{
   late Animation<double> animation;
  late AnimationController controller;

  late AnimationController wareController;
  late AnimationController mainController;
  late AnimationController secondController;

  late Animation<double> waveAnimation;
  late Animation<double> mainAnimation;
  late Animation<double> secondAnimation;
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
    wareController = AnimationController(duration: const Duration(seconds: 10), vsync: this);
    waveAnimation = Tween<double>(begin: 0.1,end:0.5 ).animate(wareController);
    wareController.forward();
    mainController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
     mainAnimation =Tween(begin: 0.0, end:300.0).animate(mainController);
     mainController.repeat();
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
        //  Container(
        //       width: 300,
        //       height: 300,
        //       margin: const EdgeInsets.only(top: 0),
        //       child: CustomPaint(
        //         painter: CustomRectangle(animation: animation.value),
        //       ),
        //     ),
            Container(
              width: 300,
              height: 300,
              margin: const EdgeInsets.only(top: 20,bottom: 20),
              child: CustomPaint(
                // painter: WavyPainter(0.5,100,Colors.red),
                painter: ProgressBall(animation: waveAnimation.value,progress:0.5,offsetX:mainAnimation.value ),
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