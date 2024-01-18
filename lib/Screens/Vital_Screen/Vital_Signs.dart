import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:soul/Components/vitalSigns.dart';
import 'package:soul/Entities/vital.dart';
import 'package:soul/constants.dart';
import 'package:soul/Components/background.dart';

import '../../Request/requests.dart';

class Vitals extends StatefulWidget {
  @override
  String? readid;
  List<Vital>? VitalsResults;
  _VitalsState createState() => _VitalsState();
  Vitals({this.readid, this.VitalsResults});
}

class _VitalsState extends State<Vitals> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getfacilityname();
      getpatientid();
      getEncounterid();
      getfacilityid();
      getVitalsDetails();

      // You can also show your dialog here
      //_showDialog();
    });
  }
  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
        () => 'Data Loaded',
  );
  Vital? v;
  String? encounterid;
  String? facilityid;
  final _formKey = GlobalKey<FormState>();
  DateTime? _date;
  Duration initialTimer = new Duration();
  String? patientid, facilityname;
  String? date, time;
  String temp = "123",
      res = " 123  ",
      bs = " 123  ",
      bd = "123",
      hight = " 123",
      weight = "123 ",
      puls = " 123  ",
      bmi = "123   ";
  bool isempty = false;
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    List<VitalS> vitals = [
      VitalS(
        text1: 'Temperature:',
        text2: temp,
      ),
      VitalS(
        text1: 'Respiratory Rate:',
        text2: res,
      ),
      VitalS(
        text1: 'BP-Systolic:',
        text2: bs,
      ),
      VitalS(
        text1: 'BP-Diastolic:',
        text2: bd,
      ),
      VitalS(
        text1: 'Height:',
        text2: hight,
      ),
      VitalS(
        text1: 'Weight:',
        text2: weight,
      ),
      VitalS(text1: 'Pulse:', text2: puls),
      VitalS(
        text1: 'BMI:',
        text2: bmi,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vital Signs',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF056195), // Set title text color
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF056195), // Set icon color
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white, // Set app bar background color
        elevation: 0, // Remove app bar shadow
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<String>(
          future: _calculation, // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Loading state
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF056195), // Adjust color as needed
                ),
              );
            } else if (snapshot.hasError) {
              // Error state
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF056195), // Set text color
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              // Data available state
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Text(
                          "Date:",
                          style: TextStyle(
                            color: Color(0xFF056195), // Set text color
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 5),
                        date != null
                            ? Text(
                          date!,
                          style: TextStyle(
                            color: Color(0xFF056195), // Set text color
                            fontSize: 18,
                          ),
                        )
                            : Text(
                          " there is no data",
                          style: TextStyle(
                            color: Color(0xFF056195), // Set text color
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    isempty == false
                        ? GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 1.5,
                      ),
                      shrinkWrap: true,
                      itemCount: vitals.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Color(0xFF056195), // Set border color
                              width: 1.0, // Set border width
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _getIconForText(vitals[index].text1.toString()),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        vitals[index].text1.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF056195), // Set text color
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      color: Color(0xFF056195), // Set icon color
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        vitals[index].text2.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF056195), // Set text color
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Container(
                      child: Text(
                        "There is no data",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF056195), // Set text color
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Awaiting result state
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF056195), // Adjust color as needed
                ),
              );
            }
          },
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

  Future<void> getVitalsDetails() async {
    BuildContext context;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");

    req.GetVitalSignReadDetails(
            facilityname!, patientid!, encounterid, widget.readid!, s)
        .then((value) {
      print("vvvv" + value.toString());
      setState(() {
        if (value != null) {
          v = value;
          hight = v!.encounteR_PATIENT_HEIGHT!;
          weight = v!.encounteR_PATIENT_WEIGHT!;
          res = v!.reaD_RES_RATE!;
          puls = v!.reaD_PULSE!;
          temp = v!.reaD_TEMP!;
          date = v!.reaD_DATE!.substring(0, 10);
          bd = v!.reaD_BP_DIASTOLIC!;
          bs = v!.reaD_BP_SYSTOLIC!;
          bmi = v!.bmi!;
          print("yhh" + v.toString());
        } else {
          isempty = true;
        }
      });
    });

    //print(clinicName.toString());
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Vital Signs"),
      content: Text("There is no reads."),
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

  Future<String> getEncounterid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    encounterid = sh.getString('defaultencounter');
    return encounterid!;
  }

  Future<String> getfacilityid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    facilityid = sh.getString('facilityid');
    return facilityid!;
  }
}
