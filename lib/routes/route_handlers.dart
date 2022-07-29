import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/advanced/custom_widget_page.dart';
import 'package:flutter_study_list/advanced/paf_viewer.dart';
import 'package:flutter_study_list/advanced/test_demo_page.dart';
import 'package:flutter_study_list/advanced/test_page.dart';
import 'package:flutter_study_list/advanced/vh_scrollable_table_page.dart';
import 'package:flutter_study_list/anim/basic_anim.dart';
import 'package:flutter_study_list/basic/text_page.dart';
import 'package:flutter_study_list/main_page.dart';
var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return MainPage();
});
//Advanced
var textHandler= new Handler(handlerFunc:((context, parameters) => TextPage()));
var customWidgetHandler = new Handler(handlerFunc:((context, parameters) => CustomWidgetPage()));
var testPageHandler=Handler(handlerFunc:((context, parameters) => TestPage()));
var testDemoPageHandler=Handler(handlerFunc:((context, parameters) => TableDemoPage()));
var vhScrollableTableHandler=Handler(handlerFunc:((context, parameters) => VHScrollableTablePage()));
var pdfViewerHandler=Handler(handlerFunc:((context, parameters) => PDFViewer(onDismissTapped:(){}, pdfText: "111111111111666666666666666666666661")));

//Anim
var basicAnimHandler=Handler(handlerFunc:((context, parameters) => BasicAnim()));
// void defineRoutes(FluroRouter router) {
//   router.define("/text", handler: textHandler);

  // it is also possible to define the route transition to use
  // router.define("users/:id", handler: usersHandler, transitionType: TransitionType.inFromLeft);
// }