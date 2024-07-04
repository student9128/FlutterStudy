import 'package:flutter/material.dart';
import 'package:flutter_study_list/advanced/custom_swiper_widget.dart';
import 'package:flutter_study_list/util/asset_utils.dart';

class CustomSwiperPage extends StatefulWidget {
  const CustomSwiperPage({super.key});

  @override
  State<CustomSwiperPage> createState() => _CustomSwiperPageState();
}

class _CustomSwiperPageState extends State<CustomSwiperPage> {
  List<String> imageList = [
    'emoji1',
    'emoji2',
    'emoji3',
    'emoji4',
    'emoji5',
    'emoji6'
  ];

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
                  decoration: BoxDecoration(
                      color: Colors.primaries.elementAt(index),
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    AssetUtils.getAssetImagePNG(imageList[index]),
                    width: 25,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                );
              },
              titleBuilder: (index) => Text(imageList[index]),
              data: imageList),
          SizedBox(
            height: 10,
          ),
          CustomSwiperWidget(
              height: 150,
              swiperBuilder: (index) {
                debugPrint("index====$index");
                return Stack(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.primaries.elementAt(index),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      AssetUtils.getAssetImagePNG(imageList[index]),
                      width: 25,
                      height: 25,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 16,
                      right: 16,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(imageList[index]),
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)))))
                ]);
              },
              titleBuilder: (index) => Text(imageList[index]),
              data: imageList),
        ],
      ),
    );
  }
}
