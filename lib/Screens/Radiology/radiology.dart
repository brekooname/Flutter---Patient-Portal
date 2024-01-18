import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Components/radVeiw.dart';
import 'package:soul/Entities/radRes.dart';
import 'package:soul/Request/requests.dart';
import 'package:soul/constants.dart';

import '../../Entities/orders.dart';
import '../MainPage_Screen/main_page.dart';

class Radiology extends StatefulWidget {
  @override
  _Radiology createState() => _Radiology();
}

class _Radiology extends State<Radiology> {
  DateTime? _fromdate;
  DateTime? _todate;

  String FacilityName = "Caritas";
  String type = "Rad";
  String? facilityname, patientid;
  DateTime from = new DateTime(01 - 01 - 2021);
  DateTime to = new DateTime(01 - 09 - 2022);
  String patientId = "CP000024";
  String? lab, test, fromdate, todate;
  bool _val = false;
  File? _image;
  bool load = false;bool hasDialogBeenShown = false;

  String? _uploadedFileURL;
  final _formKey = GlobalKey<FormState>();


  List<RadRes> orders = [];
  List<Order>? orders1;
  bool showResult = false;
  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Data Loaded',
  );
  TextEditingController testNameController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController labNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getfacilityname();
    getpatientid();
    // Set initial dates for the search
    _fromdate = DateTime.now().subtract(Duration(days: 7)); // One week before today
    _todate = DateTime.now(); // Today's date
    getOrder(); // Perform initial search
  }

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          toolbarHeight: queryData.size.height * 0.08,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage('', '', false)),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF056195),
              size: 30,
            ),
          ),
          title: Center(
            child: Text(
              "Radiology Reports",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF056195),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        backgroundColor: Colors.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDateInput(
                            'From', fromDateController, _fromdate),
                        _buildDateInput('To', toDateController, _todate),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: InkWell(
                            onTap: () async {
                              if (_fromdate != null && _todate != null) {
                                print(_fromdate);
                                print(_todate);

                                // The original logic from your second button
                                print(orders.length);
                                if (!load) {
                                  print(fromdate);
                                  setState(() {
                                    showResult = true;
                                    getOrder();
                                  });
                                } else {
                                  print("kxnck");
                                  print(load.toString());
                                  setState(() {
                                    check();
                                    print(fromdate);
                                  });
                                }
                              } else {
                                showAlertDialog(context, "Please fill both From and To dates.");
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
                    ),   Expanded(
                      child: showData(showResult),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
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
            borderRadius: BorderRadius.circular(15.0), // Rounded corners for the dialog
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


  Widget showData(bool value) {
    if (value && orders.isNotEmpty) {
      return CarouselSlider(
        options: CarouselOptions(
          height: 400, // Set an appropriate height
          enlargeCenterPage: true,
          enableInfiniteScroll: false, // Disable infinite scroll
          // Other carousel options as needed
        ),
        items: orders.map((report) {
          return Builder(
            builder: (BuildContext context) {
              return RadView(report: report); // Pass each report to RadView
            },
          );
        }).toList(),
      );
    } else if (value) {
      // Handle the case where 'value' is true but 'orders' is empty
      return Container();
    } else {
      // Handle the default case
      return Container();    }
  }
  Future<void> getOrder() async {
    if (_fromdate != null && _todate != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("token")!;
      Requests req = new Requests();
      setState(() {
        orders.clear();
      });
      // Format _fromdate and _todate as strings
      String formattedFromDate = DateFormat('yyyy-MM-dd').format(_fromdate!);
      String formattedToDate = DateFormat('yyyy-MM-dd').format(_todate!);

      List<RadRes>? value = await req.getOrderDetailsForRadiology(
       context,
        facilityname,
        type,
        formattedFromDate, // Use formattedFromDate here
        formattedToDate,   // Use formattedToDate here
        patientid,
        token,
      );

      if (value != null && value.isNotEmpty) {
        setState(() {
          orders.addAll(value);
        });
      }else {
        // showAlertDialog2(context);
      }
    } else {
      // Handle the case where _fromdate or _todate is null (e.g., show an error message)
    }
  }
  showAlertDialog2(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          _fromdate = null;
          _todate = null;
          fromdate = null;
          todate = null;
          hasDialogBeenShown = false;  // Reset the flag here.
        });
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("There is no data to display"),
      content: Text("No data"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<String> getpatientid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    patientid = sh.getString('patientid');
    return patientid!;
  }

  Future<String> getfacilityname() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    facilityname = sh.getString('facilityname');
    return facilityname!;
  }

  void check() {
    // setState(() {
    //_todate = null;
    showResult = false;
    // _fromdate = null;
    _formKey.currentState!.reset();
    load = false;
    orders.clear();
    print(orders.length);
    //orders=null;
    // });
  }
}
