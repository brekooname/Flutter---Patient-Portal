import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Components/cards.dart';
import 'package:soul/Components/circular_image.dart';
import 'package:soul/Screens/ContactUs/contactUs.dart';
import 'package:soul/Screens/Login_Screen/Login.dart';
import 'package:soul/Screens/Setting/setting.dart';
import 'package:soul/constants.dart';

import '../../Components/appointmentCard.dart';
import '../../Components/serviceCard.dart';
import '../../sizeConfig.dart';
import '../Appoitments/myAppointments/myAppointment.dart';
import '../Appoitments/searchAppointment.dart';
import '../FamilyMember/switch.dart';
import '../FamilyMember/switch1.dart';
import '../Insurance/Insurance2.dart';
import '../Lab_Screen/lab.dart';
import '../Medication/medication.dart';
import '../MyDoctors/myDoctors.dart';
import '../Profile_Screen/Profile_Screen.dart';
import '../Radiology/radiology.dart';
import '../Vital_Screen/VitalFilter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
// String PatientId = '';
// HomePage(this.PatientId);
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool flag = true;

  String? currentUser, uid;
  Cards? card;

  // String facilityname;
  // String patientid;
  String? username;
  String? facilityname;
  late AnimationController _controller;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;
  late Animation<double>? _animation;
  late Animation<double>? _animation2;
  late Animation<double>? _animation3;
  late Animation<double>? _animation4;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    //===================================================================
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation2 = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.bounceInOut),
    );
    _controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.reverse();
      }
    });
    //===================================================================
    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation3 = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(parent: _controller3, curve: Curves.bounceInOut),
    );
    _controller3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller3.reverse();
      }
    });
