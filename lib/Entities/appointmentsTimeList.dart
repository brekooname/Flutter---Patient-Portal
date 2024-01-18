import 'package:flutter/cupertino.dart';

class AppointmentsTimeList {
  String? quotaType;
  // String dayName;
  // additional or notadditional or booked
  // additional with status true
  // not additional with status false
  List<dynamic>? appointmentTimeSlots;
  // [8:00 - 8:20 -----]

  AppointmentsTimeList({
    @required this.quotaType,
    this.appointmentTimeSlots,
    // this.dayName
  });
  factory AppointmentsTimeList.fromJson(Map<String, dynamic> json) {
    return AppointmentsTimeList(
        quotaType: json['quotaType'] as String,
        //dayName: json['dayName'] as String,
        appointmentTimeSlots: json['appointmentTimeSlots'] as List);
  }
}
