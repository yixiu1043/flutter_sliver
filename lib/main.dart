import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  List<Member> _members = [];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.pink),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() => _members.clear());
            final res = await http.get(Uri.parse(
                'https://h5.48.cn/resource/jsonp/allmembers.php?gid=10'));
            if (res.statusCode == 200) {
              final json = jsonDecode(res.body);
              final members = json['rows'].map<Member>(
                (row) => Member(
                  sid: row['sid'],
                  sname: row['sname'],
                  tid: row['tid'],
                  tname: row['tname'],
                  pid: row['pid'],
                  pname: row['pname'],
                  nickname: row['nickname'],
                  company: row['company'],
                  join_day: row['join_day'],
                  height: row['height'],
                  birth_day: row['birth_day'],
                  star_sign_12: row['star_sign_12'],
                  star_sign_48: row['star_sign_48'],
                  birth_place: row['birth_place'],
                  speciality: row['speciality'],
                  hobby: row['hobby'],
                  experience: row['experience'],
                  tcolor: row['tcolor'],
                ),
              );
              setState(() => _members = members.toList());
              _members.forEach((element) {
                print('${element.tid}:${element.tname}:${element.tcolor}');
              });
            }
          },
          child: Scrollbar(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverPersistentHeaderDelegate(
                      'SII', Color(0xff91cdeb)),
                ),
                _buildSliverGrid('101'),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverPersistentHeaderDelegate(
                      'NII', Color(0xffae86bb)),
                ),
                _buildSliverGrid('102'),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverPersistentHeaderDelegate(
                      'HII', Color(0xfff39800)),
                ),
                _buildSliverGrid('103'),
                SliverPersistentHeader(
                  pinned: true,
                  delegate:
                      MySliverPersistentHeaderDelegate('X', Color(0xffa9cc29)),
                ),
                _buildSliverGrid('104'),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverPersistentHeaderDelegate(
                      '未入列', Color(0xff91cdeb)),
                ),
                _buildSliverGrid('149'),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverPersistentHeaderDelegate(
                      '预备生', Color(0xffa7b0ba)),
                ),
                _buildSliverGrid('150'),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverPersistentHeaderDelegate(
                      'SNH48', Color(0xff91cdeb)),
                ),
                _buildSliverGrid('151'),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverPersistentHeaderDelegate(
                      '荣誉毕业生', Color(0xff91cdeb)),
                ),
                _buildSliverGrid('199'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverGrid _buildSliverGrid(String tid) {
    List<Member> member =
        _members.where((element) => element.tid == tid).toList();
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final Member m = member[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: CircleAvatar(
                  child: Image.network(m.avatar),
                  backgroundColor: Colors.white,
                ),
              ),
              Text('${m.sname}'),
            ],
          );
        },
        childCount: member.length,
      ),
    );
  }
}

class Member {
  final String sid;
  final String sname;
  final String tid; // "SII",
  final String tname; // "SII",
  final String pid; // "1014",
  final String pname; // "SNH48 十四期生",
  final String nickname; // "圈圈",
  final String company; // "上海丝芭文化传媒集团有限公司",
  final String join_day; // "2020-10-03",
  final String height; // "162",
  final String birth_day; // "03.23",
  final String star_sign_12; // "白羊座",
  final String star_sign_48; // "双鱼白羊座，新生的交界，3.19-3.24",
  final String birth_place; // "中国 江苏 ",
  final String speciality; // "吉他",
  final String hobby; // "唱歌",
  final String experience;
  final String tcolor;

  get avatar => 'https://www.snh48.com/images/member/zp_$sid.jpg';

  Member({
    this.sid,
    this.sname,
    this.tid,
    this.tname,
    this.pid,
    this.pname,
    this.nickname,
    this.company,
    this.join_day,
    this.height,
    this.birth_day,
    this.star_sign_12,
    this.star_sign_48,
    this.birth_place,
    this.speciality,
    this.hobby,
    this.experience,
    this.tcolor,
  });

  @override
  String toString() {
    return 'Member{sid: $sid, sname: $sname, tname: $tname, pid: $pid, pname: $pname, nickname: $nickname, company: $company, join_day: $join_day, height: $height, birth_day: $birth_day, star_sign_12: $star_sign_12, star_sign_48: $star_sign_48, birth_place: $birth_place, speciality: $speciality, hobby: $hobby, experience: $experience}';
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String tname;
  final Color tcolor;

  MySliverPersistentHeaderDelegate(this.tname, this.tcolor);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 32,
      color: tcolor,
      child: FittedBox(child: Text('$tname')),
    );
  }

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(covariant MySliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.tname != tname;
  }
}
