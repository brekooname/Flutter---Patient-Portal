import 'package:flutter/cupertino.dart';

class Insurance {
  //public  string insurancE_PLAN{get;set;}
  // public  string memebR_ID{get;set;}
  bool? is_Acive;
  String? insurancE_NAME;
  String? insurancE_PLANName;
  String? expireDate;
  int? deductibleAmount;
  String? deductType;

  Insurance(
      {@required this.deductType,
      @required this.deductibleAmount,
      @required this.expireDate,
      @required this.insurancE_NAME,
      @required this.insurancE_PLANName,
      this.is_Acive});
  factory Insurance.fromJson(Map<String, dynamic> json) {
    return Insurance(
      is_Acive: json['is_Acive'] == null ? null : json['is_Acive'] as bool,
      insurancE_NAME: json['insurancE_NAME'] as String,
      insurancE_PLANName: json['insurancE_PLANName'] as String,
      expireDate: json['expireDate'] as String,
      deductibleAmount: json['deductibleAmount'] as int,
      deductType: json['deductType'] as String,
    );
  }
}
