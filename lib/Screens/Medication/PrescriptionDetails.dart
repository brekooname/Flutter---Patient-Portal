import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Entities/medication.dart';
import 'package:soul/Request/requests.dart';
import 'package:soul/Screens/Appoitments/commonListItem.dart';
import 'package:soul/Screens/Medication/presc.dart';
import 'package:soul/constants.dart';

class PrescriptionDetails extends StatefulWidget {
  final String id;
  final String? EncounterId;

  _PrescriptionDetails createState() => _PrescriptionDetails();
  PrescriptionDetails(this.id, this.EncounterId);
}

class _PrescriptionDetails extends State<PrescriptionDetails> {
  @override
  String? d;
  String? fromdate;
  String? todate;
  String? patientid;
  String? facilityname;
  List<String>? PrescrepId;
  List<String>? PrescrepDates;
  final List<CommonListItem> commonlistpre = [];
  String? encounterid;
  //same as common
  List<Medication> medication = [];
  final List<CommonListItem> Common = [];
  // list each dose with description and date time
  void initState() {
    getpatientid();
    getfacilityname();
    // to fill list use api
    GetPresId();
    getEncounterid();
    GetPrescriptionDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("hello");
    print(Common);
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(elevation: 0,
          title: Center(child: Text('Doses', style: TextStyle(color: kPrimaryColor),)),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => Prescrip()),
              );
            },
            child: Icon(Icons.arrow_back // add custom icons also
             ,color: kPrimaryColor, size: 30,  ),
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

  Future<List<CommonListItem>> GetPrescriptionDetails() async {
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    String d;
    try {
      await req.GetprescriptionsDetails(
              facilityname, patientid, widget.id, encounterid, s)
          .then((value) {
        setState(() {
          print("in111" + medication.toString());

          d = value.OrderedDate!;
          Common.add(new CommonListItem(
            firstTitle: d.substring(0, 10),
            thirdTitle: value.MedicationDescription,
            fourthTitle: value.MedicationInstruction,
            EncounterId: value.EncounterId,
          ));
        });
      });
    } catch (e) {
      print(e);
    }
    // Return the list after the setState function
    return Common;
  }

  Future<String> getFromdate() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    fromdate = sh.getString('Fromdate');
    return fromdate!;
  }

  Future<String> getTodate() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    todate = sh.getString('Todate');
    return todate!;
  }

  Future<String> getEncounterid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    encounterid = sh.getString('defaultencounter');
    return encounterid!;
  }

  Future<void> GetPresId() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String names = sh.getString('PresId')!;
    String dates = sh.getString('PresDates')!;
    //Panadol,Acamol,test,
    print("drugs in shared" + names);
    commonlistpre.clear();
    List<String> Prescriptionid = names.split(',');
    List<String> Prescriptiondates = dates.split(',');

    print("splitted" + Prescriptionid.toString());
    print("splitted" + Prescriptiondates.toString());

    for (int i = 0; i < Prescriptionid.length - 1; i++) {
      commonlistpre.add(new CommonListItem(
          thirdTitle: Prescriptiondates[i],
          PageTYpe: "PreSc",
          Prescid: Prescriptionid[i],
          thirdTitleIcon: Icons.info_rounded));
    }
    print(commonlistpre);
  }
}
