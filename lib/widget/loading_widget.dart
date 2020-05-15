

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterwanandroids/data/data_utils.dart';
import 'package:flutterwanandroids/res/colours.dart';

/**
 * 加载loading
 */
class LoadingWidget extends StatefulWidget{
  String loadingText;
  bool outsideDismiss;
  Function dismissDialog;
  LoadingWidget({Key key,this.loadingText = 'loading...',
  this.outsideDismiss = true,
  this.dismissDialog}):super(key:key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {

  @override
  void initState(){
    super.initState();
    if (widget.dismissDialog != null) {
      widget.dismissDialog(
          (){
            Navigator.of(context).pop(
            );
          }
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: widget.outsideDismiss ? _dismissLoading() : null,
      child: Material(
        type: MaterialType.transparency,
        child: Center(
            child: new SizedBox(
                width: 120.0,
                height: 120.0,
                child: new Container(
                  decoration: ShapeDecoration(
                    color: dataUtils.getIsDarkMode() ? Colours.dark_unselected_item_color : Colors.white ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SpinKitWave(color: Theme.of(context).primaryColor, type: SpinKitWaveType.start),
                        ],
                      ),
                      Padding(
                        child: Text(widget.loadingText,
                            style: TextStyle(color: Colors.black54, fontSize: 10.0)),
                        padding: EdgeInsets.all(15.0),
                      )
                    ],
                  ),
                )
            )
        ),

      ),
    );
  }
  //关闭 loading
  _dismissLoading() {
    Navigator.of(context).pop();
  }
}
