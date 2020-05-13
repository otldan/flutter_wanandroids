import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwanandroids/common/application.dart';
import 'package:flutterwanandroids/common/constants.dart';
import 'package:flutterwanandroids/common/shared_preferences.dart';
import 'package:flutterwanandroids/data/data_utils.dart';
import 'package:flutterwanandroids/res/colours.dart';
import 'package:flutterwanandroids/res/styles.dart';
import 'package:flutterwanandroids/routers/routes.dart';
import 'package:flutterwanandroids/views/app_page.dart';
import 'package:provider/provider.dart';

import 'common/provider/provider_chage_notifiler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Application.sp = await SpUtil.getIntance() ;
  //沉浸式 限android
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp(){
    final Router router = Router();
    Routers.configureRouters(router);
    //设置全局变量
    Application.router = router;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyApp> {
  int themeColor;
  bool isDarkMode;

  @override
  void initState(){
    super.initState();
    Application.eventBus =EventBus();
    themeColor = Application.sp.getInt(SharedPreferencesKeys.THEME_COLOR_KEY);
    isDarkMode = Application.sp.getBool(SharedPreferencesKeys.THEME_DARK_MODE_KEY);
    if (themeColor == null) {
      themeColor = 0xFFFFC800;
      dataUtils.setPrimaryColor(themeColor);
    }

    if (isDarkMode == null) {
      isDarkMode = false;
      dataUtils.setIsDarkMode(isDarkMode);
    }

  }

  @override
  void dispose(){
    super.dispose();
    Application.eventBus.destroy();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context){
            return ThemeModel(themeColor,isDarkMode);
          },
        ),
      ],
      child: Consumer<ThemeModel>(builder: (context,thememode,_){
        return MaterialApp(

          title: 'titles',
          theme: getThemeData(thememode),
          home: new Scaffold(
            body:AppPage() ,

          ),
          onGenerateRoute: Application.router.generator,
        );
      }),
    );
  }


  ThemeData getThemeData(ThemeModel themeModel) {
    return ThemeData(
        iconTheme: themeModel.isDarkMode ? null : IconThemeData(
          color: Color(themeModel.settingThemeColor),
          size: 35.0,
        ),
        platform: TargetPlatform.iOS,
        backgroundColor: themeModel.isDarkMode ? null : Colours.bg_color,
        errorColor: themeModel.isDarkMode ? Colours.dark_red : Colours.red,
        brightness: themeModel.isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: themeModel.isDarkMode ? Colours.dark_app_main : Color(
            themeModel.settingThemeColor),
        accentColor: themeModel.isDarkMode ? Colours.dark_app_main : Colours
            .accentColor_color,
        // Tab指示器颜色
        indicatorColor: themeModel.isDarkMode ? Colours.dark_app_main : Colours
            .app_main,
        // 页面背景色
        scaffoldBackgroundColor: themeModel.isDarkMode
            ? Colours.dark_bg_color
            : Colors.white,
        // 主要用于Material背景色
        canvasColor: themeModel.isDarkMode ? Colours.dark_material_bg : null,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: Colours.app_main.withAlpha(70),
        textSelectionHandleColor: Colours.app_main,
        textTheme: TextTheme(
          // TextField输入文字颜色
          subhead: themeModel.isDarkMode ? TextStyles.textDark : TextStyles
              .text,
          // Text默认文字样式
          body1: themeModel.isDarkMode ? TextStyles.textDark : TextStyles.text,
          // 这里用于小文字样式
          subtitle: themeModel.isDarkMode
              ? TextStyles.textDarkGray12
              : TextStyles.textGray12,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: themeModel.isDarkMode ? TextStyles.textHint14 : TextStyles
              .textDarkGray14,
        ),
        appBarTheme: AppBarTheme(
          elevation: 2.0,
          color: themeModel.isDarkMode ? Colours.dark_bg_color : Color(
              themeModel.settingThemeColor),
          brightness: themeModel.isDarkMode ? Brightness.dark : Brightness
              .light,
        ),
        dividerTheme: DividerThemeData(
            color: themeModel.isDarkMode ? Colours.dark_line : Colours.line,
            space: 0.6,
            thickness: 0.6
        ),

    );
  }
}
