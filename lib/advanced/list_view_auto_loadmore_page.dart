import 'package:flutter/material.dart';

class ListViewAutoLoadMorePage extends StatefulWidget {
  const ListViewAutoLoadMorePage({Key? key}) : super(key: key);

  @override
  State<ListViewAutoLoadMorePage> createState() =>
      _ListViewAutoLoadMorePageState();
}

class _ListViewAutoLoadMorePageState extends State<ListViewAutoLoadMorePage> {
  var items = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= 15; i++) {
      items.add('Item $i');
    }
    setState(() {});
  }

  void loadMore() {
    debugPrint('loadMore==================');
    var currentLength = items.length;
    for (int i = currentLength + 1; i <= currentLength + 15; i++) {
      items.add('Item $i');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListViewAutoLoadMorePage'),
      ),
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              debugPrint(
                  '${scrollInfo.metrics.pixels},${scrollInfo.metrics.maxScrollExtent},${scrollInfo.metrics.minScrollExtent}');
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 30) {
                loadMore();
              }
              return true;
            },
            child: ListView.builder(
                controller: _scrollController,
                itemCount: items.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text('${items[index]}',style: TextStyle(color: index%2==0?Colors.red:Colors.blue),),
                  );
                })),
          ),
          Positioned(
              bottom: 100,
              right: 30,
              child: ElevatedButton(
                onPressed: () {
                  _scrollController.jumpTo(0);
                },
                child: const Text('Top'),
              ))
        ],
      ),
    );
  }
}
