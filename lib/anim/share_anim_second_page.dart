import 'package:flutter/material.dart';
import 'package:flutter_study_list/anim/share_expansion_widget.dart';

class ShareSecondPage extends StatelessWidget {
  final int index;

  const ShareSecondPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 图片矩形是由半径为120的圆得来
    const maxRadius = 120.0;
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Theme.of(context).canvasColor,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: maxRadius * 2,
                height: maxRadius * 2,
                child: Hero(
                  tag: 'hero_tag_$index',
                   createRectTween: (begin,end){
          return MaterialRectCenterArcTween(begin: begin,end: end);
        },
                  child: ShareExpansionWidget(
                    maxRadius: maxRadius,
                    child: Container(
                      color: Colors.red,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return FlutterLogo(size: constraints.maxWidth);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                '第$index个Item',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
