class AppUser {
  String? userID;
  String? loginUserName;
  String? emailAddress;
  String? phoneNumber;
  String? mobileNumber;
  String? preferredLanguage;
  bool? isActive;

  AppUser(
      {this.emailAddress,
      this.isActive,
      this.loginUserName,
      this.mobileNumber,
      this.phoneNumber,
      this.preferredLanguage,
      this.userID});
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      userID: json['userID'] as String? ?? 'default_userID',
      loginUserName: json['loginUserName'] as String? ?? 'default_loginUserName',
      emailAddress: json['emailAddress'] as String? ?? 'default_emailAddress',
      mobileNumber: json['mobileNumber'] as String? ?? 'default_mobileNumber',
      preferredLanguage: json['preferredLanguage'] as String? ?? 'default_language',
      isActive: json['isActive'] as bool? ?? false,
    );
  }

}
