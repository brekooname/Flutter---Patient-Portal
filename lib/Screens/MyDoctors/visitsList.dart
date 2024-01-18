import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

import '../../Entities/previousAppointment.dart';

class VisitsList extends StatelessWidget {
  final List<previousAppointment>? doctors;
  const VisitsList({Key? key, this.doctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: ListView.builder(
          itemCount: doctors!.length,
          itemBuilder: (BuildContext ctxt, int index) =>
              buildBody(ctxt, index)),
    );
  }

  Widget buildBody(BuildContext ctxt, int index) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Color(0xFF056195)),
            SizedBox(width: 10),
            Text(
              "Date:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 5),
            Text(
              doctors![index].date!.substring(0, 10),
              style: TextStyle(color: Color(0xFF056195), fontSize: 18),
            ),
            Spacer(),
            Icon(Icons.access_time, color: Color(0xFF056195)),
            SizedBox(width: 10),
            Text(
              "Time:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 5),
            Text(
              doctors![index].date!.substring(11, 16),
              style: TextStyle(color: Color(0xFF056195), fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }}
