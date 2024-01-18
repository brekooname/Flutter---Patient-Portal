
class RadRes {
  String? orderDate;
  String? productName;
  String? orderID;
  String? orderingPhysician;
  String? status;
  String? testNotes;
  String? examinationDate;
  String? acceptanceStatus;
  // Add more fields as per your JSON response

  RadRes({
    this.orderDate,
    this.productName,
    this.orderID,
    this.orderingPhysician,
    this.status,
    this.testNotes,
    this.examinationDate,
    this.acceptanceStatus,
    // Initialize other fields here
  });

  factory RadRes.fromJson(Map<String, dynamic> json) {
    return RadRes(
      orderDate: json['orderDate'],
      productName: json['productName'],
      orderID: json['orderID'],
      orderingPhysician: json['orderingPhysician'],
      status: json['status'],
      testNotes: json['testNotes'],
      examinationDate: json['examinitationDate'],
      acceptanceStatus: json['acceptanceStatus'],
      // Parse other fields from JSON here
    );
  }
}
