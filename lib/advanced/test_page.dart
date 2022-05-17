import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  _buildItem() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 400,
            height: 300,
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      width: 100,
                      height: 150,
                      color: Colors.primaries[0],
                    ),
                    Container(
                      width: 100,
                      height: 150,
                      color: Colors.primaries[index % Colors.primaries.length],
                    ),
                    Container(
                      width: 100,
                      height: 150,
                      color: Colors.primaries[2],
                    ),
                    Container(
                      width: 100,
                      height: 150,
                      color: Colors.primaries[index % Colors.primaries.length],
                    ),
                  ],
                );
              },
            ),
            // ),
          ),
          // child: Row(
          //     children: List.generate(50, (index) {
          //   return Container(
          //     width: 100,
          //     height: 150,
          //     color: Colors.primaries[index % Colors.primaries.length],
          //   );
          // }).toList()),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return CustomScrollView(
  //     controller: null,
  //     slivers: <Widget>[
  //       SliverList(delegate: SliverChildBuilderDelegate((BuildContext context,int index){
  //         return ShopList1();
  //       },childCount: 5)),
  //     ],
  //   );
  // }

  ShopList1() {
    //第一层纵向list的item
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text("CFA热门课程推荐"),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ShopList2(context);
                }),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 5, 12, 6),
            child: Text(
              "更多CFA课程》",
              style: TextStyle(color: Colors.red, fontSize: 13),
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),
        ],
      ),
    );
  }

  ShopList2(BuildContext context) {
    //第二层横向list的item
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Image.network(
                "http://uploads/20190930/1b63b52ed7392d869a19a5a7bf01ce7b.jpg"),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "CFA金融硕士+FRM精英计划课程班",
                style: TextStyle(
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              )),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "￥900",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    "663人已购",
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                  flex: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TestPage')),
      body: Container(
        color: Colors.pinkAccent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: new NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                  child: Text(
                                'hello $index',
                              )),
                              // Container(
                              //     child: Text(
                              //   'java $index',
                              // )),
                              // Container(
                              //     child: Text(
                              //   'android $index',
                              // )),
                              // Container(
                              //     child: Text(
                              //   'kotlin $index',
                              // )),
                            ],
                          ),
                        );
                      },
                      itemCount: 20,
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 600,
                      // height: 300,
                      child: ListView.builder(
                        itemCount: 20,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            //  width: 400,
                            // height: 150,
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  color: Colors.primaries[0],
                                  child: Text('flutter $index',),
                                ),
                                Container(
                                  width: 100,
                                  height: 50,
                                  color: Colors.primaries[
                                      index % Colors.primaries.length],
                                  child: Text('kotlin $index',),
                                ),
                                Container(
                                  width: 100,
                                  height: 50,
                                  color: Colors.primaries[2],
                                  child: Text('hello $index',),
                                ),
                                Container(
                                  width: 100,
                                  height: 50,
                                  color: Colors.primaries[
                                      index % Colors.primaries.length],
                                  child: Text('hello $index',),
                                ),  Container(
                                  width: 100,
                                  height: 50,
                                  color: Colors.primaries[3],
                                  child: Text('java $index',),
                                ),  Container(
                                  width: 100,
                                  height: 50,
                                  color: Colors.primaries[
                                      index % Colors.primaries.length],
                                  child: Text('vue $index',),
                                ),
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
              // Row(
              //   children: [
              //     Expanded(
              //         child: Container(
              //       color: Colors.pink,
              //       height: 600,
              //       child: ListView.builder(
              //         itemBuilder: (context, index) {
              //           return Container(
              //             child: Text('hello $index'),
              //           );
              //         },
              //         itemCount: 100,
              //       ),
              //     )),
              //     Expanded(
              //         child: Container(
              //       color: Colors.blue,
              //       height: 600,
              //       child: SingleChildScrollView(
              //         scrollDirection: Axis.horizontal,
              //         child: ListView.builder(
              //           shrinkWrap: true,
              //           physics: new NeverScrollableScrollPhysics(),
              //           itemBuilder: (context, index) {
              //             return Container(
              //               child: Row(
              //                 children: [
              //                   Container(
              //                       child: Text(
              //                     'hello $index',
              //                   )),
              //                   Container(
              //                       child: Text(
              //                     'java $index',
              //                   )),
              //                   Container(
              //                       child: Text(
              //                     'android $index',
              //                   )),
              //                   Container(
              //                       child: Text(
              //                     'kotlin $index',
              //                   )),
              //                 ],
              //               ),
              //             );
              //           },
              //           itemCount: 100,
              //         ),
              //         // )  ,
              //       ),
              //     )),
              //   ],
              // ),
              Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width,
                height: 600,
              ),
              Container(
                color: Colors.yellow,
                width: MediaQuery.of(context).size.width,
                height: 500,
              ),
              Container(
                color: Colors.red,
                width: MediaQuery.of(context).size.width,
                height: 400,
                // child: Row(
                //   children: [
                //     Expanded(
                //       flex: 1,
                //       child: ListView.builder(
                //         itemBuilder: (context, index) {
                //           return Container(
                //             child: Text('hello $index'),
                //           );
                //         },
                //         itemCount: 100,
                //       ),
                //     ),
                //     Expanded(
                //         flex: 3,
                //         child: ListView.builder(
                //           itemBuilder: (context, index) {
                //             return Container(
                //               child: Text('hello content $index'),
                //             );
                //           },
                //           itemCount: 100,
                //         ))
                //   ],
                // ),
              )
            ],
          ),
        ),
      ),
      // body: Expanded(
      //   child: Container(color: Colors.red,),
      // child: SingleChildScrollView(
      //   child:Container(
      //     child:
      //       Row(
      //         children: [
      //           Expanded(
      //             flex: 1,
      //             child: ListView.builder(
      //               itemBuilder: (context, index) {
      //                 return Container(
      //                   child: Text('hello $index'),
      //                 );
      //               },
      //               itemCount: 100,
      //             ),
      //           ),
      //           Expanded(
      //               flex: 3,
      //               child: ListView.builder(
      //                 itemBuilder: (context, index) {
      //                   return Container(
      //                     child: Text('hello content $index'),
      //                   );
      //                 },
      //                 itemCount: 100,
      //               ))
      //         ],
      //       )
      //   ) ,
      // ),
      // ),
    );
  }
}
