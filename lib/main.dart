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
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   title: Text('Sliver App Bar'),
          //   /// 1. floating向上滚动消息，向下滚动出现
          //   // floating: true,
          //   /// 2. 固定
          //   // pinned: true,
          //   /// 3. floating与snap结合，向上滚动消息，向下滚动立即出现全部，有一个动画效果
          //   // floating: true,
          //   // snap: true,
          // ),
          /// 4. expandedHeight与flexibleSpace扩展appBar内容
          /// 向上拉固定住title
          SliverAppBar(
            title: Text('FlexibleSpaceBar Title'),
            pinned: true,
            expandedHeight: 300,
            /// 5. 向下拉伸的弹力效果设置
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: FlutterLogo(),
              title: Text('FlexibleSpaceBar Title'),
              stretchModes: [
                StretchMode.blurBackground, // 1. 背景模糊
                StretchMode.zoomBackground, // 2. 背景放大
                StretchMode.fadeTitle, // 3. title渐变
              ],
              /// 6. 向上缩回去的效果
              collapseMode: CollapseMode.parallax,
              // collapseMode: CollapseMode.pin,
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                Placeholder(),
                FlutterLogo(size: 200),
                FlutterLogo(size: 200),
                FlutterLogo(size: 200),
              ]))
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
