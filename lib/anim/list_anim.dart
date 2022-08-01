import 'package:flutter/material.dart';

class ListAnim extends StatefulWidget {
  const ListAnim({ Key? key }) : super(key: key);

  @override
  State<ListAnim> createState() => _ListAnimState();
}

class _ListAnimState extends State<ListAnim> {
  GlobalKey<AnimatedListState>  _listKey = GlobalKey();
  List<String> _data = ["test 0","test 1"];
  _buildFadeWidget(Widget child,Animation<double> anim){
    return FadeTransition(opacity: Tween<double>(begin: 0,end: 1).animate(anim),child: child,);
  }
  _addItem() {
    var nextIndex = _data.length;
    _data.add("add $nextIndex");
    _listKey.currentState?.insertItem(nextIndex,duration: Duration(seconds: 2));
  }
  _removeItem(){
    if(_data.isNotEmpty){
String item = _data.removeAt(0);
_listKey.currentState?.removeItem(0, (context, animation) => _buildFadeWidget(_buildItem(data: item), animation));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:const Text('AnimatedList') ,),
    body: Container(
      child: Column(
        children: [
          ElevatedButton(onPressed:(){_addItem();}, child: Text('添加')),
          ElevatedButton(onPressed:(){_removeItem();}, child: Text('删除')),
          Expanded(child: AnimatedList(
            key: _listKey,
            initialItemCount: _data.length,
            itemBuilder:(context, index, animation) {
            return _buildFadeWidget(_buildItem(data: _data[index]), animation);
          }))
        ],
      ),
    ),);
  }
}

class _buildItem extends StatelessWidget {
  const _buildItem({
    Key? key,
    required String data,
  }) : _data = data, super(key: key);

  final String _data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300))
      ),
      child: Text("${_data}"),);
  }
}