



import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterwanandroids/routers/router_handler.dart';

class Routers{
  static String root = "/";
  static String home = "/home_page";
  static String knowledgedetail = "/knowledge_detail_page";
  static String login = "/login_page";
  static String register = "/register_page";
  static String webViewPage = '/web_view_page';
  static String userCenterPage = '/user_center_page';
  static String collectItemPage = '/collect_page';
  static String commonWebPage = '/common_web_page';
  static String shareArticlePage = '/share_article_page';
  static String coinRankPage = '/coin_rank_page';
  static String userCoinPage = '/user_coin_page';
  static String settingPage = '/setting_page';
  static String aboutPage = '/about_page';
  static String searchPage = '/search_page';
  static String questionAnswerPage = '/question_answer_page';
  static String todoPage = '/todo_page';

  static void configureRouters(Router routers){
    routers.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print("router not found");
      }
    );

    routers.define(root, handler: homeHandler);
    routers.define(login, handler: loginHandler);
  }



}