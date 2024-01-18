import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

import '../Entities/previousAppointment.dart';
import '../Screens/Appoitments/searchAppointment.dart';
import '../Screens/MyDoctors/visits.dart';

class DoctorCard extends StatelessWidget {
  final String? doctorname;
  final String? lastvisit;
  final String? specialty;
  final List<previousAppointment>? doctor;
  const DoctorCard({Key? key, this.doctorname, this.lastvisit, this.doctor, this.specialty})
      : super(key: key);

  get kPrimaryLightColor => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle card tap if necessary
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF056195).withOpacity(0.05),
              Color(0xFF056195).withOpacity(0.1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Doctor Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/doctor2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Spacing
                SizedBox(width: 15),

                // Doctor Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorname!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF056195),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "$specialty", // Doctor's specialty
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF056195).withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Color(0xFF056195).withOpacity(0.6), size: 16),
                          SizedBox(width: 4),
                          Text(
                            "Last Visit: $lastvisit",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF056195).withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Spacing
            SizedBox(height: 20),

            // Action Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Book Now Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchAppointment(
                          doctor![0].appointmenT_SOURCE!,
                          doctor![0].depDescription!,
                          doctor![0].appointmenT_DEPARTMENT_ID!,
                        ),
                      ),
                    );
                  },
                  child: Text("Book Now"),
                  style: ElevatedButton.styleFrom(alignment:Alignment.center,
                    primary: Color(0xFF056195),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // All Visits IconButton
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.format_list_numbered_rtl, color: Color(0xFF056195)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Visits(doctor!),
                          ),
                        );
                      },
                    ),
                    Text(
                      "All Visits",
                      style: TextStyle(fontSize: 12, color: Color(0xFF056195).withOpacity(0.7)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



}
