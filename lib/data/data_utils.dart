import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterwanandroids/common/application.dart';
import 'package:flutterwanandroids/common/constants.dart';
import 'package:flutterwanandroids/data/api/Api.dart';
import 'package:flutterwanandroids/data/http_utils.dart';
import 'package:flutterwanandroids/model/Login/base_login_data.dart';
import 'package:flutterwanandroids/model/Login/login_data.dart';
import 'package:flutterwanandroids/model/base_response.dart';

DataUtils dataUtils = new DataUtils();

class DataUtils {
  //是否为夜间模式
  int getPrimaryColor() {
    return Application.sp.getInt(SharedPreferencesKeys.THEME_COLOR_KEY);
  }

  //是否为夜间模式
  bool getIsDarkMode() {
    return Application.sp.getBool(SharedPreferencesKeys.THEME_DARK_MODE_KEY);
  }

  //是否为夜间模式
  void setIsDarkMode(bool isDark) {
    Application.sp.putBool(SharedPreferencesKeys.THEME_DARK_MODE_KEY, isDark);
  }

  //存储主题颜色
  void setPrimaryColor(int color) {
    Application.sp.putInt(SharedPreferencesKeys.THEME_COLOR_KEY, color);
  }

  /// SharedPreferences 存储 用户名 是否登录等状态
  void setUserName(String username) {
    Application.sp.putString(SharedPreferencesKeys.USER_NAME_KEY, username);
  }

  String getUserName() {
    return Application.sp.getString(SharedPreferencesKeys.USER_NAME_KEY);
  }

  void setPassWord(String password) {
    Application.sp.putString(SharedPreferencesKeys.PASSWORD_KEY, password);
  }

  String getPassword() {
    return Application.sp.getString(SharedPreferencesKeys.PASSWORD_KEY);
  }

  bool hasLogin() {
    if (Application.sp.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY) == null) {
      return false;
    }
    if (!Application.sp.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY)) {
      return false;
    }
    return getLoginState();
  }

  void setLoginState(bool loginState) {
    Application.sp.putBool(SharedPreferencesKeys.LOGIN_STATE_KEY, loginState);
  }

  bool getLoginState() {
    return Application.sp.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY);
  }

//登录
  Future<BaseResponseBody<LoginData>> getLoginData(
      String userName, String password, BuildContext context) async {
    FormData formData =
        FormData.fromMap({"username": userName, "password": password});
    Response response = await httpUtils.post(Api.LOGIN_JSON,
        formData: formData,
        isAddLoading: true,
        context: context,
        loadingText: '正在登陆...');
    return BaseLoginData.fromJson(response.data);
  }
  //注册
//注册
  Future<BaseResponseBody<LoginData>> getRegisterData(String username,String password,String repassword,BuildContext context) async{
    FormData formData =FormData.fromMap({"username": username, "password": password,"repassword": repassword});
    Response response = await httpUtils.post(Api.REGISTER_JSON,formData: formData,isAddLoading:true,context: context,loadingText: "正在登陆...");
    return BaseLoginData.fromJson(response.data);
  }
}
