import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/constant/constants.dart';
import 'package:flutter_study_list/constant/route_names.dart';
import 'package:flutter_study_list/not_found_page.dart';
import 'package:flutter_study_list/routes/route_handlers.dart';
import 'package:flutter_study_list/routes/route_handler_list.dart';
import 'package:flutter_study_list/util/list_to_map_utils.dart';

class Routes{
  static String root = "/";
  static String demoSimple = "/demo";
  static String demoSimpleFixedTrans = "/demo/fixedtrans";
  static String demoFunc = "/demo/func";
  static String deepLink = "/message";
  static String customWidget='/customWidget';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          debugPrint('params=$params');
      print("ROUTE WAS NOT FOUND !!!");
      return const NotFoundPage();
    });
     router.define(root, handler: rootHandler);
     List<Map<String, dynamic>> basicList=combineRouteList2Map(basicPageName, basicHandler);
    for (var item in basicList) {
      router.define(item['title'], handler: item['handler']! as Handler,transitionType: TransitionType.inFromRight);
    } 
    List<Map<String, dynamic>> advancedList=combineRouteList2Map(advancedPageName, advancedHandler);
    for (var item in advancedList) {
      router.define(item['title'], handler: item['handler']! as Handler,transitionType: TransitionType.inFromRight);
    }
    List<Map<String, dynamic>> animList=combineRouteList2Map(animPageName, animHandler);
    for (var item in animList) {
      router.define(item['title'], handler: item['handler']! as Handler,transitionType: TransitionType.inFromRight);
    }
    List<Map<String, dynamic>> baiduMapList=combineRouteList2Map(baiduMapPageName, baiduMapHandlerList);
    for (var item in baiduMapList) {
      router.define(item['title'], handler: item['handler']! as Handler,transitionType: TransitionType.inFromRight);
    }
    router.define('heroAnimSecondPage', handler: heroAnimSecondPageHandler);
    router.define("basicWidgetCommonPage", handler: basicWidgetCommonPageHandler,transitionType: TransitionType.inFromRight);
    router.define("tabBarPage", handler: tabBarPageHandler,transitionType: TransitionType.inFromRight);
    // for (var item in routeHandlerList) {
    //   if(item['title']!.toString()!='/'){
    //   router.define(item['title']!.toString(), handler: item['handler']! as Handler,transitionType: TransitionType.inFromRight);
    //   }else{
    //   router.define(item['title']!.toString(), handler: item['handler']! as Handler);
    //   }
    // }
    // router.define(root, handler: rootHandler);
    // router.define(customWidget, handler: customWidgetHandler,transitionType: TransitionType.inFromRight);
    ///可以定义路径名称和页面到集合，进行for循环添加
    // router.define(demoSimple, handler: demoRouteHandler);
    // router.define(demoSimpleFixedTrans,
    //     handler: demoRouteHandler, transitionType: TransitionType.inFromLeft);
    // router.define(demoFunc, handler: demoFunctionHandler);
    // router.define(deepLink, handler: deepLinkHandler);
  }
}