import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:soul/Components/placeholder_widget.dart';
import 'package:soul/Entities/vital.dart';
import 'package:soul/Request/requests.dart';
import 'package:soul/Screens/Home_Screen/home.dart';
import 'package:soul/Screens/Vital_Screen/VitalList.dart';
import 'package:soul/constants.dart';
import 'package:soul/Components/addButton.dart';
import 'package:soul/Components/text_field_container.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import '../../Components/vitalSigns.dart';
import '../FamilyMember/switch.dart';
import '../MainPage_Screen/main_page.dart';
import 'Vital_Signs.dart';

class VitalFilter extends StatefulWidget {
  @override
  _VitalFilter createState() => _VitalFilter();
}

class _VitalFilter extends State<VitalFilter> {
  DateTime? _fromdate;
  String? encounterid;

  bool load = false;
  DateTime? _todate; List<Vital> vitalResults = [];
  String? lab, test, fromdate, todate;
  final _formKey = GlobalKey<FormState>();
  bool showResult = false;
  dynamic apiresult;
  Container? c1;
  bool showContainer = false;
  //TextEditingController testNameController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  //TextEditingController labNameController = TextEditingController();

  @override
  void initState() {
    getpatientid();
    getfacilityname();
    getEncounterid();
    _fromdate = DateTime.now().subtract(Duration(days: 7));

    // Set the _todate to today's date
    _todate = DateTime.now();
    fromDateController.text = DateFormat('yyyy-MM-dd').format(_fromdate!);
    toDateController.text = DateFormat('yyyy-MM-dd').format(_todate!);
    getVitals();
    super.initState();
  }

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Data Loaded',
  );
  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();

    super.dispose();
  }

  int _currentIndex = 1;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [
    PlaceholderWidget(HomePage()),
    PlaceholderWidget(Switch1()),
  ];
  String? facilityname, patientid;





  List<VitalS> _convertVitalToVitalS(Vital? vital) {
    if (vital == null) return [];

    return [
      VitalS(text1: 'Temperature:', text2: vital.reaD_TEMP ?? ""),
      VitalS(text1: 'Respiratory Rate:', text2: vital.reaD_RES_RATE ?? ""),
      VitalS(text1: 'BP-Systolic:', text2: vital.reaD_BP_SYSTOLIC ?? ""),
      VitalS(text1: 'BP-Diastolic:', text2: vital.reaD_BP_DIASTOLIC ?? ""),
      VitalS(text1: 'Height:', text2: vital.encounteR_PATIENT_HEIGHT ?? ""),
      VitalS(text1: 'Weight:', text2: vital.encounteR_PATIENT_WEIGHT ?? ""),
      VitalS(text1: 'Pulse:', text2: vital.reaD_PULSE ?? ""),
      VitalS(text1: 'BMI:', text2: vital.bmi ?? ""),
    ];
  }


  @override

  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
              "Vitals",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF056195),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView( // Added SingleChildScrollView
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDateInput('From', fromDateController, _fromdate),
                    _buildDateInput('To', toDateController, _todate),
                    InkWell(
                      onTap: () async {
                        if (_fromdate != null && _todate != null) {
                          await getVitals();
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
                  ],
                ),
                SizedBox(height: 20),
                vitalResults.isNotEmpty
                    ? CarouselSlider(
                  options: CarouselOptions(
                    initialPage: 1 - vitalResults.length, // set to the last index
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    height: queryData.size.height * 0.6,
                    reverse: true, // to make the scroll direction to the left
                  ),
                  items: vitalResults.map((item) {
                    List<VitalS> currentVitals = _convertVitalToVitalS(item);
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
                                  "Vital Signs on ${item.reaD_DATE!.substring(0, 10)}",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF056195),
                                  ),
                                ),
                                SizedBox(height: 20),
                                ...currentVitals.map((vital) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            _getIconForText(vital.text1.toString()),
                                            SizedBox(width: 10),
                                            Text(
                                              vital.text1.toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF056195),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          vital.text2.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF056195).withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _getIconForText(String text) {
    switch (text) {
      case 'Temperature:':
        return Image.asset(
          'assets/images/thermometer.png',
          width: 32,
          height: 32,
        );
      case 'Respiratory Rate:':
        return Image.asset(
          'assets/images/icons8-lungs-50.png',
          width: 32,
          height: 32,
        );
      case 'BP-Systolic:':
      case 'BP-Diastolic:':
        return Image.asset(
          'assets/images/icons8-tonometer-50.png',
          width: 32,
          height: 32,
        );
      case 'Height:':
        return Image.asset(
          'assets/images/height.png',
          width: 32,
          height: 32,
        );
      case 'Weight:':
        return Image.asset(
          'assets/images/scale.png',
          width: 32,
          height: 32,
        );
      case 'Pulse:':
        return Image.asset(
          'assets/images/life-line.png',
          width: 32,
          height: 32,
        );
      case 'BMI:':
        return Image.asset(
          'assets/images/bmi.png',
          width: 32,
          height: 32,
        );
      default:
        return SizedBox.shrink(); // Return an empty SizedBox if text doesn't match any case
    }
  }

  Widget _buildDateInput(String label, TextEditingController controller, DateTime? date) {
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
                  validator: (value) => value!.isEmpty ? 'Required Field' : null,
                  controller: controller,
                  textAlign: TextAlign.center,
                  cursorColor: Color(0xFF056195), // Set cursor color
                  decoration: InputDecoration(
                    hintText: date == null ? '' : DateFormat('dd-MM-yyyy').format(date),
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
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
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

  Widget _textLabel(String label) => Text(label,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 18.0, color: Colors.black));

  Future<void> getVitals() async {
    if (_fromdate != null && _todate != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("token")!;
      Requests req = new Requests();
      setState(() {
        vitalResults.clear();
      });
      // Format _fromdate and _todate as strings
      String formattedFromDate = DateFormat('yyyy-MM-dd').format(_fromdate!);
      String formattedToDate = DateFormat('yyyy-MM-dd').format(_todate!);

      List<Vital>? value = await req.GetVitalSignRead(
        context,
        facilityname!,
        patientid!,
        encounterid!,
        formattedFromDate, // Use formattedFromDate here
        formattedToDate,   // Use formattedToDate here
        token,
      );

      if (value != null) {
        setState(() {
           vitalResults.addAll(value);
        });
      } else {
        showAlertDialog2(context);
      }
    } else {
      // Handle the case where _fromdate or _todate is null (e.g., show an error message)
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

  Future<String> getEncounterid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    //encounterid = sh.getString('defaultencounter');
    encounterid = sh.getString('defaultencounter');
    return encounterid!;
  }

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
}
