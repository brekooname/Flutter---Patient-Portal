import 'package:flutter/material.dart';
import 'package:soul/Components/encounterList.dart';
import 'package:soul/Entities/patientEncounters.dart';

import '../../Components/rounded_button.dart';
import '../MainPage_Screen/main_page.dart';

// ignore: must_be_immutable
class Encounters extends StatelessWidget {
  final String? loginpatientid;
  final String? Encounterid;
  final List<PatientEncounters>? encounter;
  Encounters({@required this.encounter, this.loginpatientid, this.Encounterid});
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Container(
      child: Column(
        children: [
          Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  // padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: EncounterList(
                        encounter: encounter,
                      )),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          RoundedButton(
            text: "Reset",
            press: () {
              print("EncounterReset");
              print(loginpatientid);
              print(Encounterid);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MainPage(loginpatientid!, Encounterid!, true)),
              );
            },
          ),
        ],
      ),
    );
  }
}
