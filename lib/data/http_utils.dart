import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutterwanandroids/data/api/Api.dart';
import 'package:flutterwanandroids/utils/tool_utils.dart';
import 'package:flutterwanandroids/widget/loading_widget.dart';
import 'package:path_provider/path_provider.dart';

/**
 * 网络请求接口
 */
Map<String, dynamic> optHeader = {
  'accept-language': 'zh-cn',
  'content-type': 'application/json'
};
HttpUtils httpUtils = HttpUtils();
class HttpUtils {
  static HttpUtils _singleton = HttpUtils._internal();

  factory HttpUtils() => _singleton;
  Dio _dio;

  HttpUtils._internal() {
    if (_dio == null) {
      _dio = Dio();
      _dio.options.baseUrl = Api.BASE_URL;
      _dio.options.connectTimeout = 30 * 1000;
      _dio.options.sendTimeout = 30 * 1000;
      _dio.options.receiveTimeout = 30 * 1000;
    }
  }

  /**
   * 网络请求地址
   * get 请求
   */
  Future get(String url,
      {Map<String, dynamic> parms,
      bool isAddLoading = false,
      BuildContext context,
      String loadingText}) async {
    Response response;
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = documentsDir.path;
    var dir = Directory('$path/cookies');
    await dir.create();
    _dio.interceptors.add(
        CookieManager(PersistCookieJar(dir: dir.path, ignoreExpires: true)));
    //是否显示加载中的loading
    if (isAddLoading) {
      showLoading(context, loadingText);
    }

    try {
      if (parms != null) {
        response = await _dio.get(url, queryParameters: parms);
      } else {
        response = await _dio.get(url);
      }
      disMissLoadingDialog(isAddLoading, context);
      if (response.data['errorCode'] == 0) {
        return response;
      } else {
        String dataErroMsg = response.data['errorMsg'];
        ToolUtils.showToast(msg: dataErroMsg);
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
      }
      ToolUtils.showToast(msg: handleError(e));
      disMissLoadingDialog(isAddLoading, context);
      return null;
    }
  }

  /**
   * 网络请求
   * post请求
   */
  Future post(String url, {FormData formData,Map<String, dynamic> queryParameters, bool isAddLoading = false ,BuildContext context,String loadingText}) async{
    Response response;
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = Directory('$documentsPath/cookies');
    await dir.create();
    _dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));

    //显示 加载中的 loading
    if(isAddLoading){
      showLoading(context,loadingText);
    }

    try {
      if(formData!=null){
        response = await _dio.post(url, data: formData);
      }else if(queryParameters != null){
        response = await _dio.post(url, queryParameters: queryParameters);
      }else{
        response = await _dio.post(url);
      }
      disMissLoadingDialog(isAddLoading, context);
      if(response.data["errorCode"] == 0 ){
        return response;
      }else{
        String data = response.data["errorMsg"];
        ToolUtils.showToast(msg: data);
        return response;
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
      }
      ToolUtils.showToast(msg: handleError(e));
      disMissLoadingDialog(isAddLoading, context);
      return null;
    }
  }

  /**
   * 判断错误
   */
  static String handleError(error, {String defaultErrorString = '未知错误!!!'}) {
    String errStr;
    if (error is DioError) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errStr = '连接超时!!!';
      } else if (error.type == DioErrorType.SEND_TIMEOUT) {
        errStr = '请求超时!!!';
      } else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errStr = '响应超时!!!';
      } else if (error.type == DioErrorType.CANCEL) {
        errStr = '请求取消!!!';
      } else if (error.type == DioErrorType.RESPONSE) {
        int statusCode = error.response.statusCode;
        String msg = error.response.statusMessage;

        /// 异常状态码的处理
        switch (statusCode) {
          case 500:
            errStr = '服务器异常!!!';
            break;
          case 404:
            errStr = '未找到资源!!!';
            break;
          default:
            errStr = '$msg[$statusCode]';
            break;
        }
      }
      else if (error.type ==DioErrorType.DEFAULT) {
        errStr = '${error.message}';
        if (error.error is SocketException) {
          errStr = '网络连接超时!!!';
        }

      }
      else {
        errStr = '未知错误!!!';
      }

    }

    return errStr ?? defaultErrorString;

  }

  //显示loading
  void showLoading(BuildContext context, String loadText) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return new LoadingWidget(
            outsideDismiss: false,
            loadingText: loadText,
          );
        });
  }

  //关闭loading
  void disMissLoadingDialog(bool isAddLoading, BuildContext context) {
    if (isAddLoading) {
      Navigator.of(context).pop();
    }
  }
}
