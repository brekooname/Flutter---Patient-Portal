import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Entities/patientEncounters.dart';
import 'package:soul/Screens/FamilyMember/encouters.dart';
import 'package:soul/Screens/FamilyMember/familymember.dart';
// import 'tabs/pastTab.dart';
// import 'tabs/upComingTab.dart';
import 'package:soul/constants.dart';

import '../../Entities/familyMem.dart';
import '../../Request/requests.dart';

class Switch1 extends StatefulWidget {
  @override
  _Switch1 createState() => _Switch1();
}

class _Switch1 extends State<Switch1> {
  String? loginpatientid, patientid, facilityname;
  List<FamilyMem> family = [];
  List<PatientEncounters> patientencounter = [];
  String? facilityid;
  String? encounterid;
  @override
  void initState() {
    getfacilityname();
    getpatientid();
    getfacilityid();
    getencounterid();
    GetEncounters();
    getMembers();

    print(family.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: queryData.size.height * 0.08,
              automaticallyImplyLeading: false,
              title: Center(
                  child: Text("Switch Page",
                      style: TextStyle(
                        fontSize: 25,
                      ))),
              backgroundColor: kPrimaryColor,
              // bottom: const TabBar(
              //   labelColor: Colors.white,

              //   tabs: tabs,
              // ),
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
          unselectedLabelColor: kPrimaryColor,
          labelColor: kPrimarySecColor,
          labelPadding: EdgeInsets.symmetric(horizontal: 10),
          tabs: [
            Tab(
              child: Align(
                child: Text('Family Member',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
                alignment: Alignment.centerLeft,
              ),
            ),
            Tab(
              child: Align(
                child: Text('Encounters',
                    textAlign: TextAlign.end,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
                alignment: Alignment.centerRight,
              ),
            ),
          ]));

  Widget _tabsHolder() => Expanded(
        child: TabBarView(children: [
          FamilyMember(
            family: family,
            loginpatientid: patientid,
            Encounterid: encounterid,
          ),
          Encounters(
            encounter: patientencounter,
            loginpatientid: patientid,
            Encounterid: encounterid,
          ),
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

  Future<List<FamilyMem>> getMembers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");

    req.GetfamilyMember(facilityname!, patientid!, s).then((value) {
      setState(() {
 value.forEach((item) => family.add(item));

        print(family.toString());
      });

      // print("Clinics1"+clinics1.toString());
      return family;
    });

    //print(clinicName.toString());
    return family;
  }

  Future<List<PatientEncounters>> GetEncounters() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");

    req.GetPatientEncounters(facilityid!, patientid!, s).then((value) {
      setState(() {
 value.forEach((item) => patientencounter.add(item));

        print(patientencounter.toString());
      });

      // print("Clinics1"+clinics1.toString());
      return patientencounter;
    });

    //print(clinicName.toString());
    return patientencounter;
  }

  Future<String> getfacilityid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    facilityid = sh.getString('facilityid');
    return facilityid!;
  }

  Future<String> getencounterid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    encounterid = sh.getString('logindefaultencounter');
    return encounterid!;
  }
}
