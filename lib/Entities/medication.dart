import 'package:flutter/cupertino.dart';

class Medication {
  String? medicationDescription;
  String? OrderedBy;
  String? OrderedDate;
  String? EncounterId;
  String? instruction;
  String? Status;
  String? ExecutionDate;
  String? encounterId;

  Medication(
      {@required this.medicationDescription,
      this.OrderedBy,
      this.OrderedDate,
      this.EncounterId,
      this.instruction,
      this.Status,
      this.ExecutionDate,
      this.encounterId});

  factory Medication.fromJson(dynamic json) {
    return Medication(
        medicationDescription: json['medicationDescription'] as String,
        OrderedBy: json['orderedBy'] as String,
        OrderedDate: json['orderedDate'] as String,
        instruction: json['medicationInstruction'] as String,
        Status: json['status'] as String,
        EncounterId: json['encounterId'] as String,
        ExecutionDate: json['executionDate'] as String,
        encounterId: json['encounterId']
    );
  }
}
