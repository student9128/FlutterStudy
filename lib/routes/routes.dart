import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/routes/route_handlers.dart';

class Routes{
  static String root = "/";
  static String demoSimple = "/demo";
  static String demoSimpleFixedTrans = "/demo/fixedtrans";
  static String demoFunc = "/demo/func";
  static String deepLink = "/message";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });
    router.define(root, handler: rootHandler);
    ///可以定义路径名称和页面到集合，进行for循环添加
    // router.define(demoSimple, handler: demoRouteHandler);
    // router.define(demoSimpleFixedTrans,
    //     handler: demoRouteHandler, transitionType: TransitionType.inFromLeft);
    // router.define(demoFunc, handler: demoFunctionHandler);
    // router.define(deepLink, handler: deepLinkHandler);
  }
}