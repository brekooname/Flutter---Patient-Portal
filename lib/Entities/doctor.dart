import 'package:soul/Entities/appointmentSetting.dart';
import 'package:soul/Entities/previousAppointment.dart';

class Doctor {
  String? userName;
  String? fullName;
  String? city;
  String? country;
  String? mobilephone;
  String? specialty;
  List<AppointmentSetting>? appointmentSetting;
  List<previousAppointment>? previousapp;
  Doctor(
      {this.city,
      this.country,
      this.fullName,
      this.mobilephone,
      this.specialty,
      this.userName,
      this.appointmentSetting,
      this.previousapp});
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
        userName: json['userName'] as String,
        fullName: json['fullName'] as String,
        city: json['city'] as String,
        country: json['country'] as String,
        mobilephone: json['mobilephone'] as String,
        specialty: json['specialty'] as String,
        appointmentSetting: List<dynamic>.from(json['listOfAppointemntSetup'])
            .map((i) => AppointmentSetting.fromJson(i))
            .toList(),
        previousapp:
            List<dynamic>.from(json['listOfAppointemntDetailsForApatient'])
                .map((i) => previousAppointment.fromJson(i))
                .toList());
  }
}
