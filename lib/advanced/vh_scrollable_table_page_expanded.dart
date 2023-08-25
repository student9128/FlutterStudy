import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class VHScrollableTableExpandedPage extends StatefulWidget {
  const VHScrollableTableExpandedPage({Key? key}) : super(key: key);

  @override
  _VHScrollableTableExpandedPageState createState() =>
      _VHScrollableTableExpandedPageState();
}

class _VHScrollableTableExpandedPageState
    extends State<VHScrollableTableExpandedPage> {
  final List<String> _titleList = [
    "标题1",
    "标题2",
    "标题3",
    "标题4",
    "标题5",
    "标题6",
    "标题7"
  ];
  double _leftWidth = 100;
  double _cellWidth = 100;
  double _cellHeight = 45;
  double _cellExpandedHeight = 80;
  final ScrollController _titleController = ScrollController();
  final ScrollController _contentController = ScrollController();
  double tipTop = 0;
  int currentIndex = -1;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateContent);
    _contentController.addListener(_updateTitle);
  }

  void _updateTitle() {
    if (_titleController.offset != _contentController.offset) {
      _titleController.jumpTo(_contentController.offset);
    }
  }

  void _updateContent() {
    if (_contentController.offset != _titleController.offset) {
      _contentController.jumpTo(_titleController.offset);
    }
  }

  @override
  void dispose() {
    _titleController.removeListener(_updateContent);
    _contentController.removeListener(_updateTitle);
    super.dispose();
  }

  Container _buildTitleContainer(int i) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
              right: BorderSide(color: Colors.black, width: 1))),
      alignment: Alignment.center,
      width: _cellWidth,
      height: _cellHeight,
      child: Text(
        _titleList[i],
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  _buildRightTitle() {
    List<Widget> list = [];
    for (int i = 0; i < _titleList.length; i++) {
      list.add(_buildTitleContainer(i));
    }
    return list;
  }

  _buildRightContent(int index) {
    List<Widget> list = [];
    for (int i = 0; i < _titleList.length; i++) {
      list.add(Column(
        children: [
          Container(
            alignment: const Alignment(0, 0),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                    right: BorderSide(color: Colors.black, width: 1))),
            width: _cellWidth,
            height: _cellHeight,
            child: Text(
              "行$index 列${i + 1}",
              style: TextStyle(color: Colors.black),
            ),
          ),
          currentIndex == index
              ? Container(
                  width: _cellWidth,
                  height: _cellExpandedHeight,
                  color: Colors.green,
                )
              : SizedBox()
        ],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var pt = MediaQuery.of(context).padding.top;
    print("object $pt");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('VHScrollableTableExpanded'),
      ),
      body: Container(
        child: Column(
          children: [
             Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1),
                          right: BorderSide(color: Colors.black, width: 1))),
                  width: _leftWidth,
                  height: _cellHeight,
                  alignment: Alignment.center,
                  child: Text('标题', style: TextStyle(color: Colors.green)),
                ),
                Expanded(
                    child: Container(
                  width: _titleList.length * _cellWidth,
                  child: SingleChildScrollView(
                    controller: _titleController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _buildRightTitle(),
                    ),
                  ),
                ))
              ],
            ),
            Expanded(child: SingleChildScrollView(
            child: Column(
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: _leftWidth,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Container(
                                    alignment: const Alignment(0, 0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black, width: 1),
                                            right: BorderSide(
                                                color: Colors.black,
                                                width: 1))),
                                    width: _cellWidth,
                                    height: _cellHeight,
                                    child: Container(
                                      child: Text('左侧$index'),
                                    ),
                                  ),
                                  currentIndex == index
                                      ? Container(
                                          width: _cellWidth,
                                          height: _cellExpandedHeight,
                                          color: Colors.green,
                                        )
                                      : SizedBox()
                                ],
                              ));
                        },
                        itemCount: 50,
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: _titleList.length * _cellWidth,
                        child: ListView.builder(
                          itemCount: 50,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            GlobalKey itemKey = GlobalKey();
                            return GestureDetector(
                              onTap: () {
                                // var box = itemKey.currentContext
                                //     ?.findRenderObject() as RenderBox?;
                                // if (box != null) {
                                //   var offset =
                                //       box.localToGlobal(Offset(0.0, 0.0));
                                //   var _height = offset.dy;
                                //   print(
                                //       "object==$_height,${offset.dx},${box.size}");
                                // }
                                  setState(() {
                                    currentIndex = currentIndex==index?-1:index;
                                    tipTop = (index+1)*45;
                                  });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    key: itemKey,
                                    children: _buildRightContent(index),
                                  ),
                                  // Container(width:100,height: _cellExpandedHeight,color: Colors.amber.shade900,)
                                ],
                              ),
                            );
                          },
                        ),
                        // ),
                      ),
                    ))
                  ],
                ),
                currentIndex!=-1?
                Positioned(
                    left: 0,
                    top: tipTop,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: _cellExpandedHeight,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text('占位'),
                    )):SizedBox()
              ],
            )
          ],
        )))
          ],
        ),
      ),
    );
  }
}
