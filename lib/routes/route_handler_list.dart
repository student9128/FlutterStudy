import 'package:fluro/fluro.dart';
import 'package:flutter_study_list/routes/route_handlers.dart';

var title = 'title';
var handler = 'handler';
var routeHandlerList = [
  {title: '/', handler: rootHandler},
  {title: '/customWidget', handler: customWidgetHandler},
];
List<Handler> advancedHandler=[customWidgetHandler,testPageHandler];
