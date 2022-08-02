import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/anim/share_anim_second_page.dart';
import 'package:flutter_study_list/anim/share_expansion_widget.dart';
    import 'package:flutter/scheduler.dart' show SchedulerBinding, timeDilation;

class ShareFirstPage extends StatefulWidget {
  const ShareFirstPage({ Key? key }) : super(key: key);

  @override
  State<ShareFirstPage> createState() => _ShareFirstPageState();
}

class _ShareFirstPageState extends State<ShareFirstPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) { 
      timeDilation=3.0;
    });
  }
  @override
  void dispose() {
    timeDilation=1.0;
    super.dispose();
  }
   @override
  Widget build(BuildContext context) {
    // 使转场速度变慢，便于观察转场动画形状的变化过程

    return Scaffold(
      appBar: AppBar(title: const Text('FirstPage')),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) => _buildItem(context, index)),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return CupertinoButton(
      child: _buildHeroWidget(index),
      onPressed: () {
        Navigator.of(context).push(
          PageRouteBuilder<void>(
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
              child: ShareSecondPage(index: index),);
              // return SecondPage(index: index);
            },
          ),
        );
      },
    );
  }

  ///目标实现半径 30的圆，转换为半径120的圆包裹的矩形
  Widget _buildHeroWidget(int index) {
    const radius = 30;
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Hero(
        tag: 'hero_tag_$index',
        createRectTween: (begin,end){
          return MaterialRectCenterArcTween(begin: begin,end: end);
        },
        child: ShareExpansionWidget(
          maxRadius: 120,
          child: Container(
            color: Colors.green,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return FlutterLogo(size: constraints.maxWidth);
              },
            ),
          ),
        ),
      ),
    );
  }
}
