class VerivicationCodeResponse {
  String? userId;
  String? patientId;
  int? vCode;
  bool? valid;

  VerivicationCodeResponse(
      {this.patientId, this.userId, this.vCode, this.valid});
  factory VerivicationCodeResponse.fromJson(Map<String, dynamic> json) {
    return VerivicationCodeResponse(
        userId: json['userId'] as String? ?? 'default_userId',
        patientId: json['patientId'] as String? ?? 'default_patientId',
        vCode: json['vCode'] as int? ?? 0, // assuming 0 as a default value for vCode
        valid: json['valid'] as bool? ?? false); // assuming false as a default value for valid
  }

}
