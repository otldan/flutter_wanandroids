
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterwanandroids/common/MyIcons.dart';
import 'package:flutterwanandroids/common/provider/provider_chage_notifiler.dart';
import 'package:flutterwanandroids/data/data_utils.dart';
import 'package:flutterwanandroids/utils/tool_utils.dart';
import 'package:flutterwanandroids/views/drawer/drawer_page.dart';
import 'package:flutterwanandroids/views/home/home_page.dart';
import 'package:provider/provider.dart';

class AppPage extends StatefulWidget{
  @override
  _AppPageState createState() {
    // TODO: implement createState
    return _AppPageState();
  }

}

class _AppPageState extends State<AppPage> {
  //存放底部导航栏对应的widget
  List<Widget> _list = [];
  //当前tab
  int _currentIndex = 0;

  List tabData = [
    {'text':'首页','icon':Icon(Icons.home)},
    {'text': '知识体系', 'icon': Icon(MyIcons.knowledge)},
    {'text': '公众号', 'icon': Icon(MyIcons.wechat)},
    {'text': '导航', 'icon': Icon(Icons.navigation)},
    {'text': '项目', 'icon': Icon(Icons.android)},
  ];
  List<BottomNavigationBarItem> _myTabs =[];
  String appBarTitle;
  DateTime _lastPressedAt;//上次点击时间
  final pageController = PageController();

  @override
  void initState(){
    super.initState();
    appBarTitle = tabData[0]['text'];

    for (int i = 0;i<tabData.length;i++) {
      _myTabs.add(BottomNavigationBarItem(
        icon: tabData[i]['icon'],
        title: Text(tabData[i]['text']),
      ));
    }

    _list
      ..add(HomePage())
      ..add(HomePage())
      ..add(HomePage())
      ..add(HomePage());
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //通过willpopscope嵌套 可以用于监听处理android 返回键的逻辑
      child: buildAppPage(),
      onWillPop: () async{
        return _doubleExitApp();
      },
    );
  }
  //创建 APP page 页面
Widget buildAppPage(){
    return Scaffold(
      appBar: renderAppBar(context, widget, _currentIndex),
      body: PageView(
        controller: pageController,
        children: _list,
        onPageChanged: _itemTapped,
        physics: NeverScrollableScrollPhysics(),
      ),
      drawer: Drawer(
        child: DrawerPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _myTabs,
        currentIndex: _currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColor,
      ),
    );
}
void _onTap(int inex){
    pageController.jumpToPage(inex);
}

void _itemTapped(int index){
    if (mounted) {
      setState(() {
        _currentIndex = index;
        appBarTitle = tabData[index]['text'];
      });
    }
}
renderAppBar(BuildContext context,Widget widget,int index){
    if (index != 0 || index != 4) {
      return AppBar(
        leading: Builder(
          builder: (context){
            return IconButton(
              icon: Icon(Icons.menu,color: Colors.white),
              onPressed: () {
                /// 打开侧边栏 使用 Builder( builder: (context) 保证获取到 Scaffold  context 可以正常打开侧边栏
                print("点击打开侧边栏");
                Scaffold.of(context).openDrawer();
              });
          },
        ),
        title: Text(appBarTitle,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon:  Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
              })
        ],
      );

    }
}
  //双击返回 退出应用
bool _doubleExitApp(){
    if (_lastPressedAt == null
    || DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
      ToolUtils.showToast(msg: '再点一次退出应用');
      _lastPressedAt =DateTime.now();
      return false;
    }
    Fluttertoast.cancel();
    return true;
}
}