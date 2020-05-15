


import 'package:flutter/material.dart';
import 'package:flutterwanandroids/common/Page.dart';
import 'package:flutterwanandroids/common/constants.dart';
import 'package:flutterwanandroids/views/drawer/drawer_page.dart';

/**
 * 首页
 */
TabController _tabController ;
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{


  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: Constants.allPages.length,vsync: this);
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildTabScaffold();
  }

  Widget buildTabScaffold() {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: Icon(Icons.menu,color: Colors.white,size: 24.0,),
        ),
        actions: <Widget>[
          IconButton(
              icon:  Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
              })
        ],
        title: buildTabBar(),
      ),
      drawer: Drawer(
        child: DrawerPage(),
      ),
      body: HomePageTabBarViewLayout(),
    );
  }

  buildTabBar() {
    return TabBar(tabs: Constants.allPages.map((Page page){
      return Tab(text: page.labelId,);
    }).toList(),
      //超出屏幕宽度 可以滚动
      isScrollable: true,
      labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),

      indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
      unselectedLabelColor: Colors.white54,
      indicatorColor: Colors.white,
      controller: _tabController,
    );
  }

}
class HomePageTabBarViewLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TabBarView(
      controller: _tabController,
      children: Constants.allPages.map((Page page){
        return buildTabView(context,page);
      }).toList(),
    );
  }

  Widget buildTabView(BuildContext context, Page page) {
    int laberIndex = page.labelIndex;
    switch(laberIndex){
      case 1:
        //最新博文
        return Container(
          child: Center(
            child: Text('暂未实现 Pag'),
          ),
        );
        break;
      case 2:
      //最新项目
        return Container(
          child: Center(
            child: Text('暂未实现 Pag'),
          ),
        );
        break;
      default:
        return Container(
          child: Center(
            child: Text('暂未实现 Pag'),
          ),
        );
        break;
    }
  }
}
