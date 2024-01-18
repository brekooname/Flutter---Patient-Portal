class AppointmentSetting {
  String? dayName;
  String? FromHour, ToHour, Daystatus;
  AppointmentSetting(
      {this.Daystatus, this.FromHour, this.ToHour, this.dayName});
  factory AppointmentSetting.fromJson(Map<String, dynamic> json) {
    return AppointmentSetting(
      dayName: (json['dayName'] as String?) ?? '',
      FromHour: (json['FromHour'] as String?) ?? '',
      ToHour: (json['ToHour'] as String?) ?? '',
      Daystatus: (json['Daystatus'] as String?) ?? '',
    );
  }

}
