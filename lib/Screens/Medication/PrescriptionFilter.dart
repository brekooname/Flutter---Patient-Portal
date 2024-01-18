import 'package:flutter/material.dart';
import 'package:soul/Entities/prescription.dart';
import 'package:soul/Request/requests.dart';
import 'package:soul/Screens/Appoitments/commonListItem.dart';
import 'package:soul/Screens/Medication/presc.dart';
import 'package:soul/constants.dart';
import 'package:soul/Components/addButton.dart';
import 'package:soul/Components/text_field_container.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PrescriptionFilter extends StatefulWidget {
  @override
  _PrescriptionFilter createState() => _PrescriptionFilter();
}

class _PrescriptionFilter extends State<PrescriptionFilter> {
  DateTime? _fromdate;
  String? PresId = "1";
  String? PresDates = "2";
  String? encounterid;
  bool load = false;
  DateTime? _todate;
  String? lab, test, fromdate, todate;
  final _formKey = GlobalKey<FormState>();
  bool showResult = false;
  dynamic apiresult;
  Container? c1;
  bool showContainer = false;
  List<Prescription> prescrip = [];
  // new Prescription(
  //   MedicationDescription: "t",
  //   OrderedBy: "t",
  //   OrderedDate: "t",
  //   EncounterId: "",
  //   MedicationInstruction: "t",
  //   PrescreptionId: "t")
  List<CommonListItem> common2 = [];
  //TextEditingController testNameController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  //TextEditingController labNameController = TextEditingController();

  @override
  void initState() {
    getpatientid();
    getfacilityname();
    getEncounterid();
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

  String? facilityname, patientid;
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    //final sharedprefs = SharedPreferences.getInstance();
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [ _buildDateInput('From', fromDateController, _fromdate),
                          _buildDateInput('To', toDateController, _todate),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                              onTap: () async {
                                if (_fromdate != null && _todate != null) {


                                  print(_fromdate);
                                  print(_todate);
                                  await getPrescription();


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
                          ), ],),

                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: common2.length,  // `common` is the list where you store fetched medications.
                            itemBuilder: (context, index) {
                              return common2[index];
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _textLabel(String label) => Text(label,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 18.0, color: Colors.black));

// get  prescrption list
  Future<void> getPrescription() async {
    if (_fromdate != null && _todate != null) {
      print("requestooooooooo");

      Requests req = new Requests();
      print("requestooooooooo");
      SharedPreferences pref = await SharedPreferences.getInstance();
      String s = pref.getString("token")!;
      String d;
      String formattedFromDate = DateFormat('yyyy-MM-dd').format(_fromdate!);

      String formattedToDate = DateFormat('yyyy-MM-dd').format(_todate!);

      await req.Getprescriptions(context,
          facilityname, patientid, encounterid, s, formattedFromDate, formattedToDate)
          .then((value) {
        setState(() {
          if (value != null) {
            print("object" + value.toString());
            prescrip.clear();
            common2.clear();
            SetFromdate();
            SetTodate();
            value.forEach((item) => prescrip.add(item));

            for (var i = 0; i < prescrip.length; i++) {
              common2.add(new CommonListItem(
                  thirdTitle: prescrip[i].OrderedDate!.substring(0, 10),
                  PageTYpe: "PreSc",
                  Prescid: prescrip[i].PrescreptionId,
                  thirdTitleIcon: Icons.info_rounded));
            }
            print(common2.toList());
            // list of prescid and list of dates
            PresId = "";
            PresDates = "";
            common2.forEach((element) {
              print(element.Prescid);
              print(element.thirdTitle);
              PresId =
                  (PresId ?? "") + (element.Prescid?.toString() ?? "") + ",";
              PresDates = (PresDates ?? "") +
                  (element.thirdTitle?.toString() ?? "") +
                  ",";
            });
            SetPresId();
            SetPresDates();

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => Prescrip(prescription: common2)),
            // );
          } else {
            showAlertDialog2(context);
          }
        });
      });
      // Return the list after the setState function

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

  Future<void> SetFromdate() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String formattedFromDate = DateFormat('yyyy-MM-dd').format(_fromdate!);

    sh.setString('Fromdate', formattedFromDate!);
  }

  Future<void> SetTodate() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String formattedToDate = DateFormat('yyyy-MM-dd').format(_todate!);

    sh.setString('Todate', formattedToDate!);
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
    encounterid = sh.getString('defaultencounter');
    return encounterid!;
  }

  Future<void> SetPresId() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('PresId', PresId!);
  }

  Future<void> SetPresDates() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('PresDates', PresDates!);
  }

 }
