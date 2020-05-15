

import 'package:flutterwanandroids/model/Login/login_data.dart';
import 'package:flutterwanandroids/model/base_response.dart';
part 'base_login_data.g.dart';

class BaseLoginData extends BaseResponseBody<LoginData>{
  BaseLoginData(LoginData data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);

  factory BaseLoginData.fromJson(Map<String, dynamic> json){
    return _$BaseLoginDataFromJson(json);
  }
}