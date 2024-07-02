import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_list/main_page.dart';
import 'package:flutter_study_list/routes/application.dart';
import 'package:flutter_study_list/routes/routes.dart';

void main() {
  // runApp(MaterialApp(onGenerateRoute: onGenerateRote, initialRoute: '/'));
  runApp(MyApp());
}

final routes = {
  '/': (context, {arguments}) => MainPage(),
  // ///需要传值路由
  // '/form': (context, {arguments}) => FormValuePage(
  //   arguments: arguments,
  // ),
};

// ignore: prefer_function_declarations_over_variables
var onGenerateRote = (RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  // ignore: unnecessary_null_comparison
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments),
      );
      return route;
    } else {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context),
      );
      return route;
    }
  }
  return null;
};



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(primarySwatch: Colors.green),
      onGenerateRoute: Application.router.generator,
    );
  }
}
