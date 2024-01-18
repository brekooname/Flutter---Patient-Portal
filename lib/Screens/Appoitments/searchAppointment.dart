import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Components/calender.dart';
import 'package:soul/Components/dropDownFiled.dart';

import 'package:soul/Entities/appointmentsTimeList.dart';
import 'package:soul/Entities/clinic.dart';
import 'package:soul/Entities/doctor.dart';
import 'package:soul/Request/requests.dart';
import 'package:soul/Screens/Appoitments/myAppointments/myAppointment.dart';
import '../MainPage_Screen/main_page.dart';

import 'package:soul/constants.dart';
import 'package:intl/intl.dart';

class SearchAppointment extends StatefulWidget {
  @override
  _SearchAppointmentState createState() => _SearchAppointmentState();
  String doctor = "";
  String clinicName = "";
  String clinicId = "";
  SearchAppointment(this.doctor, this.clinicName, this.clinicId);
}

class _SearchAppointmentState extends State<SearchAppointment> {
  @override
  void initState() {
    super.initState();
    getpatientid();
    getfacilityname();
    print(widget.doctor);
    print(widget.clinicName);
    print(widget.clinicId);
    if (widget.doctor == "" &&
        widget.clinicName == "" &&
        widget.clinicId == "") {
      getClinicName();
      // s1 = null;
      // s2 = null;
    } else {
      setState(() {
        clinicName[0] = widget.clinicName;

        clinicId = widget.clinicId;
        doctorName[0] = widget.doctor;
        s2 = widget.doctor;
        doctor = s2;
        s1 = widget.clinicName;
        clinic = s1;
        // _selectedDate=_selectedDate;
      });
    }
    print(clinics1);
    print("object");
    //WidgetsBinding.instance.addPostFrameCallback((_){_showDialog();});

    print(clinics1);

    //WidgetsBinding.instance.addPostFrameCallback((_){_showDialog();});
  }

