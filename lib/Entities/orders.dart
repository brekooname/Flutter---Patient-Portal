
class Order {
  String? orderDate;
  String? profileName;
  String? test_Normal_Range;
  String? productName;
  String? resultName;
  String? resultUnit;
  Order(
      {
      //this.Image,
      this.profileName,
      this.orderDate,
      this.test_Normal_Range,
      this.resultName,
      this.productName,
      this.resultUnit});
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        profileName: json['profileName'],
        orderDate: json['orderDate'],
        test_Normal_Range: json['test_Normal_Range'],
        productName: json['productName'],
        resultName: json['resultName'] as String,
        resultUnit: json['resultUnit']);
  }
}
