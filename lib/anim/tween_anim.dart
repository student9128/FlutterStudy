import 'package:flutter/material.dart';

class TweenForTextAnim extends StatefulWidget {
  const TweenForTextAnim({ Key? key }) : super(key: key);

  @override
  State<TweenForTextAnim> createState() => _TweenForTextAnimState();
}

class _TweenForTextAnimState extends State<TweenForTextAnim> with SingleTickerProviderStateMixin{
  String _text = "Hello flutter";
  late AnimationController _controller;
  late Animation<String> _animation;
  late Animation<num> _animationNum;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 10));
    _animation = TextTween(end: _text).animate(_controller);
    _animationNum = Tween<num>(begin:100,end: 200).animate(_controller);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TweenForText'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(onPressed: (){
            _controller.reset();
            _controller.forward();
          }, child: Text('start')),
          AnimatedBuilder(animation: _animation, builder: (context,child){
            return Text(_animation.value);
          }),
          AnimatedBuilder(animation: _animationNum, builder: (context,child){
            return Text(_animationNum.value.toStringAsFixed(0));
          })
        ],
      ),
    );
  }
}
class TextTween extends Tween<String> {
  TextTween({String end = ''}) : super(begin: '', end: end);

  @override
  String lerp(double t) {
    // 在动画过程中 t 的值是从 0 到 1
    var cutoff = (end!.length * t).round();
    // 返回动画时钟t时刻 对应的文字。
    return end!.substring(0, cutoff);
  }
}
