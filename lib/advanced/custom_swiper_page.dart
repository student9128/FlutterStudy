import 'package:flutter/material.dart';
import 'package:flutter_study_list/advanced/custom_swiper_widget.dart';
import 'package:flutter_study_list/util/asset_utils.dart';

class CustomSwiperPage extends StatefulWidget {
  const CustomSwiperPage({super.key});

  @override
  State<CustomSwiperPage> createState() => _CustomSwiperPageState();
}

class _CustomSwiperPageState extends State<CustomSwiperPage> {
  List<String> imageList = ['emoji1', 'emoji2', 'emoji3', 'emoji4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义Swiper组件'),
      ),
      body: Column(
        children: [
          CustomSwiperWidget(
            height: 150,
              swiperBuilder: (index) {
              debugPrint("index====$index");
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color:Colors.primaries
                      .elementAt(index),
                  child: Image.asset(
                    AssetUtils.getAssetImagePNG(imageList[index]),
                    width: 25,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                );
              },
              data: imageList)
        ],
      ),
    );
  }
}
