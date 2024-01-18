import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Entities/medication.dart';
import 'package:soul/Request/requests.dart';
import 'package:soul/Screens/Appoitments/commonListItem.dart';
import 'package:soul/Screens/Medication/pastMedication.dart';
import 'package:soul/constants.dart';

class DrugDetails extends StatefulWidget {
  final String MedicationName;
  final String EncounterId;
  _DrugDetails createState() => _DrugDetails();
  DrugDetails(this.MedicationName, this.EncounterId);
}

class _DrugDetails extends State<DrugDetails> {
  @override
  String? d;
  String? fromdate;
  String? encounterid;
  String? todate;
  String? patientid;
  String? facilityname;
  List<CommonListItem> commonDrugsname = [];
  //same as common
  List<Medication> medication = [];
  final List<CommonListItem> Common = [];
  // list each dose with description and date time
  void initState() {
    getpatientid();
    getfacilityname();
    getFromdate();
    getTodate();
    getEncounterid();
    getDrugs();

    GetMedicationsDoses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("hello");
    print(Common);
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(elevation: 0,
          title: Center(child: Text('Doses',style: TextStyle(color: kPrimaryColor),)),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => PastMedication()),
              );
            },
            child: Icon(Icons.arrow_back ,size: 30,color: kPrimaryColor,// add custom icons also
                ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: Common.length,
            // The list items
            itemBuilder: (context, index) {
              return Container(
                child: Common[index],
              );
            },
          ),
        ));
  }

  Future<String> getpatientid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    patientid = sh.getString('patientid');
    return patientid!;
  }

  Future<String> getfacilityname() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    facilityname = sh.getString('facilityname');
    return facilityname!;
  }

  Future<List<CommonListItem>> GetMedicationsDoses() async {
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    String d;
    try {
      await req.GetMedicationsDoses(facilityname, patientid,
              widget.MedicationName, widget.EncounterId, s, fromdate, todate)
          .then((value) {
        setState(() {
 value.forEach((item) => medication.add(item));
          print("in111" + medication.toString());

          for (var i = 0; i < medication.length; i++) {
            // for(var i=0;i<do)
            print(medication[i]);
            d = medication[i].ExecutionDate!;
            Common.add(new CommonListItem(
              firstTitle: d.substring(0, 10),
              thirdTitle: medication[i].medicationDescription,
              secondTitle: medication[i].Status,
              fourthTitle: medication[i].instruction,
              EncounterId: medication[i].EncounterId,
            ));
          }
        });
      });
    } catch (e) {
      print(e);
    }
    //print(clinicName.toString());
    return Common;
  }

  Future<String> getFromdate() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    fromdate = sh.getString('Fromdate');
    return fromdate!;
  }

  Future<String> getDrugs() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String drugs = sh.getString('DrugNames')!;
    //Panadol,Acamol,test,
    print("drugs in shared" + drugs);
    commonDrugsname.clear();
    List<String> drugname = drugs.split(',');
    print("splitted" + drugname.toString());
    for (int i = 0; i < drugname.length - 1; i++) {
      commonDrugsname.add(new CommonListItem(
          thirdTitle: drugname[i],
          EncounterId: encounterid,
          PageTYpe: "Med",
          thirdTitleIcon: Icons.info_rounded));
    }
    print(commonDrugsname);
    return 'commonDrugsname';
  }

  Future<String> getEncounterid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    encounterid = sh.getString('defaultencounter');
    return encounterid!;
  }

  Future<String> getTodate() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    todate = sh.getString('Todate');
    return todate!;
  }
}
