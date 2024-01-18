import 'package:flutter/cupertino.dart';

class Auth {
  String? transactionId;
  String? loginUserName;
  String? token;
  String? userID;
  String? tokenExpiration;

  Auth(
      {@required this.loginUserName,
      this.token,
      this.tokenExpiration,
      this.transactionId,
      this.userID});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      transactionId: json['transactionId'] as String?,
      loginUserName: json['loginUserName'] as String?,
      token: json['token'] as String?,
      userID: json['userID'] as String?,
      tokenExpiration: json['tokenExpiration'] as String?,
    );
  }

}
