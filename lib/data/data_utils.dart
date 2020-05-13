

import 'package:flutterwanandroids/common/application.dart';
import 'package:flutterwanandroids/common/constants.dart';

DataUtils dataUtils = new DataUtils();
class DataUtils{



  //是否为夜间模式
  int getPrimaryColor(){
    return Application.sp.getInt(SharedPreferencesKeys.THEME_COLOR_KEY);
  }
  //是否为夜间模式
  bool getIsDarkMode(){
    return Application.sp.getBool(SharedPreferencesKeys.THEME_DARK_MODE_KEY);
  }
  //是否为夜间模式
  void setIsDarkMode(bool isDark){
    Application.sp.putBool(SharedPreferencesKeys.THEME_DARK_MODE_KEY, isDark);
  }
  //存储主题颜色
  void setPrimaryColor(int color){
    Application.sp.putInt(SharedPreferencesKeys.THEME_COLOR_KEY, color);
  }

  bool hasLogin(){
    if (Application.sp.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY) == null) {

      return false;
    }
    if(!Application.sp.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY))
      {
        return false;
      }
    return getLoginState();
  }

  bool getLoginState() {
    return Application.sp.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY);
  }

  String getUserName(){
    return Application.sp.getString(SharedPreferencesKeys.USER_NAME_KEY);
  }
}

