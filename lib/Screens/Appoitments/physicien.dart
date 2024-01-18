import 'package:flutter/material.dart';
import 'package:soul/Screens/Appoitments/book_appointment_tab2.dart';
import 'package:soul/constants.dart';

import 'data/sampleData.dart';

class BookAppointment extends StatefulWidget {
  final dr;

  BookAppointment({this.dr});

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _lstData = appointmentSlots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                child: DefaultTabController(
                  length: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      children: [
                        Wrap(
                          runSpacing: 10,
                          children: [
                            //_doctorInfo(),
                            // _slotListView(),
                            //_bookBtn(),
                            _tabView(),
                          ],
                        ),
                        Expanded(child: _tabBarView())
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Widget _doctorInfo() => DoctorListItem('assets/images/profile.png',
  //     "Dr. Julien More", "Psychiatrist", 5, 160, 100, true, true);

  Widget _bookBtn() => Container(
        width: MediaQuery.of(context).size.width,
        child: elevatedButton(
            text: 'Book',
            color: kPrimaryColor,
            onPress: () {
              // context.navigateToScreen(Payment());
            },
            fontWeight: FontWeight.w500,
            textSize: 16),
      );

  Widget _tabView() => TabBar(
        labelPadding: EdgeInsets.all(10),
        labelColor: kPrimaryColor,
        unselectedLabelColor: Colors.black,
        tabs: <Widget>[
          Text(
            'Doctor',
          ),
          // Text(
          //   'Clinic',
          // ),
        ],
      );

  Widget _tabBarView() => Container(
      padding: EdgeInsets.only(top: 10),
      child: TabBarView(children: [
        BookAppointmentTab2(),
        //BookAppointmentTab2(),
      ]));

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
}
