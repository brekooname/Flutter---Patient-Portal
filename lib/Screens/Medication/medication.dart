import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Entities/ListofMedicationGroup.dart';
import 'package:soul/Entities/prescription.dart';
import 'package:soul/Screens/Medication/MedicationFilter.dart';
import 'package:soul/Screens/Medication/PrescriptionFilter.dart';
// import 'tabs/pastTab.dart';
// import 'tabs/upComingTab.dart';
import 'package:soul/constants.dart';

import '../Appoitments/commonListItem.dart';
import '../MainPage_Screen/main_page.dart';

class Medication1 extends StatefulWidget {
  @override
  _Medication createState() => _Medication();
}

class _Medication extends State<Medication1> {
  List<ListofMedicationGroup> medication = [];
  List<CommonListItem> common = [];
  List<Prescription> prescrip = [];
  List<CommonListItem> common2 = [];
  String? encounterid;
  String? facilityid;
  String? facilityname, patientid;
  @override
  void initState() {
    super.initState();
    getfacilityname();
    getEncounterid();
    getfacilityid();
    getpatientid();
    //getMedication();
    // getPrescription();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return DefaultTabController(
        length: 1,
        child: Scaffold(
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
                  "Medication",
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
            body: SafeArea(
              child: Container(
                // padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //_titleHeader(queryData),
                      // searchTextField(),
                      SizedBox(
                        height: 30,
                      ),
                      _tabBarContainer(),
                      _tabsHolder(),
                      // _bookAppointmentButton()
                    ]),
              ),
            )));
  }

  Widget _titleHeader(MediaQueryData queryData) => Container(
        height: queryData.size.height * 0.08,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        padding: EdgeInsets.only(bottom: 10, top: 30, left: 60),
        alignment: Alignment.topLeft,
        child: Text(
          'Medication',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      );

  Widget _tabBarContainer() => Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.3, color: kPrimaryLightColor),
        ),
      ),
      child: TabBar(
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: kPrimaryColor)),
          unselectedLabelColor: kPrimaryLightColor,
          labelColor: kPrimaryColor,
          labelPadding: EdgeInsets.symmetric(horizontal: 10),
          tabs: [
            Tab(
              child: Align(
                child: Text('Medication',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
                alignment: Alignment.centerLeft,
              ),
            ),
            // Tab(
            //   child: Align(
            //     child: Text('Perscriptions',
            //         textAlign: TextAlign.end,
            //         style:
            //             TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
            //     alignment: Alignment.centerRight,
            //   ),
            // ),
          ]));

  Widget _tabsHolder() => Expanded(
        child: TabBarView(children: [
          // PastMedication(medication: common),
          // Prescrip(prescription: common2),
          MedicationFilter(),
          // PrescriptionFilter(),
        ]),
      );

  Widget searchTextField() {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: _textField(),
      ),
    );
  }

  TextField _textField() => TextField(
      autofocus: false,
      style: TextStyle(color: Colors.black, fontSize: 18),
      decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon: Icon(
            Icons.search_outlined,
            color: Colors.black.withOpacity(0.3),
          ),
          contentPadding:
              EdgeInsets.only(left: 5, bottom: 16, top: 16, right: 15),
          hintStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.3)),
          hintText: 'Search'));
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
