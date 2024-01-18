class FamilyMem {
  String? patientId;
  String? relation;
  String? patientName;
  String? relatedpatientId;
  String? facilityId;
  String? Encounterid;
  FamilyMem(
      {this.facilityId,
      this.patientId,
      this.patientName,
      this.relation,
      this.relatedpatientId,
      this.Encounterid});

  factory FamilyMem.fromJson(Map<String, dynamic> json) {
    return FamilyMem(
      patientId: json['patientId'] as String,
      relation: json['relationType'] as String,
      patientName: json['patientName'] as String,
      relatedpatientId: json['relatedPatientId'] as String,
      facilityId: json['facilityId'] as String,
      Encounterid: json['encounterid'] as String,
    );
  }
}
