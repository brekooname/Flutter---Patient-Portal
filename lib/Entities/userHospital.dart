class UserHospital {
  String? ID;
  // [ForeignKey("UserID")]
  //public ICollection<AppUser> Users { get; set; }
  String? UserID;
  String? HospitalID;
  String? PatientID;
  String? PatientName;
  String? PhoneNumber;
  String? facilityname;
  String? facilityid;
  String? defaultencounterid;
  String? Country;

  UserHospital(
      {this.defaultencounterid,
      this.facilityid,
      this.Country,
      this.HospitalID,
      this.ID,
      this.PatientID,
      this.PatientName,
      this.PhoneNumber,
      this.UserID,
      this.facilityname});

  factory UserHospital.fromJson(Map<String, dynamic> json) {
    return UserHospital(
        ID: json['id'] as String? ?? 'default_id',
        UserID: json['userID'] as String? ?? 'default_userID',
        HospitalID: json['hospitalID'] as String? ?? 'default_hospitalID',
        PatientID: json['patientID'] as String? ?? 'default_patientID',
        PatientName: json['patientName'] ?? 'default_patientName',
        PhoneNumber: json['phoneNumber'] ?? 'default_phoneNumber',
        Country: json['country'] ?? 'default_country',
        facilityname: json['facilityName'] ?? 'default_facilityName',
        facilityid: json['facilityId'] ?? 'default_facilityId',
        defaultencounterid: json['defautEncounterId'] ?? 'default_encounterId');
  }

}
