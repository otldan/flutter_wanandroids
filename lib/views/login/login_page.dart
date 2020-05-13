import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwanandroids/data/data_utils.dart';
import 'package:flutterwanandroids/res/colours.dart';
import 'package:flutterwanandroids/utils/tool_utils.dart';

/**
 * 登录页
 */
class LoginPage extends StatefulWidget {
  @override
  _loginPageState createState() {
    // TODO: implement createState
    return _loginPageState();
  }
}

class _loginPageState extends State<LoginPage> {
  //获取用户输入的 Controller
  TextEditingController _userNameEditingController =
      new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();
  GlobalKey<FormState> _signInFormKey = GlobalKey();

  FocusNode _userNameFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode = new FocusScopeNode();
  String userName = '';
  String passWord = '';

  //是否显示输入的密码
  bool isShowPassWord = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop(this);
          },
        ),
        title: Text("登录", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: dataUtils.getIsDarkMode()
              ? Colours.dark_unselected_item_color
              : Theme.of(context).primaryColor,
          child: Center(
            child: Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow( //阴影
                      color:Colors.black12,
                      offset: Offset(2.0,2.0),
                      blurRadius: 4.0
                  )
                ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(ToolUtils.getImage("ic_launcher"),
                      fit: BoxFit.contain, width: 60.0, height: 60.0),
                  buildSignInTextForm(),
                  buildSignBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /**
   * 创建登录界面的TextForm
   */
  Widget buildSignInTextForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              child: TextFormField(
                controller: _userNameEditingController,
                focusNode: _userNameFocusNode,
                autofocus: true,
                onEditingComplete: () {
                  if (_focusScopeNode == null) {
                    _focusScopeNode = FocusScope.of(context);
                  }
                  _focusScopeNode.requestFocus(_passwordFocusNode);
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                    BorderSide(color:Theme.of(context).primaryColor, width: 0.5),
                  ),
                  contentPadding:
                      EdgeInsets.only(top: 1, bottom: 1, left: 5, right: 5),
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: "WanAndroid 用户名",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.5),
                  ),
                  labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                ),
                validator: (username) {
                  if (username == null || username.isEmpty) {
                    ToolUtils.showToast(msg: '用户名不能为空');
                    return '用户名不能为空';
                  }
                  return null;
                },
                onSaved: (username) {
                  setState(() {
                    userName = username;
                  });
                },
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10),
              child: TextFormField(
                controller: _passwordEditingController,
                focusNode: _passwordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                     BorderSide(color:Theme.of(context).primaryColor, width: 0.5),
                  ),
                  contentPadding:
                  EdgeInsets.only(top: 1, bottom: 1, left: 5, right: 5),
                  icon: Icon(Icons.lock, color: Colors.black),
                  hintText: "WanAndroid 登录密码",
                  suffixIcon: IconButton(
                    icon: Icon(isShowPassWord
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye),
                    color: Colors.black,
                    onPressed: showPassWord,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.5),
                  ),
                ),
                obscureText: !isShowPassWord,
                style: TextStyle(fontSize: 16, color: Colors.black),
                validator: (passworod) {
                  if (passworod == null || passworod.isEmpty) {
                    ToolUtils.showToast(msg: '密码不能为空');
                    return '密码不能为空';
                  }
                  return null;
                },
                onSaved: (password) {
                  setState(() {
                    passWord = password;
                  });
                },
              ),
            )
          ],
        ),
        key: _signInFormKey,
      ),
    );
  }

  //登录按钮
  Widget buildSignBtn(){
    return Padding(padding: EdgeInsets.only(left: 30,right: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          child: Text('注册',style: TextStyle(fontSize: 16),),
          onPressed: (){

          },
        ),
        SizedBox(
          width: 30,
        ),
        RaisedButton(
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          child: Text('登录',style: TextStyle(fontSize: 16),),
          onPressed: (){
            if (_signInFormKey.currentState.validate()) {
              ToolUtils.showToast(msg:'登录');
            }
          },
        ),
      ],
    ));
  }


  showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }


  void doLogin() async{
    _signInFormKey.currentState.save();

}
}
