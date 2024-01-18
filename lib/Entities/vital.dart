import 'package:flutter/cupertino.dart';

class Vital {
  String? reaD_DATE;
  String? reaD_TEMP;
  String? reaD_RES_RATE;
  String? reaD_BP_SYSTOLIC;
  String? reaD_PULSE;
  String? reaD_BP_DIASTOLIC;
  String? encounteR_PATIENT_WEIGHT;
  String? encounteR_PATIENT_HEIGHT;
  String? bmi;
  String? reaD_ID;
  String? encounterId;
  Vital(
      {@required this.bmi,
      this.encounteR_PATIENT_HEIGHT,
      this.encounteR_PATIENT_WEIGHT,
      this.reaD_BP_DIASTOLIC,
      this.reaD_BP_SYSTOLIC,
      this.reaD_DATE,
      this.reaD_PULSE,
      this.reaD_RES_RATE,
      this.reaD_TEMP,
      this.encounterId,
      this.reaD_ID});
  factory Vital.fromJson(dynamic json) {
    return Vital(
        bmi: json['bmi'] as String,
        encounteR_PATIENT_HEIGHT: json['encounteR_PATIENT_HEIGHT'] as String,
        encounteR_PATIENT_WEIGHT: json['encounteR_PATIENT_WEIGHT'] as String,
        reaD_BP_DIASTOLIC: json['reaD_BP_DIASTOLIC'] as String,
        reaD_BP_SYSTOLIC: json['reaD_BP_SYSTOLIC'] as String,
        reaD_DATE: json['reaD_DATE'] as String,
        reaD_PULSE: json['reaD_PULSE'] as String,
        reaD_RES_RATE: json['reaD_RES_RATE'] as String,
        reaD_TEMP: json['reaD_TEMP'] as String,
        reaD_ID: json['reaD_ID'] as String,
        encounterId: json['encounteR_ID']);
  }
}
