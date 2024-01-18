import 'package:flutter/material.dart';
import 'package:soul/Screens/MyDoctors/myDoctors.dart';
import 'package:soul/Screens/MyDoctors/visitsList.dart';

import '../../Entities/previousAppointment.dart';

class Visits extends StatefulWidget {

  //  const Visits({Key key}) : super(key: key);
  State<Visits> createState() => _VisitsState();
  List<previousAppointment> doctor;
  Visits(this.doctor);
 
  
}

class _VisitsState extends State<Visits> {
  get kPrimaryColor => null;
  // List<String> date=[
  //   "22-2-2022",
  //   "25-2-2022",
  //   "1-3-2022",
  //   "15-3-2022",

  // ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SafeArea(
     child: Scaffold(
         backgroundColor: Colors.white,
         appBar: AppBar(
           elevation:4,
           toolbarHeight: queryData.size.height * 0.08,
           leading: GestureDetector(
             onTap: () {
               Navigator.push(
                 context,

                   MaterialPageRoute(
                       builder: (context) => MyDoctors())               );
             },
             child: Icon(
               Icons.arrow_back,
               color: Color(0xFF056195),
               size: 30,
             ),
           ),
           title: Text(
             "Visits",
             style: TextStyle(
               fontSize: 25,
               color: Color(0xFF056195), // Adjust color based on the design
             ),
           ),
           backgroundColor: Colors.white,

         ),
            body: Padding(padding: EdgeInsets.all(10), child:VisitsList(doctors: widget.doctor) ,)
          ),
   );
  }
}