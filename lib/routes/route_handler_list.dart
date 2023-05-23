import 'package:fluro/fluro.dart';
import 'package:flutter_study_list/routes/route_handlers.dart';

var title = 'title';
var handler = 'handler';
var routeHandlerList = [
  {title: '/', handler: rootHandler},
  {title: '/customWidget', handler: customWidgetHandler},
];
List<Handler> basicHandler = [
  basicWidgetPageHandler,
  basicMaterialComponentsPageHandler,
  basicCupertinoPagePageHandler,
  basicLayoutPageHandler,
  basicTextPageHandler,
  basicAssetsAndIconPageHandler,
  basicInputPageHandler,
  basicAnimMotionPageHandler,
  basicInteractionModelPageHandler,
  basicStylePageHandler,
  basicPaintAndEffectPageHandler,
  basicAsyncPageHandler,
  basicScrollPageHandler,
  basicAccessibilityPageHandler
];
List<Handler> advancedHandler = [
  customWidgetHandler,
  testPageHandler,
  testDemoPageHandler,
  vhScrollableTableHandler,
  pdfViewerHandler,
  listviewAutoLoadMoreHandler
];
List<Handler> animHandler = [
  basicAnimHandler,
  animatedListHandler,
  heroAnimHandler,
  shareAnimPageHandler,
  tweenForTextAnimHandler
];

List<Handler> basicMaterialComponentsPageHandlerList=[
  tabBarPageHandler
];