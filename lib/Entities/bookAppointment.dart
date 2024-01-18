class BookAppointment {
  String? PatientID;
  String? DepartmentID;
  String? FacilityId;
  String? Source;
  DateTime? AppointmentDateTime;

  BookAppointment(
      {this.AppointmentDateTime,
      this.DepartmentID,
      this.FacilityId,
      this.PatientID,
      this.Source});
}
