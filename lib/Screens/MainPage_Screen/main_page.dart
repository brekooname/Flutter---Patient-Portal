import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Screens/Insurance/Insurance2.dart';
import 'package:soul/Screens/MyDoctors/myDoctors.dart';
import 'package:soul/constants.dart';
import 'package:soul/Screens/Home_Screen/home.dart';
import 'package:soul/Components/placeholder_widget.dart';


import '../../Components/circular_image.dart';
import '../FamilyMember/switch1.dart';
import '../Profile_Screen/Profile_Screen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
  String PatientId = '';
  String encounterId = '';
  bool reset;

  MainPage(this.PatientId, this.encounterId, this.reset);
}

class _MainPageState extends State<MainPage> {
  void initState() {
    super.initState();
    () async {
      await getpreference();
      print("after preference");
      print(widget.PatientId);
      print(widget.encounterId);

      if (widget.PatientId != '') {
        if (widget.reset == true) {
          // reset
          // no new encounter
          print(widget.reset);
          loginpatientid = getoldpatientid();
          setnewpatientidforreset(loginpatientid!);

          loginencountertid = getoldencounter();
          //print("reset"+encounterId);
          if (loginencountertid == '') {
            encounterId = getencounterId() as String?;
            setoldencounterid(encounterId!);
            setnewencounteridforreset(encounterId!);
          } else {
            setnewencounteridforreset(loginencountertid!);
          }
        } else {
          // switch
          // may be come from another switch
          loginpatientid = getoldpatientid();

          if (loginpatientid == '') // which in defaut from login
          {
            patientid = getpatientid() as String?;
            setoldpatientid(patientid!);
          } else {
            setoldpatientid(loginpatientid!);
          }
          // not the first
          // save the patient which switched

          setnewpatientid();

          // may be come from another switch
          loginencountertid = getoldencounter();

          if (loginencountertid == '') {
            // get from login phase
            encounterId = getencounterId() as String?;
            setoldencounterid(encounterId!);
            setnewencounteridforswitch();
          } else {
            setoldencounterid(loginencountertid!);
            setnewencounteridforswitch();
          }
        }
      }
    }();
  }

  Future<SharedPreferences> sh = SharedPreferences.getInstance();
  bool flag = true;
  String? patientid;
  String? loginencountertid;
  String? loginpatientid;
  int _currentIndex = 0;
  SharedPreferences? pref;
  String? facilityname;
  String? username;
  String? encounterId;
  String? pId;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [
    PlaceholderWidget(HomePage()),
    PlaceholderWidget(Switch12()),
    PlaceholderWidget(MyDoctors()),
    PlaceholderWidget(Insurance2()),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _children[_currentIndex],
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     onTabTapped(0);
        //
        //   },
        //   child:  Icon(Icons.home,color: Colors.white),
        //   backgroundColor: Colors.blueGrey,
        //   elevation: 1.0,
        // ),
        // bottomNavigationBar:Container(
        //   decoration: BoxDecoration(
        //     border: Border(
        //       top: BorderSide(color: Colors.white, width: 1), // White border
        //     ),
        //   ),
        //   child: BottomAppBar(
        //     color: Color(0xFF056195).withOpacity(0.9), // Darker shade of blue
        //     elevation: 8.0,
        //     shape: CircularNotchedRectangle(),
        //     notchMargin: 6.0,
        //     child: Row(
        //       mainAxisSize: MainAxisSize.max,
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: <Widget>[
        //
        //         IconButton(
        //           icon: Icon(Icons.family_restroom),
        //           color: _currentIndex == 1 ? Color(0xFFe6d3d3) : Colors.grey[600],
        //           onPressed: () => onTabTapped(1),
        //         ),
        //         SizedBox(width: 48), // Space for the floating action button
        //         IconButton(
        //           icon:Icon(Icons.local_hospital_outlined),
        //           color: _currentIndex == 2 ? Color(0xFFe6d3d3) : Colors.grey[600],
        //           onPressed: () => onTabTapped(2),
        //         ),
        //         IconButton(
        //           icon: Icon(Icons.credit_score_outlined),
        //           color: _currentIndex == 3 ? Color(0xFFe6d3d3) : Colors.grey[600],
        //           onPressed: () => onTabTapped(3),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }


  Future<String> getpatientid() async {
     SharedPreferences sh = await SharedPreferences.getInstance();
    patientid = pref!.getString('patientid');
    return patientid!;
  }

  Future<String> getencounterId() async {
     SharedPreferences sh = await SharedPreferences.getInstance();
    encounterId = pref!.getString('defaultencounter');
    return encounterId!;
  }

  void setnewencounterid() {
    //SharedPreferences sh = await SharedPreferences.getInstance();
    pref!.setString('defaultencounter', widget.encounterId);
  }

  Future<void> getpreference() async {
    pref = await sh;
  }

  Future<void> setnewencounteridforreset(String encounterid) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    pref!.setString('defaultencounter', encounterid);
  }

  Future<void> setoldencounterid(String encounterid) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    pref!.setString('logindefaultencounter', encounterid);
  }

  String getoldencounter() {
    // which saved in new
    //SharedPreferences sh = await SharedPreferences.getInstance();
    loginencountertid = pref!.getString('logindefaultencounter');
    if (loginencountertid == null) loginencountertid = '';
    return loginencountertid!;
  }

  void setoldpatientid(String patientid) {
    //SharedPreferences sh = await SharedPreferences.getInstance();
    pref!.setString('loginpatientid', patientid);
  }

  void setnewpatientidforreset(String patientid) {
    // SharedPreferences sh = await SharedPreferences.getInstance();
    pref!.setString('patientid', patientid);
  }

  void setnewencounteridforswitch() {
    //SharedPreferences sh = await SharedPreferences.getInstance();
    pref!.setString('defaultencounter', widget.encounterId);
  }

  void setnewpatientid() {
    // SharedPreferences sh = await SharedPreferences.getInstance();
    pref!.setString('patientid', widget.PatientId);
  }

  String getoldpatientid() {
    // SharedPreferences sh = await SharedPreferences.getInstance();
    loginpatientid = pref!.getString('loginpatientid');
    if (loginpatientid == null) loginpatientid = '';
    return loginpatientid!;
  }
}
