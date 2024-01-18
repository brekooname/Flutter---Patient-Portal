import 'package:soul/Entities/appointmentSetting.dart';
import 'package:soul/Entities/doctor.dart';

class Clinic {
  String? id;
  String? name;
  String? departmentTypeId;
  String? departmentTypeCode;
  List<Doctor>? doctor;
  List<AppointmentSetting>? appList;
  // List<Doctor> doctors;

  Clinic(
      {this.id,
      this.name,
      this.departmentTypeCode,
      this.departmentTypeId,
      this.doctor,
      this.appList});
  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
        id: json['id'] as String,
        name: json['name'] as String,
        departmentTypeCode: json['departmentTypeCode'] as String,
        departmentTypeId: json['departmentTypeId'] as String,
        // doctor: json['listOfPhysicians']as List,
        appList: List<dynamic>.from(json['listOfClinicAppointments'])
            .map((i) => AppointmentSetting.fromJson(i))
            .toList());
  }
  Map toJson() => {
        'clinicID': id,
        'clinicName': name,
        'departmentTypeCode': departmentTypeCode,
        'departmentTypeId': departmentTypeId,
      };
}
