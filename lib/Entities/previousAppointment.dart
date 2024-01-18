import 'package:flutter/cupertino.dart';

class previousAppointment {
  String? date;
  String? appointmenT_STATUS;
  String? appointmenT_SOURCE;
  String? appointmenT_DEPARTMENT_ID;
  String? depDescription;
  previousAppointment(
      {@required this.appointmenT_STATUS,
      this.date,
      this.appointmenT_SOURCE,
      this.appointmenT_DEPARTMENT_ID,
      this.depDescription});
  factory previousAppointment.fromJson(Map<String, dynamic> json) {
    return previousAppointment(
      date: (json['creatioN_DATETIME'] as String?) ?? '',
      appointmenT_STATUS: (json['appointmenT_STATUS'] as String?) ?? '',
      appointmenT_SOURCE: (json['appointmenT_SOURCE'] as String?) ?? '',
      appointmenT_DEPARTMENT_ID: (json['appointmenT_DEPARTMENT_ID'] as String?) ?? '',
      depDescription: (json['depDescription'] as String?) ?? '',
    );
  }

}
