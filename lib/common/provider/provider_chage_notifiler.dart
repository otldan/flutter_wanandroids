

import 'package:flutter/material.dart';

/**
 * 主题model
 */
class ThemeModel extends ChangeNotifier{

  int settingThemeColor;
  bool isDarkMode;
  ThemeModel(this.settingThemeColor,this.isDarkMode);

  void chageTheme(int themeColor,bool isDark){
    this.isDarkMode = isDark;
    this.settingThemeColor = themeColor;
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}