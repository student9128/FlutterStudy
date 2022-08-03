import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/advanced/custom_widget_page.dart';
import 'package:flutter_study_list/advanced/paf_viewer.dart';
import 'package:flutter_study_list/advanced/test_demo_page.dart';
import 'package:flutter_study_list/advanced/test_page.dart';
import 'package:flutter_study_list/advanced/vh_scrollable_table_page.dart';
import 'package:flutter_study_list/anim/basic_anim.dart';
import 'package:flutter_study_list/anim/hero_anim.dart';
import 'package:flutter_study_list/anim/hero_anim_second_page.dart';
import 'package:flutter_study_list/anim/list_anim.dart';
import 'package:flutter_study_list/anim/share_anim_first_page.dart';
import 'package:flutter_study_list/anim/tween_anim.dart';
import 'package:flutter_study_list/basic/basic_accessibility_page.dart';
import 'package:flutter_study_list/basic/basic_anim_and_motion_page.dart';
import 'package:flutter_study_list/basic/basic_asset_and_icon_page.dart';
import 'package:flutter_study_list/basic/basic_async_page.dart';
import 'package:flutter_study_list/basic/basic_common_page.dart';
import 'package:flutter_study_list/basic/basic_cupertino_page.dart';
import 'package:flutter_study_list/basic/basic_input_page.dart';
import 'package:flutter_study_list/basic/basic_interaction_model.dart';
import 'package:flutter_study_list/basic/basic_layout_page.dart';
import 'package:flutter_study_list/basic/basic_material_components_page.dart';
import 'package:flutter_study_list/basic/basic_paint_and_effect_page.dart';
import 'package:flutter_study_list/basic/basic_scroll_page.dart';
import 'package:flutter_study_list/basic/basic_style_page.dart';
import 'package:flutter_study_list/basic/basic_text_page.dart';
import 'package:flutter_study_list/basic/basic_widget_page.dart';
import 'package:flutter_study_list/basic/text_page.dart';
import 'package:flutter_study_list/main_page.dart';
var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return MainPage();
});
//Basic
var basicWidgetCommonPageHandler = Handler(handlerFunc:(context, parameters){
  debugPrint('传参=====${parameters.toString()}');
  return BasicWidgetCommonPage(pageListIndex: int.parse(parameters['pageListIndex']![0]),);
});
var basicWidgetPageHandler= Handler(handlerFunc:((context, parameters) => BasicWidgetPage()));
var basicMaterialComponentsPageHandler= Handler(handlerFunc:((context, parameters) => BasicMaterialComponentsPage()));
var basicCupertinoPagePageHandler= Handler(handlerFunc:((context, parameters) => BasicCupertinoPage()));
var basicLayoutPageHandler= Handler(handlerFunc:((context, parameters) => BasicLayoutPage()));
var basicTextPageHandler= Handler(handlerFunc:((context, parameters) => const BasicTextPage()));
var basicAssetsAndIconPageHandler= Handler(handlerFunc:((context, parameters) => BasicAssetsAndIconPage()));
var basicInputPageHandler= Handler(handlerFunc:((context, parameters) => BasicInputPage()));
var basicAnimMotionPageHandler= Handler(handlerFunc:((context, parameters) => BasicAnimMotionPage()));
var basicInteractionModelPageHandler= Handler(handlerFunc:((context, parameters) => BasicInteractionModelPage()));
var basicStylePageHandler= Handler(handlerFunc:((context, parameters) => BasicStylePage()));
var basicPaintAndEffectPageHandler= Handler(handlerFunc:((context, parameters) => BasicPaintAndEffectPage()));
var basicAsyncPageHandler= Handler(handlerFunc:((context, parameters) => BasicAsyncPage()));
var basicScrollPageHandler= Handler(handlerFunc:((context, parameters) => BasicScrollPage()));
var basicAccessibilityPageHandler= Handler(handlerFunc:((context, parameters) => BasicAccessibilityPage()));
//Advanced
var textHandler= Handler(handlerFunc:((context, parameters) => TextPage()));
var customWidgetHandler = Handler(handlerFunc:((context, parameters) => CustomWidgetPage()));
var testPageHandler=Handler(handlerFunc:((context, parameters) => TestPage()));
var testDemoPageHandler=Handler(handlerFunc:((context, parameters) => TableDemoPage()));
var vhScrollableTableHandler=Handler(handlerFunc:((context, parameters) => VHScrollableTablePage()));
var pdfViewerHandler=Handler(handlerFunc:((context, parameters) => PDFViewer(onDismissTapped:(){}, pdfText: "111111111111666666666666666666666661")));

//Anim
var basicAnimHandler=Handler(handlerFunc:((context, parameters) => BasicAnim()));
var animatedListHandler = Handler(handlerFunc: ((context, parameters) => ListAnim()));
var heroAnimHandler = Handler(handlerFunc: ((context, parameters) => HeroAnim()));
var heroAnimSecondPageHandler = Handler(handlerFunc: ((context, parameters) => HeroAnimSecondPage()));
var shareAnimPageHandler = Handler(handlerFunc: ((context, parameters) => ShareFirstPage()));
var tweenForTextAnimHandler = Handler(handlerFunc: ((context, parameters) => TweenForTextAnim()));
// void defineRoutes(FluroRouter router) {
//   router.define("/text", handler: textHandler);

  // it is also possible to define the route transition to use
  // router.define("users/:id", handler: usersHandler, transitionType: TransitionType.inFromLeft);
// }