  String? doctor;
  String? s1, s2;
  int? duration;
  String? clinic;
  String hint1 = "Deparment", hint2 = "Doctor";
  String btn = "Off";
  final clinics = Set<String>();
  List<Clinic>? clinics1 = [];
  String? clinicId;
  List<String> clinicName = ["111"];
  List<String> doctorName = ["1111"];
  List<AppointmentsTimeList> timeList = [];
  List<String> times = [];
  List<String> AvailableTimes = ["Appointment Time"];
  List<String> AdditionalTimes = ["Appointment Time"];
  String dropdownValue = "ِAppointment Time";
  List<String> additional = ["2"];
  List<String> available = ["2"];
  String? facilityname, patientid, userid;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime _selectedDate = DateTime.now();
  TextEditingController _searchDocController = TextEditingController();
  //TextEditingController _searchAreaController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _searchClinicController = TextEditingController();
  bool additionalvalue = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(elevation: 4,
        toolbarHeight: queryData.size.height * 0.08,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage('', '', false)),
            );
          },
          child: Icon(Icons.arrow_back,size: 30,  color: kPrimaryColor),  // Making the arrow icon white for consistency
        ),
        title: Text(
          "Book a new Appointment",
          style: TextStyle(
            fontSize: 22,  // Reduced font size for consistency
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,  // Center the title for better aesthetics
      ),
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),  // Overall padding for the body
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropDown(
                        list: clinicName,
                        v: s1,
                        value1: clinic,
                        hint: hint1,
                        onChanged1: (x) {
                          setState(() {
                            clinic = x;
                            getClinicId();
                          });
                        },
                      ),
                      SizedBox(height: 30),
                      if (clinic != null) ...[
                        DropDown(
                          v: s2,
                          list: doctorName,
                          value1: doctor,
                          hint: hint2,
                          onChanged1: (x) {
                            setState(() {
                              doctor = x;
                            });
                          },
                        ),
                        SizedBox(height: 30),
                      ],
                      if (doctor != null) ...[
                        _searchThree(context),
                        SizedBox(height: 30),
                        Center(
                          child: Doctorcalender(
                            date: _selectedDate,
                            times: times,
                            name: doctor,
                            drop: dropdownValue,
                            change: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                      if (clinic != null && doctor != null && _selectedDate != null && dropdownValue != null) ...[
                        checkSearch(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  // Widget _searchOne() => textField(
  //       'doctors',
  //       Icons.search,
  //       _searchDocController,
  //     );
  // Widget _searchSpeciality() => textField(
  //       'Clinic',
  //       Icons.search,
  //       _searchClinicController,
  //     );

  static List<Doctor>? doctors = [];

  Widget textField(String hint, IconData iconData,
          TextEditingController textEditingController,
          {bool isReadonly = false, Function? onTap, int minLines = 1, required Color shadowColor, required BorderSide border, required BorderRadius borderRadius}) =>
      Card(
        elevation: 3,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
          side: border ?? BorderSide.none,
          borderRadius: borderRadius ?? BorderRadius.circular(0),
        ),
        child: TextField(
            autofocus: false,
            onTap: () {
              if (onTap != null) onTap.call();
            },
            minLines: minLines,
            maxLines: null,
            controller: textEditingController,
            showCursor: !isReadonly,
            readOnly: isReadonly,
            style: TextStyle(color: kPrimaryColor, fontSize: 18),
            decoration: new InputDecoration(

                prefixIcon: iconData != null
                    ? IconButton(
                        icon: Icon(
                          iconData,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {},
                      )
                    : null,
                contentPadding:
                    EdgeInsets.only(left: 10, bottom: 12, top: 12, right: 10),
                hintStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.black.withOpacity(0.5)),
                hintText: hint)),
      );

  Widget _searchThree(BuildContext context) {
    return textField(
      'Select date',
      Icons.date_range,
      _dateController,
      isReadonly: true,
      onTap: () {
        final ThemeData theme = Theme.of(context);
        if (theme.platform == TargetPlatform.android) {
          _openDatePicker(context);
        } else _openDatePickerIOS();
      },
      shadowColor: kPrimaryColor,
      border: BorderSide(color: Color(0xFF056195)),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

// call create aapointment
  Widget _searchBtn(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),  // Add symmetric margin for consistency
        width: MediaQuery.of(context).size.width * 0.85,  // Use 85% of screen width for better padding
        child: ElevatedButton(
          onPressed: () {
            if (dropdownValue != "Appointment Time") {
              createAppointment(context);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            elevation: 5,
            padding: EdgeInsets.symmetric(vertical: 12),  // Add some padding for a better touch area
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,  // Slightly larger font size
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),  // Rounded edges
            ),
          ),
          child: Text('Book Now'),
        ),
      ),
    );
  }


  Widget _searchBtn2(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width * 0.85,
        child: ElevatedButton(
          onPressed: () {},  // Add functionality if needed
          style: ElevatedButton.styleFrom(
            primary: kPrimaryLightColor,
            elevation: 3,
            padding: EdgeInsets.symmetric(vertical: 12),
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: kPrimaryColor,  // To ensure the text stands out on a light background
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('Not yet'),
        ),
      ),
    );
  }

  Future<DateTime> Getdate(BuildContext context) async {
    final DateTime? result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    return result!;
  }

  void _openDatePicker(BuildContext context) async {
    DateTime result = await Getdate(context);

    Times(result);
  }

  Future<void> Times(DateTime result) async {
    if (result != _selectedDate &&
        doctor != null) {
      _selectedDate = result;
      _dateController.text = dateFormat(_selectedDate);

      await getTimes();
      print("object" + times.toString());
    } else if (result != _selectedDate) {
      _selectedDate = result;
      _dateController.text = dateFormat(_selectedDate);

      await getTimes();
      print("object" + times.toString());
    } else if (s1 != null &&
        s2 != null &&
        result != _selectedDate) {
      await getTimes();
      print("object" + times.toString());
    }
  }

  String dateFormat(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  ElevatedButton elevatedButton(
          {@required String? text,
          @required Color? color,
          @required Function? onPress,
          Color textColor = Colors.white,
          double textSize = 18,
          FontWeight fontWeight = FontWeight.w500,
          bool compactSize = false}) =>
      ElevatedButton(
          onPressed: () => {onPress!.call()},
          child: Text(
            text!,
            style: TextStyle(
                fontSize: textSize, color: textColor, fontWeight: fontWeight),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color!),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: compactSize ? 0 : 14)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)))));

  void _openDatePickerIOS() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (result) {
                if (result != _selectedDate)
                  setState(() {
                    _selectedDate = result;
                    _dateController.text = dateFormat(_selectedDate);
                  });
              },
              initialDateTime: _selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });

    final DateTime? result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (result != null && result != _selectedDate)
      setState(() {
        _selectedDate = result;
        _dateController.text = dateFormat(_selectedDate);
      });
  }

  Widget toolbarView(String label, MediaQueryData queryData) => Container(
      height: queryData.size.height * 0.08,
      // padding: EdgeInsets.only(left: 30, bottom: 10),
      // alignment: Alignment.centerLeft,
      child: Center(
        child: Text(label,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.2),
              offset: const Offset(0, 1.0),
              blurRadius: 4.0,
              spreadRadius: 2.0,
            ),
          ]));

  Future<List<String>> getClinicName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");

    req.GetClinics(facilityname!, s).then((value) {
      setState(() {
 value.forEach((item) => clinics1!.add(item));
        clinicName = clinics1!.map((e) => e.name!).toList();

        print(clinicName.toString());
      });

      // print("Clinics1"+clinics1.toString());
      return clinicName;
    });

    //print(clinicName.toString());
    return clinicName;
  }

  Future<String> getClinicId() async {
    if (widget.clinicId == "") {
      List<Clinic> clin;
      List<Clinic>? cl;
      final pref = await SharedPreferences.getInstance();
      String s = pref.getString("clinics")!;
      print("sssss//" + s);
      if (s != null) {
        final parsed = jsonDecode(s).cast<Map<String, dynamic>>();
        clin = parsed.map<Clinic>((json) => Clinic.fromJson(json)).toList();
        print("clinicname  " + clinic!);
        clin.where((e) => e.name == clinic);
        print("clll" + cl.toString());
        clinicId = clin.first.id;
        print("clinicId" + clinicId!);
        getDoctorofClinic();
        return clinicId!;
      } else {
        print("no data in sharedpreference");
      }
    }
    return 'null';
  }

  Future<List<String>> getDoctorofClinic() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    print("requestooooooooo");
    // getClinicId();

    Requests req = new Requests();
    print("requestooooooooo");
    doctors!.clear();
    req.GetDoctorsDetailsOfClinic(facilityname, s, clinicId).then((value) {
      print("value" + value.toString());
      //doctors.clear();
 value.forEach((item) => doctors!.add(item));
      setState(() {
        print("Doctors" + doctors.toString());
        doctorName = doctors!.map((e) => e.fullName!).toList();
        doctorName = Set.of(doctorName).toList();
        // duration
        print(doctorName.toString());
      });

      // print("Clinics1"+clinics1.toString());
      return doctorName;
    });

    //print(clinicName.toString());
    return doctorName;
  }

  Future<List<String>> getTimes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");

    var value = await req.GetAppointmentTimeSlots(
        facilityname, patientid, doctor, clinicId, _selectedDate, s);

    print("vall" + value.toString());
    if (value.length != 0) {
      print("times" + times.toString());
      times.clear();
      dropdownValue = "Appointment Time";

      value.forEach((item) => timeList.add(item));
      for (var i = 0; i < timeList.length; i++) {
        if (timeList[i].quotaType != "BookedQuota") {
          for (var j = 0; j < timeList[i].appointmentTimeSlots!.length; j++) {
            times.add(timeList[i].appointmentTimeSlots![j]);
            if (timeList[i].quotaType == "AvailableQuota") {
              AvailableTimes.add(timeList[i].appointmentTimeSlots![j]);
            } else if (timeList[i].quotaType == "AdditionalAvailableQuota") {
              AdditionalTimes.add(timeList[i].appointmentTimeSlots![j]);
            }
          }
        }
      }
    } else {
      print("to clear");
      times.clear();
      dropdownValue = " Appointment Time";
    }

    if (times.length == 0) {
      showAlertDialog2(context);
    }

    return times;
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyAppointments()),
        );
      },
      child: Text("OK", style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor, // Use theme color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Theme.of(context).primaryColor), // Use theme color
          SizedBox(width: 8),
          Text("Appointment Created"),
        ],
      ),
      content: Text("Your appointment has been created successfully.", style: TextStyle(fontSize: 16)),
      actions: [
        okButton,
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showAlertDialog2(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kPrimaryColor,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text("OK", style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          clinic = clinic;
          doctor = doctor;
          dropdownValue = "Appointment Time";
        });
        _openDatePicker(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      title: Text(
        "Invalid Date Selected",
        style: TextStyle(
          color: kPrimaryColor, // Use primary color for the title
          fontWeight: FontWeight.bold,
          fontSize: 18, // Increase the font size for the title
        ),
      ),
      content: Row(
        children: [
          Icon(Icons.error_outline, color: kPrimaryColor, size: 30), // Use primary color and increased size for the error icon
          SizedBox(width: 15),
          Expanded(
            child: Text(
              "The selected date is unavailable as the doctor is off. Please choose another date.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      actions: [
        okButton,
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.white,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Future<void> createAppointment(BuildContext context) async {
    //dropdownValue
    // with AM and PM
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;

    // concat date with time
    print(dropdownValue);
    String Appdate = dateFormat(_selectedDate);
    final String dateTimeString = Appdate + " " + dropdownValue;
    final DateFormat format = new DateFormat("yyyy-MM-dd hh:mm a");
    print(format.parse(dateTimeString));
    DateTime AppointmentDateTime = format.parse(dateTimeString);

    Requests req = new Requests();
    if (AvailableTimes.contains(dropdownValue)) {
      additionalvalue = false;
    } else if (AdditionalTimes.contains(dropdownValue)) {
      additionalvalue = true;
    }
    if (doctor == null) {
      doctor = "";
    }

    duration = 20;
    print(AppointmentDateTime.toIso8601String());
//"2022-04-12T11:39:46.063Z"
    req
        .createAppointment(
            facilityname,
            clinicId,
            patientid,
            doctor,
            AppointmentDateTime.toIso8601String(),
            additionalvalue,
            duration,
            42,
            "",
            s)
        .then((value) {
      print("value" + value.toString());
      setState(() {
        print("vvvvv" + value.toString());
        showAlertDialog(context);
      });
    });
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

  Widget checkSearch() {
    if (doctor != null &&
        clinic != null &&
        dropdownValue != "Appointment Time") {
      print("doctor//" + doctor!);

      return _searchBtn(context);
    } else if (clinic != null &&
        dropdownValue != "Appointment Time") {
      return _searchBtn(context);
    } else {
      // print("dropdoun value"+dropdownValue);
      // print("doctor//"+doctor);
      //print("object"+clinic);

      return _searchBtn2(context);
    }
  }
}
