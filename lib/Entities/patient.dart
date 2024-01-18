import 'package:flutter/cupertino.dart';

class Patient {
  String? patientID;
  String? firstName;
  String? secoundName;
  String? thirdName;
  String? lastName;

  String? fullName;

  DateTime? dateOfBirth;

  String? dateOfBirthString;
  String? pictureName;
  String? primaryInsuranceID;
  String? gender;
  String? nationalID;

  String? placeOfBirth;

  String? cellularPhone1;
  String? cellularPhone2;
  String? contactPhone;

  String? insurancePlan;
  String? insurancePlanName;
  String? insuranceName;
  String? insuranceMemberID;
  String? country;
  String? city;

  String? insurnacePayer;

  Patient(
      {@required this.cellularPhone1,
      this.patientID,
      this.city,
      this.cellularPhone2,
      this.contactPhone,
      this.country,
      this.dateOfBirth,
      this.dateOfBirthString,
      this.firstName,
      this.fullName,
      this.gender,
      this.insuranceMemberID,
      this.insuranceName,
      this.insurancePlan,
      this.insurancePlanName,
      this.insurnacePayer,
      this.lastName,
      this.nationalID,
      this.pictureName,
      this.placeOfBirth,
      this.primaryInsuranceID,
      this.secoundName,
      this.thirdName});
}
