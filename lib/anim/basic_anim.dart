import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_list/advanced/custom_widgets/chart_line.dart';

///平移，旋转，缩放，渐变
class BasicAnim extends StatefulWidget {
  const BasicAnim({ Key? key }) : super(key: key);

  @override
  State<BasicAnim> createState() => _BasicAnimState();
}

class _BasicAnimState extends State<BasicAnim> with TickerProviderStateMixin{
  AnimationController? _animationController;
  late Animation<double> _animation;
  late Animation<double> _animationRotate;
  late Animation<Offset> _animationOffset;
  late Animation<double> _animationSize;
  late Animation<Decoration> _animationDecoration;
  
  ///0平移，1旋转，2缩放，3渐变
  int currentType = 0;
  @override
  void initState() {
    super.initState();
     _animationController =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            if(currentType!=4&&currentType!=5){
            _animationController?.reverse();
            }else{
              // _animationController?.repeat();
            }
          } else if (status == AnimationStatus.dismissed) {
            _animationController?.forward();
          }
        });
  _animationRotate = Tween(begin: 0.0, end: 1.0 * pi).animate(_animationController!);
  _animationOffset = Tween(begin: Offset(0,0), end:Offset(0.7,.3)).animate(_animationController!);
  _animation = Tween(begin:1.0, end:0.5).animate(_animationController!);
  _animationSize = Tween(begin:0.0, end:1.0).animate(_animationController!);
  _animationDecoration = DecorationTween(
            begin: BoxDecoration(color: Colors.blue, border: Border.all(style: BorderStyle.none),borderRadius: BorderRadius.circular(0)),
            end: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: Colors.amber,blurRadius: 10,spreadRadius: 3,offset: Offset(0,6)),
            ]))
        .animate(_animationController!);
    //开始动画
  // _animationController?.forward();
  }
  Widget rectangleContainer = Container(width: 50,height: 50,color: Colors.red,);
  Widget _buildAnimContainer() {
    switch (currentType) {
      case 0:
        return SlideTransition(
          position: _animationOffset,
          child: rectangleContainer,
        );
      // return Transform.translate(offset:Offset(_animation.value*1.0,_animation.value*1.0),child: child,);
      case 1:
        return RotationTransition(
          turns: _animationRotate,
          child: rectangleContainer,
        );
      case 2:
        return ScaleTransition(
          scale: _animation,
          child: rectangleContainer,
        );
      case 3:
        return FadeTransition(
          opacity: _animation,
          child: rectangleContainer,
        );
        case 4:
        return SizeTransition(
          sizeFactor: _animationSize,
          axis: Axis.horizontal,
          axisAlignment: -1,
          child: rectangleContainer,
        );
        case 5:
        return Container(
          alignment: Alignment.center,
          child: SizeTransition(
          sizeFactor: _animationSize,
          axis: Axis.vertical,
          axisAlignment: -1,
          child:Center(child:  rectangleContainer,),
        ));
           case 6:
        return DecoratedBoxTransition(decoration: _animationDecoration, child:Container(child: rectangleContainer,
        padding: EdgeInsets.all(10),) );
    }
    return rectangleContainer;
  }
  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('BasicAnim') ,),
      body: Column(
        children: [
          Wrap(
            spacing: 5.0,
            children: [
              ElevatedButton(
                  onPressed: () {
                      this.setState(() {
                      currentType=0;
                    });
                    Future.delayed(Duration(seconds: 1),(){
                    _animationController?.forward();
                    });
                  },
                  child: Text('平移')),
              ElevatedButton(
                  onPressed: () {
                    this.setState(() {
                      currentType=1;
                    });
                    _animationController?.forward();
                  },
                  child: Text('旋转')),
              ElevatedButton(
                  onPressed: () {
                         this.setState(() {
                      currentType=2;
                    });
                    Future.delayed(Duration(seconds: 1),(){
                    _animationController?.forward();
                    });
                  },
                  child: Text('缩放')),
              ElevatedButton(
                  onPressed: () {
                         this.setState(() {
                      currentType=3;
                    });
                    Future.delayed(Duration(seconds: 1),(){
                    _animationController?.forward();
                    });
                  },
                  child: Text('渐变')),
              ElevatedButton(
                  onPressed: () {
                         this.setState(() {
                      currentType=4;
                    });
                    Future.delayed(Duration(seconds: 1),(){
                    _animationController?.forward();
                    });
                  },
                  child: Text('横向出现')),
              ElevatedButton(
                  onPressed: () {
                         this.setState(() {
                      currentType=5;
                    });
                    Future.delayed(Duration(seconds: 1),(){
                    _animationController?.forward();
                    });
                  },
                  child: Text('竖向出现')),
                      ElevatedButton(
                  onPressed: () {
                         this.setState(() {
                      currentType=6;
                    });
                    Future.delayed(Duration(seconds: 1),(){
                    _animationController?.forward();
                    });
                  },
                  child: Text('decoration属性变化动画')),
              ElevatedButton(
                  onPressed: () {
                    _animationController?.stop(canceled: false);
                    // _animationController?.reset();
                  },
                  child: Text('暂停'))
            ],
          ),
          _buildAnimContainer(),
          // AnimatedBuilder(animation: _animation, builder:(context, child){
          //   switch(currentType){
          //     case 0:
          //     return SlideTransition(position: _animation as Animation<Offset>,child: child,);
          //     // return Transform.translate(offset:Offset(_animation.value*1.0,_animation.value*1.0),child: child,);
          //     case 1:
          //     return Transform.rotate(angle:_animation.value,child: child,);
          //     case 2:
          //     return Transform.scale(scale: _animation.value,child: child,);
          //     case 3:
          //     return AnimatedOpacity(opacity: _animation.value, duration: Duration(seconds: 2),child: child,)
          //     ;
          //   }
          //   return Transform.translate(offset:Offset(100,200),child: child,);
            
          // },child: Container(width: 100,height: 100,color: Colors.red,), ),

          Container(
            width: 300,
            height: 300,
            child: CustomPaint(painter: ChartLine(),),)
        ],
      ),
      
    );
  }
}