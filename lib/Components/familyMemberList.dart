import 'package:flutter/material.dart';
import 'package:soul/Entities/familyMem.dart';
import 'package:soul/Screens/MainPage_Screen/main_page.dart';
import 'package:soul/constants.dart';

import '../sizeConfig.dart';

class FamilymemberList extends StatelessWidget {
  final List<FamilyMem>? result;
  const FamilymemberList({Key? key, @required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MediaQueryData queryData;
    // queryData = MediaQuery.of(context);
    SizeConfig().init(context);
    return Container(
      // width:queryData.size.width*0.7,
      // height:queryData.size.height*0.1,
      child: DataTable(
        // decoration: BoxDecoration(
        //         border: Border.all(
        //       width: 1,
        //       color: Colors.black,
        //     )),
        columnSpacing: SizeConfig.safeBlockHorizontal! * 3,
        //border: TableBorder(verticalInside: VerticalDivider(color: Colors.black,)),
        columns: [
          DataColumn(
              label: Text("PatientId",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor))),
          DataColumn(
              label: Text('Patient Name ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor))),
          DataColumn(
              label: Text('Relation',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor))),
          DataColumn(
              label: Text('switch',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor)))
        ],

        rows: result!
            .map(
              (result) => DataRow(
                  //selected: selectedAvengers.contains(avenger),
                  cells: [
                    DataCell(
                      result.relatedpatientId != null
                          ? Text(result.relatedpatientId!)
                          : Text("there is no data"),
                      onTap: () {
                        // write your code..
                      },
                    ),
                    DataCell(
                      result.patientName != null
                          ? Text(result.patientName!)
                          : Text("there is no data"),
                    ),
                    DataCell(
                      Text(result.relation!),
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
                                    result.relatedpatientId!,
                                    result.Encounterid!,
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
