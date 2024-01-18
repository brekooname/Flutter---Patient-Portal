import 'package:flutter/material.dart';
import 'package:soul/Entities/patientEncounters.dart';
import 'package:soul/Screens/MainPage_Screen/main_page.dart';
import 'package:soul/constants.dart';

class EncounterList extends StatelessWidget {
  final List<PatientEncounters>? encounter;
  const EncounterList({Key? key, @required this.encounter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      // width:queryData.size.width*0.7,
      // height:queryData.size.height*0.1,
      child: DataTable(
        // decoration: BoxDecoration(
        //         border: Border.all(
        //       width: 1,
        //       color: Colors.black,
        //     )),
        columnSpacing: 8,
        //border: TableBorder(verticalInside: VerticalDivider(color: Colors.black,)),
        columns: [
          DataColumn(
              label: Text("Encounter Id",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor))),
          DataColumn(
              label: Text('Encounter date ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor))),
          DataColumn(
              label: Text('Encounter type',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor))),
          DataColumn(
              label: Text('Switch',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor)))
        ],

        rows: encounter!
            .map(
              (encounter) => DataRow(
                  //selected: selectedAvengers.contains(avenger),
                  cells: [
                    DataCell(
                      encounter.EncounterId != null
                          ? Text(encounter.EncounterId!)
                          : Text("   "),
                      onTap: () {
                        // write your code..
                      },
                    ),
                    DataCell(
                      encounter.EncounterDate != null
                          ? Text(encounter.EncounterDate!.substring(0, 10))
                          : Text("   "),
                    ),
                    DataCell(
                      encounter.Encountertype != null
                          ? Text(encounter.Encountertype!)
                          : Text("   "),
                    ),
                    DataCell(GestureDetector(
                        //child: Text("Image ", style: TextStyle(fontSize: 12, color:kPrimaryColor)),
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: kPrimaryColor,
                          child: Icon(
                            Icons.switch_account,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage(
                                    encounter.PatientId!,
                                    encounter.EncounterId!,
                                    false)),
                          );
                        }))
                  ]),
            )
            .toList(),
      ),
    );
  }
}
