class PatientEncounters {
  String? Id;
  String? PatientId;
  String? EncounterId;
  String? FacilityId;
  String? EncounterDate;
  String? Encountertype;

  PatientEncounters(
      {this.EncounterDate,
      this.EncounterId,
      this.Encountertype,
      this.FacilityId,
      this.Id,
      this.PatientId});
  factory PatientEncounters.fromJson(dynamic json) {
    return PatientEncounters(
        PatientId: json['patientId'] as String,
        EncounterDate: json['encounterDate'] as String,
        FacilityId: json['facilityId'] as String,
        Encountertype: json['encountertype'] as String,
        EncounterId: json['encounterId'],
        Id: json['id']);
  }
}
