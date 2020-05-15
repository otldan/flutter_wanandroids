



import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterwanandroids/views/app_page.dart';
import 'package:flutterwanandroids/views/login/login_page.dart';
import 'package:flutterwanandroids/views/login/register_page.dart';

//app首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return AppPage();
  }
);

//登录页
var loginHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return  LoginPage();
  },
);
//登录页
var registerHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return  RegisterPage();
  },
);