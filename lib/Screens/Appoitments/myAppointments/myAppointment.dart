import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Entities/previousAppointment.dart';
import 'package:soul/Screens/Appoitments/commonListItem.dart';
import 'package:soul/Screens/MainPage_Screen/main_page.dart';

import '../../../Request/requests.dart';
import 'tabs/pastTab.dart';
import 'tabs/upComingTab.dart';
import 'package:soul/constants.dart';
import 'package:soul/Screens/Appoitments/searchAppointment.dart';

class MyAppointments extends StatefulWidget {
  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  @override
  void initState() {
    super.initState();
    getfacilityname();
    getpatientid();
    getPreviousApp();
    getUpComingApp();
  }

  List<previousAppointment> previous = [];
  List<CommonListItem> common = [];
  List<previousAppointment> upComing = [];
  List<CommonListItem> common2 = [];
  String? patientid, facilityname;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(elevation:4,
          toolbarHeight: queryData.size.height * 0.08,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage('', '', false)),
              );
            },
            child: Icon(Icons.arrow_back,size: 30,color: kPrimaryColor,),
          ),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "My Appointments",
                style: TextStyle(        color: Color(0xFF056195),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _tabBarContainer(),
                _tabsHolder(), // Ensure _tabsHolder() is not already wrapped with Expanded
                _bookAppointmentButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleHeader(MediaQueryData queryData) => Container(
        height: queryData.size.height * 0.08,
        // color: kPrimaryColor,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        padding: EdgeInsets.only(bottom: 10, top: 10, left: 100),
        alignment: Alignment.topLeft,
        child: Text(
          'My Apoointment',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      );

  Widget _tabBarContainer() => Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.3, color: kPrimaryLightColor),
      ),
    ),
    child: TabBar(
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 3.0, color: kPrimaryColor),
      ),
      unselectedLabelColor: kPrimaryLightColor,
      labelColor: kPrimaryColor,
      labelPadding: EdgeInsets.symmetric(horizontal: 10),
      tabs: [
        Tab(
          child: Text(
            'Up Coming',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
        ),
        Tab(
          child: Text(
            'Past',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
  Widget _tabsHolder() => Expanded(
        child: TabBarView(children: [
          UpComingTab(upCommingFuture: getUpComingApp())
,
          PastTab(
            past: common,
          ),
        ]),
      );

  Widget _bookAppointmentButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),  // Spacing from the sides for a clean look
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchAppointment("", "", ""),),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          onPrimary: Colors.white,  // Text color
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),  // More padding for a larger button feel
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),  // Soften the corners
          ),
          elevation: 3,  // Subtle elevation
          shadowColor: Colors.grey.withOpacity(0.3),  // Slight shadow for depth
        ),
        child: Text('Book Appointment'),
      ),
    );
  }
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
  Future<List<CommonListItem>> getPreviousApp() async {
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    String d;

    var value = await req.GetPreviousAppointments(facilityname, patientid, s);
    value.forEach((item) => previous.add(item));
    print("in111 prev app " + previous.toString());
    for (var i = 0; i < previous.length; i++) {
      print("in1Name" + previous[i].appointmenT_SOURCE!);
      d = previous[i].date!.substring(0, 10);
      common.add(new CommonListItem(
          firstTitle: d,
          thirdTitle: previous[i].appointmenT_SOURCE!,
          fourthTitle: "    "));
    }

    return common;
  }

  Future<List<CommonListItem>> getUpComingApp() async {
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    String d;

    var value = await req.GetUpcomingAppointments(facilityname, patientid, s);
    value.forEach((item) => upComing.add(item));
    // print("in111" + upComing.toString());

    for (var i = 0; i < upComing.length; i++) {
      // print("in123 ddep " + upComing[i].depDescription.toString());
      // print("in1Name" + upComing[i].appointmenT_SOURCE!);
      DateTime parsedDate = DateTime.parse(upComing[i].date!);
        d = DateFormat('yyyy-MM-dd – HH:mm').format(parsedDate);

      common2.add(new CommonListItem(
          firstTitle: d,
          thirdTitle: upComing[i].appointmenT_SOURCE!,
          fourthTitle:upComing[i].depDescription));
    }

    return common2;
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
}
