import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Entities/CaregoryLabResults.dart';
import 'package:soul/Entities/orders.dart';
import 'package:soul/Request/requests.dart';
import 'package:soul/constants.dart';

import '../../Components/tableViews.dart';
import '../MainPage_Screen/main_page.dart';

class LabResult extends StatefulWidget {
  @override
  _LabResultState createState() => _LabResultState();
}

class _LabResultState extends State<LabResult> {
  DateTime? _fromdate;
  bool load = false;
  DateTime? _todate;
  String? lab, test, fromdate, todate;
  final _formKey = GlobalKey<FormState>();
  bool showResult = false;
  dynamic apiresult;
  Container? c1;
  bool showContainer = false;
  TextEditingController testNameController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController labNameController = TextEditingController();
  List<CaregoryLabResults> categorylist = [
    CaregoryLabResults(CategoryName: "first", OrdersList: [
      Order(
          productName: "Cbc",
          resultName: "10",
          resultUnit: "test",
          test_Normal_Range: "10",
          orderDate: "10000",
          profileName: "test")
    ])
  ];

  @override
  void initState() {
    super.initState();
    getpatientid();
    getfacilityname();
    setInitialDatesAndFetchResults();
  }

  void setInitialDatesAndFetchResults() async {
    DateTime today = DateTime.now();
    DateTime lastWeek = today.subtract(Duration(days: 7));

    setState(() {
      _fromdate = lastWeek;
      _todate = today;
      fromDateController.text = DateFormat('yyyy-MM-dd').format(lastWeek);
      toDateController.text = DateFormat('yyyy-MM-dd').format(today);
    });

    await getOrders();
  }

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Data Loaded',
  );

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    testNameController.dispose();
    labNameController.dispose();

    super.dispose();
  }

  String? facilityname, patientid;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    //final sharedprefs = SharedPreferences.getInstance();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 4,
          toolbarHeight: queryData.size.height * 0.08,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage('', '', false)),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF056195),
              size: 30,
            ),
          ),
          title: Center(
              child: Text("Lab Results",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF056195),
                ),),),
          backgroundColor: Colors.white,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateInput('From', fromDateController, _fromdate),
                _buildDateInput('To', toDateController, _todate),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: InkWell(
                    onTap: () async {
                      print(categorylist.length);
                      //categorylist.clear();
                      print(load.toString());
                      if (_fromdate != null &&
                          _todate != null &&
                          load == false) {
                        // await getOrders();
                        if (!load) {
                          print(fromdate);
                          await getOrders();
                          setState(() {
                            showResult = true;

                            categorylist.removeAt(0);
                            //load=false;
                            // showData(showResult);
                            //load = true;
                          });
                        } else {
                          print("kxnck");
                          print(load.toString());
                          setState(() {
                            print(fromdate);
                            check();
                          });
                        }
                      } else {
                        showAlertDialog(context,
                            "Please fill both From and To dates.");
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF056195), Color(0xFF0274A1)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(child: showData(showResult)),
          ],
        ),
      ),
    );
  }

  Widget _buildDateInput(
      String label, TextEditingController controller, DateTime? date) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF056195), // Set text color
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Required Field' : null,
                  controller: controller,
                  textAlign: TextAlign.center,
                  cursorColor: Color(0xFF056195),
                  // Set cursor color
                  decoration: InputDecoration(
                    hintText: date == null
                        ? ''
                        : DateFormat('dd-MM-yyyy').format(date),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.date_range_rounded,
                        color: Color(0xFF056195), // Set icon color
                      ),
                      onPressed: () => _selectDate(context, controller),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kPrimaryColor,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor,
            ).copyWith(
              secondary: kPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final selectedDateText = DateFormat('dd-MM-yyyy').format(pickedDate);
      if (selectedDateText != controller.text) {
        setState(() {
          controller.text = selectedDateText;
          if (controller == fromDateController) {
            _fromdate = pickedDate; // Set _fromdate
          } else if (controller == toDateController) {
            _todate = pickedDate; // Set _todate
          }

          // Check if both dates are selected
          if (_fromdate != null && _todate != null) {
            if (_fromdate!.isBefore(_todate!)) {
              // Dates are valid, you can perform the search here
            } else {
              showAlertDialog(context, "From date must be before To date.");
            }
          }
        });
      }
    }
  }

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Rounded corners for the dialog
          ),
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error,
                  size: 40,
                  color: Colors.red,
                ), // A leading error icon
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Error",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ), // Bold title
                SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ), // Centered message
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.red.shade300;
                        return Colors.red; // Default color
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ), // Custom styled button with rounded corners
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _textLabel(String label) => Text(label,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 18.0, color: Colors.black));



  Future<void> getOrders() async {
    if (_fromdate != null && _todate != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("token")!;
      Requests req = new Requests();
      List<String> ProfileNames = ["name"];
      List<Order> labResults = [];
      setState(() {
        categorylist.clear();
      });
      print(patientid);
      String formattedFromDate = DateFormat('yyyy-MM-dd').format(_fromdate!);
      String formattedToDate = DateFormat('yyyy-MM-dd').format(_todate!);
      req
          .getOrderDetails(context, facilityname, "Lab", formattedFromDate,
              formattedToDate, patientid, token)
          .then((value) {
        if (value.isEmpty) {
          showMessageDialog(context,        "No readings found in the given date interval.",
          ); // Show the dialog if no data is found
        } else {
          print(value);

           setState(() {
            value.forEach((item) => labResults.add(item));
            print("labress" + labResults.toString());
            for (Order order in labResults) {
              if (ProfileNames.length == 0) {
                print("object" + order.profileName!);
                ProfileNames.add(order.profileName!);
                print("object1" + ProfileNames.toString());
                CaregoryLabResults category =
                new CaregoryLabResults(CategoryName: " name", OrdersList: []);
                category.CategoryName = order.profileName;
                print("object2" + order.toString());
                category.OrdersList!.add(order);
                print("object3" + category.OrdersList.toString());
                categorylist.add(category);
                print("object4" + categorylist.toString());
              } else {
                if (ProfileNames.contains(order.profileName)) {
                  // get the index of the profile name in list category list
                  var index = categorylist.indexWhere(
                          (element) =>
                      element.CategoryName == order.profileName);
                  var elemnt = categorylist.elementAt(index);
                  print("object5" + elemnt.CategoryName!);
                  elemnt.OrdersList!.add(order);
                  print("object6" + order.toString());
                } else {
                  ProfileNames.add(order.profileName!);
                  print("object7" + ProfileNames.toString());
                  CaregoryLabResults category = new CaregoryLabResults(
                      CategoryName: " name", OrdersList: []);
                  category.CategoryName = order.profileName;
                  print("object8" + order.toString());
                  category.OrdersList!.add(Order(
                      orderDate: order.orderDate,
                      resultName: order.resultName,
                      resultUnit: order.resultUnit,
                      test_Normal_Range: order.test_Normal_Range,
                      productName: order.productName,
                      profileName: order.profileName));
                  print("object9" + category.OrdersList.toString());
                  categorylist.add(category);
                  print("object10" + categorylist.toString());
                }
              }
            }
            print("category" + categorylist.toString());
            print("start to show");
            print(categorylist);
//       if(load==false){
// categorylist.clear();
//       }
          });
        }
      });

      print("end show");
    }
  }
  void showMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20),
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 50,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "No Readings Found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget showData(bool value) {
    if (value) {
      return CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          height: MediaQuery.of(context).size.height * 0.6,
        ),
        items: categorylist.map((item) {
          // Extracting and formatting the date from the first order in the list
          String displayDate = item.OrdersList != null && item.OrdersList!.isNotEmpty
              ? DateFormat('yyyy-MM-dd').format(DateTime.parse(item.OrdersList!.first.orderDate ?? ""))
              : "No Date";

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFf5f7fa), Color(0xffc9ddfc)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.CategoryName}",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF056195),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Date: $displayDate",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 20),
                      TableViews(result: item.OrdersList),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      return Container(); // Empty container for no interaction state
    }
  }


  Future<String> getpatientid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    patientid = sh.getString("patientid");
    return patientid!;
  }

  Future<String> getfacilityname() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    facilityname = sh.getString('facilityname');
    return facilityname!;
  }

  void check() {
    // setState(() {
    // _todate = null;
    showResult = false;
    // _fromdate = null;
    _formKey.currentState!.reset();
    load = false;
    categorylist.clear();

    // getOrders();
    print(categorylist.length);
    //orders=null;
    // });
  }
}
String _getDateText(List<Order>? orders) {
  if (orders == null || orders.isEmpty) return 'No Date Available';

  // Assuming you want to display the earliest date from the orders list
  var earliestDate = orders.map((o) => o.orderDate).where((d) => d != null).reduce((a, b) => a!.compareTo(b!) < 0 ? a : b);
  return earliestDate != null ? 'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(earliestDate))}' : 'No Date Available';
}
