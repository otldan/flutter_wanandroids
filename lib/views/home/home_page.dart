


import 'package:flutter/material.dart';

/**
 * 首页
 */
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("首页"),
    );
  }
}
