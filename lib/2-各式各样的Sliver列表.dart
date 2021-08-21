import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CustomScrollView(
        slivers: [
          /// 1. SliverList类似于ListView
          // SliverList(delegate: SliverChildListDelegate([
          //   FlutterLogo(),
          //   FlutterLogo(),
          //   FlutterLogo(),
          // ])),
          /// 2. SliverFixedExtentList类似ListView的itemExtend属性固定大小的实现
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //     FlutterLogo(),
          //     FlutterLogo(),
          //     FlutterLogo(),
          //   ]),
          // ),
          // SliverFixedExtentList(
          //   itemExtent: 50,
          //   delegate: SliverChildBuilderDelegate((context, index) {
          //     return Container(
          //       height: 200,
          //       color: Colors.primaries[index % 18],
          //     );
          //   }, childCount: 20),
          // )
          /// 3. SliverPrototypeExtentList设置统一的高度
          // DefaultTextStyle(
          //   style: TextStyle(color: Colors.red, fontSize: 40),
          //   child: SliverPrototypeExtentList(
          //     delegate: SliverChildListDelegate([
          //       Text('hello'),
          //       Text('hello'),
          //       Text('hello'),
          //     ]),
          //     prototypeItem: Text('Hello', style: TextStyle(fontSize: 100)),
          //   ),
          // )
          /// 4. SliverFillViewport每一项都占满视窗，类似PageView组件
          SliverFillViewport(
            delegate: SliverChildListDelegate([
              Container(color: Colors.red, height: 400),
              Container(color: Colors.green),
              Container(color: Colors.yellow),
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
