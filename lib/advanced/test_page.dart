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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TestPage')),
      body: Container(
        child:
            Column(
              children: [
                Row(children: [
                  Container(
                    width: 100,
                    child: Text('hello头布局'),
                  ),
                  Expanded(child: Container(
                    width: 600,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 50,
                            color: Colors.primaries[0],
                            child: Text('flutter 头布局',),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            color: Colors.primaries[1],
                            child: Text('kotlin 头布局',),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            color: Colors.primaries[2],
                            child: Text('hello 头布局',),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            color: Colors.primaries[3],
                            child: Text('hello 头布局',),
                          ),  Container(
                            width: 100,
                            height: 50,
                            color: Colors.primaries[3],
                            child: Text('java 头布局',),
                          ),  Container(
                            width: 100,
                            height: 50,
                            color: Colors.primaries[4],
                            child: Text('vue 头布局',),
                          ),
                        ],
                      ),
                    ),
                  ))

                ],),
                Expanded(child:    SingleChildScrollView(
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
                ))

              ],
            )
        ,
      ),
    );
  }
}
