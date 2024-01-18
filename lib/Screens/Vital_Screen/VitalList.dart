import 'package:flutter/material.dart';
import 'package:soul/Entities/vital.dart';
import 'package:soul/Screens/Vital_Screen/VitalFilter.dart';
import 'package:soul/Screens/Vital_Screen/Vital_Signs.dart';
import 'package:soul/constants.dart';

class VitalList extends StatelessWidget {
  final List<Vital>? VitalResults;
  const VitalList({Key? key, this.VitalResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: queryData.size.height * 0.08,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VitalFilter()),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF056195),
              size: 30,
            ),
          ),
          title: Center(
            child: Text(
              "Vitals List",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF056195),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: VitalResults!.length,
            itemBuilder: (BuildContext ctxt, int index) => buildBody(ctxt, index),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext ctxt, int index) {
    return GestureDetector(
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5), // Add shadow for 3D effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded card corners
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Date:",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF056195),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    VitalResults![index].reaD_DATE!.substring(0, 10),
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          ctxt,
          MaterialPageRoute(
            builder: (context) => Vitals(
              readid: VitalResults![index].reaD_ID!,
              VitalsResults: VitalResults!,
            ),
          ),
        );
      },
    );
  }


}
