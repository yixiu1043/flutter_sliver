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

      /// 创建一个视窗
      body: CustomScrollView(
        slivers: [
          /// 1. SliverToBoxAdapter 将普通renderBOx组件转为sliver组件
          SliverToBoxAdapter(
            child: FlutterLogo(size: 100),
          ),
          SliverToBoxAdapter(
            child: FlutterLogo(size: 100),
          ),

          /// 2. SliverGrid，GridView就是SliverGrid构建的
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                height: 200,
                color: Colors.primaries[index % 18],
              );
            }, childCount: 20),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          ),
          /// 3. SliverList，ListView就是SliverList构建的
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                height: 200,
                color: Colors.primaries[index % 18],
              );
            }, childCount: 20),
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
