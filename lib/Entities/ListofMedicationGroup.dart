import 'package:soul/Entities/medication.dart';
import 'package:flutter/cupertino.dart';

class ListofMedicationGroup {
  String? MedicationName;
  List<Medication>? ListofMedication;

  ListofMedicationGroup({@required this.MedicationName, this.ListofMedication});
  factory ListofMedicationGroup.fromJson(Map<String, dynamic> json) {
    return ListofMedicationGroup(
        MedicationName: json['medicationName'] as String,
        ListofMedication: List<dynamic>.from(json['listofMedication'])
            .map((i) => Medication.fromJson(i))
            .toList());
  }
}
