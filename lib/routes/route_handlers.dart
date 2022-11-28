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
import 'package:flutter_study_list/basic/material_components/tab_bar_page.dart';
import 'package:flutter_study_list/basic/text_page.dart';
import 'package:flutter_study_list/main_page.dart';
var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const MainPage();
});
//Basic
var basicWidgetCommonPageHandler = Handler(handlerFunc:(context, parameters){
  debugPrint('传参=====${parameters.toString()}');
  return BasicWidgetCommonPage(pageListIndex: int.parse(parameters['pageListIndex']![0]),pageName:parameters['pageName']==null?'':parameters['pageName']!.first,);
});
var basicWidgetPageHandler= Handler(handlerFunc:((context, parameters) => const BasicWidgetPage()));
var basicMaterialComponentsPageHandler= Handler(handlerFunc:((context, parameters) => const BasicMaterialComponentsPage()));
var basicCupertinoPagePageHandler= Handler(handlerFunc:((context, parameters) => const BasicCupertinoPage()));
var basicLayoutPageHandler= Handler(handlerFunc:((context, parameters) => const BasicLayoutPage()));
var basicTextPageHandler= Handler(handlerFunc:((context, parameters) => const BasicTextPage()));
var basicAssetsAndIconPageHandler= Handler(handlerFunc:((context, parameters) => const BasicAssetsAndIconPage()));
var basicInputPageHandler= Handler(handlerFunc:((context, parameters) => const BasicInputPage()));
var basicAnimMotionPageHandler= Handler(handlerFunc:((context, parameters) => const BasicAnimMotionPage()));
var basicInteractionModelPageHandler= Handler(handlerFunc:((context, parameters) => const BasicInteractionModelPage()));
var basicStylePageHandler= Handler(handlerFunc:((context, parameters) => const BasicStylePage()));
var basicPaintAndEffectPageHandler= Handler(handlerFunc:((context, parameters) => const BasicPaintAndEffectPage()));
var basicAsyncPageHandler= Handler(handlerFunc:((context, parameters) => const BasicAsyncPage()));
var basicScrollPageHandler= Handler(handlerFunc:((context, parameters) => const BasicScrollPage()));
var basicAccessibilityPageHandler= Handler(handlerFunc:((context, parameters) => const BasicAccessibilityPage()));
//Advanced
var textHandler= Handler(handlerFunc:((context, parameters) => const TextPage()));
var customWidgetHandler = Handler(handlerFunc:((context, parameters) => const CustomWidgetPage()));
var testPageHandler=Handler(handlerFunc:((context, parameters) => const TestPage()));
var testDemoPageHandler=Handler(handlerFunc:((context, parameters) => TableDemoPage()));
var vhScrollableTableHandler=Handler(handlerFunc:((context, parameters) => const VHScrollableTablePage()));
var pdfViewerHandler=Handler(handlerFunc:((context, parameters) => PDFViewer(onDismissTapped:(){}, pdfText: "111111111111666666666666666666666661")));

//Anim
var basicAnimHandler=Handler(handlerFunc:((context, parameters) => const BasicAnim()));
var animatedListHandler = Handler(handlerFunc: ((context, parameters) => const ListAnim()));
var heroAnimHandler = Handler(handlerFunc: ((context, parameters) => const HeroAnim()));
var heroAnimSecondPageHandler = Handler(handlerFunc: ((context, parameters) => const HeroAnimSecondPage()));
var shareAnimPageHandler = Handler(handlerFunc: ((context, parameters) => const ShareFirstPage()));
var tweenForTextAnimHandler = Handler(handlerFunc: ((context, parameters) => const TweenForTextAnim()));

//basicMaterialComponentsPageHandler 子页面
var tabBarPageHandler = Handler(handlerFunc: (((context, parameters) => const TabBarPage())));

// void defineRoutes(FluroRouter router) {
//   router.define("/text", handler: textHandler);

  // it is also possible to define the route transition to use
  // router.define("users/:id", handler: usersHandler, transitionType: TransitionType.inFromLeft);
// }