
import 'package:fluro/fluro.dart';

///将button名称和路径名捆绑
List<Map<String, String>> combineList2Map(
    List<String> key, List<String> value) {
  List<Map<String,
   String>> list = [];
  if (key.length <= 0 || value.length <= 0) return [];
  if (key.length >= value.length) {
    for (int i = 0; i < value.length; i++) {
      Map<String, String> map = {};
      map['title'] = key[i];
      map['pageName'] = '/${value[i]}';
      list.add(map);
    }
  } else {
    for (int i = 0; i < key.length; i++) {
      Map<String, String> map = {};
      map['title'] = key[i];
      map['pageName'] = '/${value[i]}';
      list.add(map);
    }
  }
  return list;
}
List<Map<String, dynamic>> combineRouteList2Map(
    List<String> key, List<Handler> value) {
  List<Map<String,
   dynamic>> list = [];
  if (key.length <= 0 || value.length <= 0) return [];
  if (key.length >= value.length) {
    for (int i = 0; i < value.length; i++) {
      Map<String, dynamic> map = {};
      map['title'] = '/${key[i]}';
      map['handler'] = value[i];
      list.add(map);
    }
  } else {
    for (int i = 0; i < key.length; i++) {
      Map<String, dynamic> map = {};
      map['title'] = '/${key[i]}';
      map['handler'] = value[i];
      list.add(map);
    }
  }
  return list;
}
