

import 'package:json_annotation/json_annotation.dart';
part 'login_data.g.dart';//子文件

@JsonSerializable()
class LoginData{
  String email;
  String icon;
  int id;
  String password;
  String token;
  int type;
  String username;
  String nickname;
  String publicName;
  List<int> collectIds;
  List<String> chapterTops;
  bool admin;
  LoginData(this.email, this.icon, this.id, this.password, this.token,
      this.type, this.username, this.nickname, this.publicName, this.collectIds,
      this.chapterTops, this.admin);

  factory LoginData.fromJson(Map<String,dynamic>json){
    return _$LoginDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$LoginDataToJson(this);

}