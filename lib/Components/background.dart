//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:soul/Entities/vital.dart';
import 'package:soul/Screens/Vital_Screen/VitalList.dart';
import 'package:soul/constants.dart';

import 'package:soul/Components/placeholder_widget.dart';


class Background extends StatefulWidget {
  final title;
  final child;
  final List<Vital>? listresults;
  Background(
      {this.title,
      this.child,
      this.listresults,
      BottomAppBar? bottomNavigationBar});

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [
    PlaceholderWidget(Container()),
    PlaceholderWidget(Container()),
    PlaceholderWidget(Container()),
  ];
  @override
  Widget build(BuildContext context) {
    MediaQueryData size1;
    size1 = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size1.size.height * 0.08,
              padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                // bottomRight: Radius.circular(20)
                // )
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VitalList(VitalResults: widget.listresults!)),
                      );
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white, // add custom icons also
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar:// new

        //       BottomAppBar(
        //   color: kPrimaryColor,
        //   shape: CircularNotchedRectangle(),
        //   child: BottomNavigationBar(
        //     selectedItemColor: kPrimaryColor.withOpacity(0.5),
        //     type: BottomNavigationBarType.fixed,
        //     backgroundColor: kPrimaryLightColor,
        //     onTap: onTabTapped,
        //     currentIndex: _currentIndex, // new
        //     items: [
        //       BottomNavigationBarItem(
        //           icon: SvgPicture.asset(
        //             'assets/icons/home.svg',
        //             height: 20.0,
        //             width: 20.0,
        //           ),
        //           activeIcon: SvgPicture.asset(
        //             'assets/icons/home.svg',
        //             height: 20.0,
        //             width: 20.0,
        //             color: kPrimaryColor.withOpacity(0.5),
        //           ),
        //           label: 'Home',
        //           backgroundColor: kPrimaryLightColor),
        //       BottomNavigationBarItem(
        //           icon: SvgPicture.asset(
        //             'assets/icons/calendar.svg',
        //             height: 20.0,
        //             width: 20.0,
        //           ),
        //           activeIcon: SvgPicture.asset(
        //             'assets/icons/calendar.svg',
        //             height: 20.0,
        //             width: 20.0,
        //             color: kPrimaryColor.withOpacity(0.5),
        //           ),
        //           label: 'Calendar',
        //           backgroundColor: kPrimaryLightColor),
        //       BottomNavigationBarItem(
        //           icon: SvgPicture.asset(
        //             'assets/icons/health-history.svg',
        //             height: 20.0,
        //             width: 20.0,
        //           ),
        //           activeIcon: SvgPicture.asset(
        //             'assets/icons/health-history.svg',
        //             height: 20.0,
        //             width: 20.0,
        //             color: kPrimaryColor.withOpacity(0.5),
        //           ),
        //           label: 'Health History',
        //           backgroundColor: kPrimaryLightColor),
        //       BottomNavigationBarItem(
        //           icon: SvgPicture.asset(
        //             'assets/icons/lab.svg',
        //             height: 20.0,
        //             width: 20.0,
        //           ),
        //           activeIcon: SvgPicture.asset(
        //             'assets/icons/lab.svg',
        //             height: 20.0,
        //             width: 20.0,
        //             color: kPrimaryColor.withOpacity(0.5),
        //           ),
        //           label: 'Lab Result',
        //           backgroundColor: kPrimaryLightColor),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
