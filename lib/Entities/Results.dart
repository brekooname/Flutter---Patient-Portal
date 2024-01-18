class Results {
  String? orderDate;
  String? profileName;
  String? test_Normal_Range;
  String? productName;
  String? resultName;
  String? resultUnit;

  Results(
      {this.profileName,
      this.orderDate,
      this.test_Normal_Range,
      this.resultName,
      this.productName,
      this.resultUnit});
  static String getResults() {
    // must call api

    /*return <Results>[
      Results(date: "22-2-2020",ProfileName: "CBC",testname: "WBC",result: "4", unit: "x10^9 cells/L", range: "3.9-10.2",),
      Results(date: "22-2-2020",ProfileName: "CBC",testname: "WBC",result: "4", unit: "x10^9 cells/L", range: "3.9-10.2",),
      Results(date: "22-2-2020",ProfileName: "CBC",testname: "WBC",result: "4", unit: "x10^9 cells/L", range: "3.9-10.2",),
      Results(date: "22-2-2020",ProfileName: "CBC",testname: "WBC",result: "4", unit: "x10^9 cells/L", range: "3.9-10.2",)
    ];*/
    return 'null';
  }
}
