import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/advanced/custom_widget_page.dart';
import 'package:flutter_study_list/advanced/test_demo_page.dart';
import 'package:flutter_study_list/advanced/test_page.dart';
import 'package:flutter_study_list/basic/text_page.dart';
import 'package:flutter_study_list/main_page.dart';
var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return MainPage();
});
var textHandler= new Handler(handlerFunc:((context, parameters) => TextPage()));
var customWidgetHandler = new Handler(handlerFunc:((context, parameters) => CustomWidgetPage()));
var testPageHandler=Handler(handlerFunc:((context, parameters) => TestPage()));
var testDemoPageHandler=Handler(handlerFunc:((context, parameters) => TableDemoPage()));
// void defineRoutes(FluroRouter router) {
//   router.define("/text", handler: textHandler);

  // it is also possible to define the route transition to use
  // router.define("users/:id", handler: usersHandler, transitionType: TransitionType.inFromLeft);
// }