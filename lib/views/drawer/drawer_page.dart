import 'package:flutter/material.dart';
import 'package:flutterwanandroids/common/MyIcons.dart';
import 'package:flutterwanandroids/common/application.dart';
import 'package:flutterwanandroids/common/event/login_event.dart';
import 'package:flutterwanandroids/data/data_utils.dart';
import 'package:flutterwanandroids/model/Login/login_data.dart';
import 'package:flutterwanandroids/res/colours.dart';
import 'package:flutterwanandroids/routers/routes.dart';
import 'package:flutterwanandroids/utils/tool_utils.dart';

const List<Map<String, dynamic>> defalutThemeColor = [
  {'cnName': '骚烈黄', 'value': 0xFFFFC800},
  {'cnName': 'Flutter蓝', 'value': 0xFF3391EA},
  {'cnName': '姨妈红', 'value': 0xFFC91B3A},
  {'cnName': '橘子橙', 'value': 0xFFF7852A},
  {'cnName': '早苗绿', 'value': 0xFF00C853},
  {'cnName': '基佬紫', 'value': 0xFFBF3EFF},
  {'cnName': '少女粉', 'value': 0xFFFF6EB4},
  {'cnName': '淡雅灰', 'value': 0xFF949494}
];

/**
 * 侧滑drawer
 */
class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() {
    // TODO: implement createState
    return _DrawerPageState();
  }
}

class _DrawerPageState extends State<DrawerPage> {
  final TextStyle textStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  bool isLogin = false; //是否登录
  LoginData loginData;
  @override
  void initState() {
    super.initState();
    isLogin = dataUtils.hasLogin() ;
    if (isLogin) {

    }
    //登录
    Application.eventBus.on<LoginEvent>().listen((event){
      if (this.mounted) {
        setState(() {
          isLogin = true;
          loginData = event.loginData;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            isLogin ? dataUtils.getUserName() : '点击头像登录',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          accountEmail: Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
                //显示积分等

                ),
          ),
          currentAccountPicture: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(isLogin
                  ? ToolUtils.getImage('ic_launcher_foreground')
                  : ToolUtils.getImage("ic_default_avatar", format: "webp")),
            ),
            onTap: (){
              //点击头像判断是否登录。如果登录跳转用户中心。否则跳转登录界面
              if (!isLogin) {
                Application.router.navigateTo(context, Routers.login);
              }
              else{

              }
            },

          ),
          decoration: BoxDecoration(
            color: dataUtils.getIsDarkMode() ? Colours.dark_unselected_item_color : ToolUtils.getPrimaryColor(context),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            size: 27.0,
          ),
          title: Text('首页',style:textStyle,),
          onTap: (){
            ///关闭侧边栏
            Navigator.pop(context);
          },
        ),
        Offstage(
          offstage: !isLogin,
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 27.0,
            ),
            title: Text(
              '个人中心',
              style: textStyle,
            ),
            onTap: (){

            },
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.surround_sound,
            size: 27.0,
          ),
          title: Text(
            '广场',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(false,Routers.shareArticlePage);
          },
        ),
        ListTile(
          leading: Icon(Icons.format_list_bulleted,size: 27.0,),
          title: Text('常用网站',
            style: textStyle,),
          onTap: (){
            checkLoginGoPage(false,Routers.commonWebPage);
          },
        ),
        ListTile(
          leading: Icon(
            MyIcons.collection,
            size: 27.0,
          ),
          title: Text(
            '我的收藏',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(true,Routers.collectItemPage);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.question_answer,
            size: 27.0,
          ),
          title: Text(
            '问答',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(false,Routers.questionAnswerPage);
          },
        ),
        ListTile(
          leading: Icon(
            MyIcons.todo,
            size: 27.0,
          ),
          title: Text(
            'TODO',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(true,Routers.todoPage);
          },
        ),
        new Divider(),
        ListTile(
          leading: Icon(
            MyIcons.rank,
            size: 27.0,
          ),
          title: Text(
            '积分排行榜',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(false,Routers.coinRankPage);
          },
        ),
        ListTile(
          leading: Icon(
            MyIcons.coin,
            size: 27.0,
          ),
          title: Text(
            '我的积分',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(true,Routers.userCoinPage);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            size: 27.0,
          ),
          title: Text(
            '主题',
            style: textStyle,
          ),
          onTap: () {
            //pushPage(context, SearchPage(), pageName: "SearchPage");
            ///显示主题 dialog
//            buildSimpleDialog(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            size: 27.0,
          ),
          title: Text(
            '设置',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(false,Routers.settingPage);
          },
        ),

      ],
    );
  }

  //检查是否登录
  void checkLoginGoPage(bool isNeedCheek,String pageType){
    if (isNeedCheek) {
      if (!isLogin) {
        //没有登录  跳转登录
        Application.router.navigateTo(context, Routers.login);
      }
      else {
        Navigator.pop(context);
        //登录则跳转用户中心
        Application.router.navigateTo(context,pageType);
      }
    }
    else{
      ///关闭侧边栏
      Navigator.pop(context);
      Application.router.navigateTo(context, pageType);
    }
  }
}
