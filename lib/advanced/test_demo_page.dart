import 'package:flutter/material.dart';

class TableDemoPage extends StatefulWidget {
  @override
  _TableDemoPageState createState() => _TableDemoPageState();
}

class _TableDemoPageState extends State<TableDemoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> _tabTitles = [
    "Tab1",
    "Tab2",
    "Tab3",
  ];

  List<DataColumn> _dataColumns = [];
  List<DataRow> _dataRows = [];

  List<Widget> _rowTitles = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);

    for (int i = 0; i < 21; i++) {
      List<DataCell> fadeData = [];
      // 表格每行名称-地区或运营商名称
      _rowTitles.add(InkWell(
        onTap: () => onTitleTap(i),
        child: Container(
            height: 36.0,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "RowTitle${i + 1}",
              style: TextStyle(fontSize: 14.0, color: Color(0xff333333)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
      ));

      for (int j = 0; j < 11; j++) {
        if (i == 0) {
          // 表格每一列的名称
          _dataColumns.add(DataColumn(label: Text("ColumnTitle$j")));
        }
        fadeData.add(DataCell(Text(
          "$i$j",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, color: Color(0xff666666)),
        )));
      }
      _dataRows.add(DataRow(cells: fadeData));
    }

    _rowTitles.insert(
        0,
        Container(
          height: 31.0,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        //在标题前面显示的一个控件，在首页通常显示应用的 logo；在其他界面通常显示为返回按钮
        leading: IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => onBack()),
        //Toolbar 中主要内容，通常显示为当前界面的标题文字
        title: Column(
          children: [
            Text("title",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black38,
                )),
            Text("subtitle",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black38,
                ))
          ],
        ),
        //标题右侧显示的按钮组
        actions: [
          OutlinedButton(
            onPressed: () => doSearch(),
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(left: 22.0),
              child: Text(
                "Search",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: _tabTitles.length,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              automaticallyImplyLeading: false,
              floating: true,
              snap: true,
              toolbarHeight: 0.0,
              elevation: 0.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Container(
                    height: 200.0,
                    alignment: Alignment.center,
                    child: Text(
                      "TopContent",
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  )),
            ),
            SliverFillRemaining(
              child: Column(
                children: [
                  Container(
                    height: 44.0,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              style: BorderStyle.solid,
                              color: Color(0xfff7f7f7),
                              width: 2.0,
                            ))),
                    child: TabBar(
                      controller: _tabController,
                      tabs: _tabTitles
                          .map((e) => Tab(
                        child: Text(
                          e,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ))
                          .toList(),
                      isScrollable: false,
                      labelColor: Color(0xff1376ee),
                      indicatorColor: Color(0xff1376ee),
                      unselectedLabelColor: Color(0xff666666),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                        child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            ListView(
                              children: [
                                Row(
                                  children: [
                                    // 行名
                                    Expanded(
                                        child: ListView(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: _rowTitles,
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: DataTable(
                                              dividerThickness: 0.0,
                                              headingTextStyle: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Color(0xff333333),
                                                  fontWeight: FontWeight.w600),
                                              sortAscending: false,
                                              showBottomBorder: false,
                                              showCheckboxColumn: false,
                                              headingRowHeight: 32.0,
                                              dataRowHeight: 36.0,
                                              columns: _dataColumns,
                                              // 列名
                                              rows: _dataRows, // 数据
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(),
                            Container(),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 返回事件
  onBack() {}

  // Search
  doSearch() {}

  //每一行标题的点击事件
  onTitleTap(int i) {}
}