//==============================================================
    _controller4 = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation4 = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(parent: _controller4, curve: Curves.bounceInOut),
    );
    _controller4.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller4.reverse();
      }
    });

    initializeState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  Future<void> initializeState() async {
    await getfacilityname();
    await getUsrname();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQueryData queryData;
    // queryData = MediaQuery.of(context);
    Size screenSize = MediaQuery.of(context).size; // Get screen size
    double width = screenSize.width;
    double height = screenSize.height;
     double maxWidth = 1200.0; // Maximum width for the content

    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        drawer: Container(
          width: SizeConfig.safeBlockHorizontal! * 45,
          child: Drawer(
            width: width * (width > 600 ? 0.3 : 0.8), // 30% of screen width for wider screens, 80% for narrower
            child: Container(
              color: Colors.white, // Background color of the entire drawer
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(


                          height: SizeConfig.safeBlockVertical! * 17,
                          child: DrawerHeader(
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: Duration(seconds: 1),
                                          transitionsBuilder: (BuildContext context,
                                              Animation<double> animation,
                                              Animation<double> secAnimation,
                                              Widget child) {
                                            animation =
                                                CurvedAnimation(parent: animation, curve: Curves.easeIn);
                                            return ScaleTransition(
                                              scale: animation,
                                              child: child,
                                              alignment: Alignment.center,
                                            );
                                          },
                                          pageBuilder: (BuildContext context, Animation<double> animation,
                                              Animation<double> secAnimation) {
                                            return Profile( );
                                          },
                                        ),
                                      );
                                    },
                                    child: CirculerImage(
                                      imageName: 'profile.png',
                                      width: 55.0,
                                      height: 55.0,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$username',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            letterSpacing: 1,
                                            overflow: TextOverflow.ellipsis, // Prevents overflow

                                          ),
                                        ),
                                        SizedBox(height: 11),
                                        Text(
                                          '$facilityname Hospital',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontFamily: 'calibri-regular',
                                          ),
                                          overflow: TextOverflow.ellipsis, // Prevents overflow

                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(
                          color: Colors.grey,
                        ),

                        buildCustomListTile(
                            icon: Icons.credit_score_outlined,
                            label: "Insurance",
                            onTap: () {
                              _controller2.forward();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Insurance2()));
                            }),
                        SizedBox(height: 10),

                        buildCustomListTile(
                            icon: Icons.local_hospital_outlined,
                            label: "Doctors",
                            onTap: () {
                              _controller2.forward();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyDoctors()));
                            }),
                        SizedBox(height: 10),

                        buildCustomListTile(
                            icon: Icons.family_restroom_outlined,
                            label: "Family Members",
                            onTap: () {
                              _controller2.forward();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Switch12()));
                            }),
                        SizedBox(height: 10),
                        buildCustomListTile(
                            icon: Icons.star_rate_outlined,
                            label: "Rating",
                            onTap: () {
                              _controller.forward();
                              _showRatingAppDialog();
                            }),
                        SizedBox(height: 10),
                        buildCustomListTile(
                            icon: Icons.phone_outlined,
                            label: "Contact Us",
                            onTap: () {
                              _controller2.forward();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactUsPage()));
                            }),

                        // buildCustomListTile(
                        //     icon: Icons.settings,
                        //     label: "Setting",
                        //     onTap: () {
                        //       _controller3.forward();
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => Setting()));
                        //     }),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  ScaleTransition(
                    scale: _animation4!,
                    child: buildCustomListTile(
                      icon: Icons.lock_outline,
                      label: "Logout",
                      onTap: () async {
                        _controller4.forward();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0), // Rounded corners for the dialog
                              ),
                              elevation: 5.0,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.lock_outline,
                                      size: 40,
                                      color: kPrimaryColor,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Are you sure you want to logout?',
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey[700]),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                side: BorderSide.none,
                                              ),
                                            ),
                                          ),
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                side: BorderSide.none,
                                              ),
                                            ),
                                          ),
                                          child: Text('Logout'),
                                          onPressed: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.remove('patientid');
                                            await prefs.remove('facilityname');
                                            await prefs.remove('userid');
                                            await Future.delayed(
                                                Duration(seconds: 1));
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    Login(),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  const begin = 0.0;
                                                  const end = 1.0;
                                                  const curve =
                                                      Curves.easeInOut;
                                                  var tween = Tween(
                                                          begin: begin,
                                                          end: end)
                                                      .chain(CurveTween(
                                                          curve: curve));
                                                  var opacityAnimation =
                                                      animation.drive(tween);
                                                  return FadeTransition(
                                                      opacity: opacityAnimation,
                                                      child: child);
                                                },
                                              ),
                                              (Route route) => false,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      trailingIcon: null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.1), // 10% of screen height
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[100]!, // A very light gray
                  Colors.grey[50]!, // Almost white but adds depth
                ],
              ),
            ),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent, // Make AppBar background transparent
              foregroundColor: Colors.black,

              centerTitle: true,
              // This ensures that the title is centered
              title: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    // Image
                    Expanded(
                      child: Center(
                        child: Container(
                          width: SizeConfig.safeBlockHorizontal! * 22,
                          height: SizeConfig.safeBlockVertical! * 7,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/images/gg2.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Notification Icon
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.notifications_none_outlined,
                        size: 30,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),

              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width > maxWidth ? 20.0 : screenSize.width * 0.05,
                vertical: 20.0,
              ),            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey[100]!, // A very light gray
                    Colors.grey[50]!, // Almost white but adds depth
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ' + '$username',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.04, // Dynamic font size based on screen width
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'How Are You Doing Today?',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 30,
                            color: kPrimaryColor,
                          ),
                          Text(
                            '$facilityname Hospital',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: 'calibri-regular',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.maxFinite, // Adjust as needed
                      height: 210, // Increased to accommodate search bar
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/images/findDocLand.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            ' Book and Schedule \n with nearest doctor',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(kPrimaryColor.withOpacity(0.88)),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            onPressed: () {
                              // Handle button press
                            },
                            child: Text(
                              'Find Nearby',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 24.0,right: 24.0),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: Colors.white,
                  //       hintText: 'Search...',
                  //       hintStyle: TextStyle(color: Colors.grey.shade400),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(25),
                  //         borderSide:BorderSide(color: Colors.white60.withOpacity(0.1)) ,
                  //       ),
                  //       suffixIcon: Icon(Icons.search, color: kPrimaryColor),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  _buildSectionHeader("Appointments"),
                  SizedBox(height: 20),
                  Container(
                    height: height * 0.2, // 20% of screen height
                    child: ListView.builder(
                      itemCount: 2, // Number of items in your list
                      scrollDirection: Axis.horizontal,

                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return AppointmentCard(
                            app: MyAppointments(),
                            text1: "My appointments",
                            text3: "928424_annual_appointment_calendar_day_month_icon.png",
                            color: kPrimaryColor,
                          );
                        } else if(index==1){
                         return AppointmentCard(
                            app: SearchAppointment("", "", ""),
                            text1: "Book Appointment",
                            text2: "  ",
                            text3: "6351901_appointment_calendar_checklist_date_event_icon.png",
                            color: kPrimaryColor.withOpacity(0.8),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 30),


                  _buildSectionHeader("Medical Services"),
                  SizedBox(height: 20),
                  Container(
                    height: height * 0.2, // 20% of screen height
                    child: ListView.builder(
                      itemCount: 6, // Number of items in your list
                      scrollDirection: Axis.horizontal,

                      itemBuilder: (BuildContext context, int index) {
                  if(index==0){
                    return _buildServiceCard(
                        ServiceCard(
                          text1: "Vital signs",
                          text2: "    ",
                          text3: "7436264_vital sign_medical_heart_heartbeat_cardiology_icon.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VitalFilter()),
                            );
                          },
                        )
                    );
                  }
                  else if(index==1){
                    return _buildServiceCard(
                      ServiceCard(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LabResult()),
                          );
                        },
                        text1: "Laboratory Results",
                        text2: " ",
                        text3: "4851514_chemistry_education_lab_laboratory_research_icon.png",
                      ),
                    );
                  }
                  // else if(index==2){
                  //   return _buildServiceCard(
                  //     ServiceCard(
                  //       text1: "Insurance",
                  //       text2: "   ",
                  //       text3: "7830673_insurance_card_icon.png",
                  //       press: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => Insurance2()),
                  //         );
                  //       },
                  //     ),
                  //   );
                  // }
                  else if(index==2){
                    return _buildServiceCard(
                      ServiceCard(
                        text1: "Radiology Reports",
                        text2: "      ",
                        text3: "7436272_chest_x-ray_medical_health_anatomical_icon.png",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Radiology()),
                          );
                        },
                      ),
                    );
                  }
                  // else if(index==3){
                  //   return _buildServiceCard(
                  //     ServiceCard(
                  //       text1: "My Doctors",
                  //       text2: "      ",
                  //       text3: "6007912_doctor_job_surgeon_user_icon.png",
                  //       press: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => MyDoctors()),
                  //         );
                  //       },
                  //     ),
                  //   );
                  // }
                  else if(index==3){
                    return   _buildServiceCard(
                      ServiceCard(
                        text1: "Medication",
                        text3: "6989154_pill_pharmacy_medicine_medical_painkiller_icon.png",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Medication1()),
                          );
                        },
                      ),
                    );
                  }

                      },
                    ),
                  ),

                    ],
                  ),


              ),
          ),
          ),
        ),

    );
  }
  Widget _buildServiceCard(ServiceCard card) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: card,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 24.0, // Made font size slightly larger
            fontWeight: FontWeight.bold,
            fontFamily: 'calibri-regular',
          ),
        ),
        Divider(color: kPrimaryColor.withOpacity(0.7), thickness: 2),
      ],
    );
  }

  Widget _buildServiceRow(
      {required Widget firstCard, required Widget secondCard}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          firstCard,
          secondCard,
        ],
      ),
    );
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      title: Text(
        "Rate Our App",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
      message: Text(
        'Your feedback is valuable to us. Please take a moment to rate this app and share your thoughts.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      ),
      starColor: kPrimaryColor,
      image: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Image.asset(
          "assets/images/PngItem_144683.png",
          height: 80,
          fit: BoxFit.scaleDown,
        ),
      ),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          Container();
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }

  Widget buildCustomListTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    IconData? trailingIcon = Icons.chevron_right,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30.0,
        color: kPrimaryColor,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: Color(0xFF322825),
          fontSize: 14,
          letterSpacing: 1,
        ),
      ),
      trailing: trailingIcon != null
          ? Icon(trailingIcon, color: kPrimaryColor)
          : null,
      onTap: onTap,
    );
  }

  // Future<String> getpatientid() async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   patientid = sh.getString('patientid');
  //   return patientid;
  // }

  // Future<void> setpatientid() async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   sh.setString('loginpatientid', patientid);
  // }

  // Future<void> setnewpatientid() async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   sh.setString('patientid', widget.PatientId);
  // }
  Future<String> getfacilityname() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      facilityname = sh.getString('facilityname');
    });

    return facilityname!;
  }

  Future<String> getUsrname() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      username = sh.getString('username')!.toUpperCase();
    });

    return username!;
  }
}
