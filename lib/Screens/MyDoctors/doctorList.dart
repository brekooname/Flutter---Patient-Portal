// import 'package:flutter/material.dart';
// import 'package:soul/Components/doctorCard.dart';
// import 'package:soul/Screens/Appoitments/commonListItem.dart';
// import 'package:soul/Screens/Appoitments/searchAppointment.dart';
// import 'package:soul/Screens/MyDoctors/visits.dart';

// class DoctorsList extends StatelessWidget {
//   final String Name;
//   final String lastV;

//   DoctorsList({Key key, this.Name, this.lastV, });
        
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       padding: EdgeInsets.zero,
//       children: <Widget>[
//         SizedBox(
//           height: 10,
//         ),
//        DoctorCard(doctorname: Name,lastvisit:lastV,press: ()
//                         {
//                           Navigator.push(
//                             context,
//                             PageRouteBuilder(
//                               transitionDuration: Duration(seconds: 1),
//                               transitionsBuilder: (BuildContext context,
//                                   Animation<double> animation,
//                                   Animation<double> secAnimation,
//                                   Widget child) {
//                                 animation = CurvedAnimation(
//                                     parent: animation, curve: Curves.easeIn);
//                                 return ScaleTransition(
//                                   scale: animation,
//                                   child: child,
//                                   alignment: Alignment.center,
//                                 );
//                               },
//                               pageBuilder: (BuildContext context,
//                                   Animation<double> animation,
//                                   Animation<double> secAnimation) {
//                                 return SearchAppointment();
//                               },
//                             ),);
//                         },),
//                         DoctorCard(doctorname: "Doaa Najeeb",lastvisit:"22-2-2022",press: ()
//                         {
//                           Navigator.push(
//                             context,
//                             PageRouteBuilder(
//                               transitionDuration: Duration(seconds: 1),
//                               transitionsBuilder: (BuildContext context,
//                                   Animation<double> animation,
//                                   Animation<double> secAnimation,
//                                   Widget child) {
//                                 animation = CurvedAnimation(
//                                     parent: animation, curve: Curves.easeIn);
//                                 return ScaleTransition(
//                                   scale: animation,
//                                   child: child,
//                                   alignment: Alignment.center,
//                                 );
//                               },
//                               pageBuilder: (BuildContext context,
//                                   Animation<double> animation,
//                                   Animation<double> secAnimation) {
//                                 return SearchAppointment();
//                               },
//                             ),);
//                         },),DoctorCard(doctorname: "Ahmad Hamdan",lastvisit:"22-2-2022",press: ()
//                         {
//                           Navigator.push(
//                             context,
//                             PageRouteBuilder(
//                               transitionDuration: Duration(seconds: 1),
//                               transitionsBuilder: (BuildContext context,
//                                   Animation<double> animation,
//                                   Animation<double> secAnimation,
//                                   Widget child) {
//                                 animation = CurvedAnimation(
//                                     parent: animation, curve: Curves.easeIn);
//                                 return ScaleTransition(
//                                   scale: animation,
//                                   child: child,
//                                   alignment: Alignment.center,
//                                 );
//                               },
//                               pageBuilder: (BuildContext context,
//                                   Animation<double> animation,
//                                   Animation<double> secAnimation) {
//                                 return SearchAppointment();
//                               },
//                             ),);
                            
//                         },press2:(){} ,press3: ()
//                         {
//                           Navigator.push(
//                             context,
//                             PageRouteBuilder(
//                               transitionDuration: Duration(seconds: 1),
//                               transitionsBuilder: (BuildContext context,
//                                   Animation<double> animation,
//                                   Animation<double> secAnimation,
//                                   Widget child) {
//                                 animation = CurvedAnimation(
//                                     parent: animation, curve: Curves.easeIn);
//                                 return ScaleTransition(
//                                   scale: animation,
//                                   child: child,
//                                   alignment: Alignment.center,
//                                 );
//                               },
//                               pageBuilder: (BuildContext context,
//                                   Animation<double> animation,
//                                   Animation<double> secAnimation) {
//                                 return Visits();
//                               },
//                             ),);
                            
//                         } ,)
//       ],
//     );
//   }
// }
