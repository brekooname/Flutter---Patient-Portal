import 'package:flutter/cupertino.dart';

class Prescription {
  String? MedicationDescription;
  String? OrderedBy;
  String? OrderedDate;
  String? EncounterId;
  String? MedicationInstruction;
  String? PrescreptionId;

  Prescription(
      {@required this.MedicationDescription,
      this.OrderedBy,
      this.OrderedDate,
      this.EncounterId,
      this.MedicationInstruction,
      this.PrescreptionId});
  factory Prescription.fromJson(dynamic json) {
    return Prescription(
        MedicationDescription: json['medicationDescription'] as String,
        OrderedBy: json['orderedBy'] as String,
        OrderedDate: json['orderedDate'] as String,
        MedicationInstruction: json['medicationInstruction'] as String,
        PrescreptionId: json['prescreptionId'] as String,
        EncounterId: json['encounterId']);
  }
}
