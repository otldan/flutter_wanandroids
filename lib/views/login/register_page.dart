


import 'package:flutter/material.dart';
import 'package:flutterwanandroids/common/application.dart';
import 'package:flutterwanandroids/common/event/login_event.dart';
import 'package:flutterwanandroids/data/data_utils.dart';
import 'package:flutterwanandroids/model/Login/login_data.dart';
import 'package:flutterwanandroids/model/base_response.dart';
import 'package:flutterwanandroids/res/colours.dart';
import 'package:flutterwanandroids/routers/routes.dart';
import 'package:flutterwanandroids/utils/tool_utils.dart';

/**
 * 注册
 */
class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 利用FocusNode和_focusScopeNode来控制焦点 可以通过FocusNode.of(context)来获取widget树中默认的_focusScopeNode
  FocusNode _userNameFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();
  FocusNode _rePasswordFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode = new FocusScopeNode();
  GlobalKey<FormState> _registerFormKey = GlobalKey();
  //获取用户输入的 Controller
  TextEditingController _userNameEditingController =
  new TextEditingController();
  TextEditingController _passwordEditingController =
  new TextEditingController();
  TextEditingController _rePasswordEditingController =
  new TextEditingController();
  //是否显示输入的密码
  bool isShowPassWord = false;
  bool isShowRePassWord = false;
  //输入的用户名 密码
  String userName = '';
  String passWord = '';
  String rePassWord = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: Text('注册',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: dataUtils.getIsDarkMode() ? Colours.dark_unselected_item_color :Theme.of(context).primaryColor,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(ToolUtils.getImage("ic_launcher"),
                            fit: BoxFit.contain,
                            width: 60.0,
                            height: 60.0
                        )
                      ],),
                      buildSignInTextForm(),
                      SizedBox(height: 15.0),
                      buildSignInButton(),
                      SizedBox(height: 15.0),

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignInTextForm(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      child: Form(
        key: _registerFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Padding(padding: EdgeInsets.only(left: 25,right: 25,top: 20,bottom: 20),
                child: TextFormField(
                  controller: _userNameEditingController,
                  focusNode: _userNameFocusNode,
                  autofocus: true,
                  onEditingComplete: (){
                    if (_focusScopeNode == null) {
                      _focusScopeNode = FocusScope.of(context);
                    }
                    _focusScopeNode.requestFocus(_focusScopeNode);
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.person,color: Colors.black,),
                    hintText: "WanAndroid 用户名",
                    border: InputBorder.none
                  ),
                  style: TextStyle(fontSize: 16,color: Colors.black),
                  validator: (username){
                    if (username == null || username.isEmpty) {
                      return "用户名不能为空!";
                    }
                    return null;
                  },

                  onSaved: (username){
                    setState(() {
                      userName = username;
                    });
                  },
                ),),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.75,
                color: Colors.grey[400],
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
                  child: TextFormField(
                    controller: _passwordEditingController,
                    focusNode: _passwordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    autofocus: true, //自动获取焦点 打开键盘
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock,color: Colors.black),
                        hintText: "WanAndroid 登录密码",
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          color: Colors.black,
                          onPressed: showPassWord,
                        )
                    ),
                    obscureText: !isShowPassWord,
                    style: TextStyle(fontSize: 16,color: Colors.black),
                    //输入验证
                    validator: (password){
                      if(password ==null || password.isEmpty){
                        return "密码不能为空!";
                      }
                      return null;
                    },
                    onSaved: (password){
                      setState(() {
                        passWord = password;
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.75,
                color: Colors.grey[400],
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
                  child: TextFormField(
                    controller: _rePasswordEditingController,
                    focusNode: _rePasswordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock,color: Colors.black),
                        hintText: "确认登录密码",
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          color: Colors.black,
                          onPressed: showRePassWord,
                        )
                    ),
                    obscureText: !isShowRePassWord,
                    style: TextStyle(fontSize: 16,color: Colors.black),
                    //输入验证
                    validator: (repassword){
                      if(repassword ==null || repassword.isEmpty){
                        return "确认密码不能为空!";
                      }
                      return null;
                    },
                    onSaved: (repassword){
                      setState(() {
                        rePassWord = repassword;
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.75,
                color: Colors.grey[400],
              ),
            ],
          )),
    );
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  void showRePassWord() {
    setState(() {
      isShowRePassWord = !isShowRePassWord;
    });
  }

  Widget buildSignInButton() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildSingButton("完成注册并登录")
        ],
      ),
    );
  }
  Widget buildSingButton(String text) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 42, right: 42, top: 8, bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Theme.of(context).primaryColor,boxShadow: [ //阴影
          BoxShadow( //阴影
              color:Colors.black12,
              offset: Offset(2.0,2.0),
              blurRadius: 4.0
          )
        ]
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
        // 利用key来获取widget的状态FormState,可以用过FormState对Form的子孙FromField进行统一的操作
        if (_registerFormKey.currentState.validate() ) {
          // 如果输入都检验通过，则进行注册操作
          // 注册
          doRegister();
        }
      },
    );
  }

  void doRegister()async{
    _registerFormKey.currentState.save();
    if (passWord != rePassWord) {
      ToolUtils.showToast(msg: "两次输入的密码不一致！！");
      return;
    }
    BaseResponseBody<LoginData> baseResponseBody = await dataUtils.getRegisterData(userName, passWord, rePassWord,context);
    if (baseResponseBody.errorCode == 0) {
     LoginData loginData =  baseResponseBody.data;
      // events_bus
      dataUtils.setUserName(loginData.username);
      dataUtils.setLoginState(true);
      //发出 登录成功事件
      Application.eventBus.fire(new LoginEvent(loginData));
      ToolUtils.showToast(msg: "注册成功");
      //退出当前页面 //清除栈中其他Page
      Application.router.navigateTo(context,Routers.root,clearStack: true);
    }

  }
}