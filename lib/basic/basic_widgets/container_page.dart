import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_list/util/asset_utils.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Wrap(
          children: [
            const CustomContainer(
              margin: EdgeInsets.only(left: 10, top: 10),
              width: 100,
              height: 100,
            ),
            const CustomContainer(
              margin: EdgeInsets.only(left: 10, top: 10),
              width: 100,
              height: 100,
              color: Colors.amberAccent,
            ),
            const CustomContainer(
              margin: EdgeInsets.only(left: 10, top: 10),
              width: 100,
              height: 100,
              color: Colors.purpleAccent,
            ),
            const CustomContainer(
              margin: EdgeInsets.only(left: 10, top: 10),
              width: 100,
              height: 100,
              color: Colors.cyan,
            ),
            CustomContainer(
              borderRadius: BorderRadius.circular(50),
              margin: const EdgeInsets.only(left: 10, top: 10),
              width: 100,
              height: 100,
              color: Colors.green,
            ),
            CustomContainer(
              borderRadius: BorderRadius.circular(30),
              margin: const EdgeInsets.only(left: 10, top: 10),
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
            CustomContainer(
              borderRadius: BorderRadius.circular(50),
              margin: const EdgeInsets.only(left: 10, top: 10),
              width: 40,
              height: 40,
              outerBorderWidth: 2,
              innerBorderWidth: 1,
              color: Colors.green,
              child: const Icon(Icons.arrow_back),
            ),
            CustomContainer(
              borderRadius: BorderRadius.circular(10),
              margin: const EdgeInsets.only(left: 10, top: 10),
              width: 40,
              height: 40,
              outerBorderWidth: 2,
              innerBorderWidth: 1,
              color: Colors.red,
              child: const Icon(Icons.account_circle_rounded),
            ),
            CustomContainer(
              borderRadius: BorderRadius.circular(3),
              margin: const EdgeInsets.only(left: 10, top: 10),
              width: 40,
              height: 40,
              outerBorderWidth: 2,
              innerBorderWidth: 1,
              color: Colors.cyan,
              child: const Icon(Icons.add),
            ),
            CustomContainer(
              borderRadius: BorderRadius.circular(3),
              margin: const EdgeInsets.only(left: 10, top: 10),
              // width: 40,
              // height: 40,
              outerBorderWidth: 2,
              innerBorderWidth: 1,
              color: Colors.cyan,
              child: const Column(
                children: [
                  Icon(
                    Icons.add,
                    size: 30,
                  ),
                  Icon(Icons.add),
                  Icon(Icons.add),
                  Icon(Icons.add),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 3),
                color: Colors.lightGreen,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    // blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.add,
                    size: 30,
                  ),
                  Icon(Icons.add),
                  Icon(Icons.add),
                  Icon(Icons.add),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      // height: 100,
                      margin: EdgeInsets.only(
                          bottom: 10, left: index != 0 ? 30 : 0),
                      child: Column(
                        children: [
                          CustomContainer(
                              margin: EdgeInsets.only(bottom: 10),
                              borderRadius: BorderRadius.circular(65.0),
                              outerBorderWidth: 2,
                              innerBorderWidth: 1.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(65.0),
                                child: Image.asset(
                                  AssetUtils.getAssetImage('avatar_test.jpeg',
                                      isPNG: false),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Text("Helen Choi")
                        ],
                      ),
                    );
                  }),
            ),
            CustomContainer(
              padding: EdgeInsets.all(10),
              width: 150,
              margin: const EdgeInsets.only(left: 10, top: 10),
              innerBorderWidth: 2,
              // innerBorderColor: const Color(0xffAFC8AD),
              outerBorderWidth: 2,
              color: const Color(0xff7071E8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomContainer(
                      margin: EdgeInsets.only(bottom: 10),
                      borderRadius: BorderRadius.circular(65.0),
                      outerBorderWidth: 2,
                      innerBorderWidth: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(65.0),
                        child: Image.asset(
                          AssetUtils.getAssetImage('avatar_test.jpeg',
                              isPNG: false),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Carolin, 29",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                          ),
                          Text('Shanghai', style: TextStyle(fontSize: 12))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            CustomContainer(
              padding: EdgeInsets.all(10),
              width: 150,
              margin: const EdgeInsets.only(left: 10, top: 10),
              innerBorderWidth: 2,
              // innerBorderColor: const Color(0xffAFC8AD),
              outerBorderWidth: 2,
              color: const Color(0xffF4DFC8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomContainer(
                      margin: EdgeInsets.only(bottom: 10),
                      borderRadius: BorderRadius.circular(65.0),
                      outerBorderWidth: 2,
                      innerBorderWidth: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(65.0),
                        child: Image.asset(
                          AssetUtils.getAssetImage('avatar_test.jpeg',
                              isPNG: false),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Carolin, 29",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                          ),
                          Text('Shanghai', style: TextStyle(fontSize: 12))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            CustomContainer(
              padding: EdgeInsets.all(10),
              width: 170,
              margin: const EdgeInsets.only(left: 10, top: 10),
              innerBorderWidth: 0,
              innerBorderColor: const Color(0xffAFC8AD),
              outerBorderWidth: 3,
              color: const Color(0xffAFC8AD),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1.5)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          AssetUtils.getAssetImage('avatar_test.jpeg',
                              isPNG: false),
                          width: 150,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Carolin, 29",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 12,
                                  ),
                                  Text('Shanghai,China',
                                      style: TextStyle(fontSize: 12))
                                ],
                              )
                            ],
                          )),
                      CustomContainer(
                        color: const Color(0xffAFC8AD),
                        borderRadius: BorderRadius.circular(30),
                        innerBorderWidth: 1,
                        child: Transform.rotate(
                          angle: -pi / 2.0,
                          child: Icon(
                            Icons.arrow_back_rounded,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Stack(
              children: [
                CustomContainer(
                  height: 100,
                  width: MediaQuery.of(context).size.width - 20,
                  margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Send exactly',style: TextStyle(color: Color(0xffCCCCCC),fontSize: 16),),
                          Text('1,000',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ],
                      )),
                      Container(
                        width: 100,
                        height: 100,
                      )
                    ],
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 10,
                    child: CustomContainer(
                      innerBorderColor: Colors.white,
                      width: 100,
                      height: 100,
                      color: Colors.cyan,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'USD',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          CustomContainer(
                            width: 25,
                            height: 25,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            borderRadius: BorderRadius.circular(30),
                            outerBorderWidth: 2,
                            innerBorderWidth: 2,
                            alignment: Alignment(-1, -1),
                            child: Transform.rotate(
                              angle: -pi / 2,
                              child: Icon(Icons.arrow_back_ios_rounded,size: 15,),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            CustomContainer(
              width: (MediaQuery.of(context).size.width-40)/3,
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Colors.yellowAccent,
              innerBorderColor: Colors.white,
              child: Column(
                children: [
                  CustomContainer(
                    borderRadius: BorderRadius.circular(25),
                    width: 45,
                    height: 45,
                    color: Colors.white,
                    innerBorderWidth: 2,
                    outerBorderWidth: 2,
                    child: Icon(
                      Icons.euro,
                      size: 20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      '655.00',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: Text('EUR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey)),
                  ),
                ],
              ),
            ),
            CustomContainer(
              width: (MediaQuery.of(context).size.width-40)/3,
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Colors.cyan,
              innerBorderColor: Colors.white,
              child: Column(
                children: [
                  CustomContainer(
                    borderRadius: BorderRadius.circular(25),
                    width: 45,
                    height: 45,
                    color: Colors.white,
                    innerBorderWidth: 2,
                    outerBorderWidth: 2,
                    child: Icon(
                      Icons.euro,
                      size: 20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      '655.00',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: Text('EUR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey)),
                  ),
                ],
              ),
            ),
            CustomContainer(
              width: (MediaQuery.of(context).size.width-40)/3,
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Colors.purple,
              innerBorderColor: Colors.white,
              child: Column(
                children: [
                  CustomContainer(
                    borderRadius: BorderRadius.circular(25),
                    width: 45,
                    height: 45,
                    color: Colors.white,
                    innerBorderWidth: 2,
                    outerBorderWidth: 2,
                    child: Icon(
                      Icons.euro,
                      size: 20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      '655.00',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: Text('EUR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey)),
                  ),
                ],
              ),
            ),
            CustomContainer(
              width: MediaQuery.of(context).size.width - 20,
              margin: EdgeInsets.only(left: 10, top: 20),
              alignment: Alignment.center,
              color: Colors.cyan,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              innerBorderColor: Colors.white,
              outerBorderWidth: 3,
              child: Text(
                'Sign up with email',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      this.width,
      this.height,
      this.child,
      this.borderRadius,
      this.border,
      this.outerBorderColor,
      this.margin,
      this.alignment,
      this.padding,
      this.outerBorderWidth,
      this.color,
      this.innerBorderColor,
      this.innerBorderWidth});

  final double? width;
  final double? height;
  final Widget? child;
  final BoxBorder? border;
  final Color? color;
  final Color? innerBorderColor;
  final double? innerBorderWidth;
  final Color? outerBorderColor;
  final double? outerBorderWidth;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        border: Border.all(
            color: innerBorderColor ?? Colors.black,
            width: innerBorderWidth ?? 3),
        color: color ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: outerBorderColor ?? Colors.black,
            offset: Offset(outerBorderWidth ?? 2, outerBorderWidth ?? 2),
            // blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
