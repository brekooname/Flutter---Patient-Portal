import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Components/insuraneCon2.dart';
import 'package:soul/Entities/insurance.dart';
import 'package:soul/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../Request/requests.dart';
import '../MainPage_Screen/main_page.dart';

class Insurance2 extends StatefulWidget {
  const Insurance2({Key? key}) : super(key: key);

  @override
  _Insurance2State createState() => _Insurance2State();
}

class _Insurance2State extends State<Insurance2> {
  List<Insurance>? in1 = [];
  List<Insurance>? in2;
  List<InsuranceCon2> insurance1 = [];
  String? facilityname, patientid;
  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Data Loaded',
  );
  bool load = false;
  @override
  void initState() {
    super.initState();
    getfacilityname();
    getpatientid();
    getInsurance();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
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
                MaterialPageRoute(builder: (context) => MainPage('', '', false)), // Adjust as needed
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF056195),
              size: 30,
            ),
          ),
          title: Text(
            "My Insurance",
            style: TextStyle(
              fontSize: 25,
              color: Color(0xFF056195), // Adjust color based on the design
            ),
          ),
          backgroundColor: Colors.white,

        ),
         body: FutureBuilder<String>(
          future: _calculation,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return insurance1.isNotEmpty
                  ? Center(
                    child: CarouselSlider(
                options: CarouselOptions(
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    height: queryData.size.height * 0.6, // Adjust the height here
                ),
                items: insurance1
                      .map((item) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: item,
                ))
                      .toList(),
              ),
                  )
                  : Center(
                child: Text(
                  "There is no data",
                  style: TextStyle(fontSize: 25),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }


  Future<List<InsuranceCon2>> getInsurance() async {
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;

    var value = await req.GetInsuranceDetails(facilityname!, patientid!, s);

    value.forEach((item) => in1!.add(item));
    print("in111" + in1.toString());
    for (var i = 0; i < in1!.length; i++) {
      print("in1Name" + in1![i].insurancE_NAME!);
      insurance1.add(new InsuranceCon2(
        name: in1![i].insurancE_NAME,
        plan: in1![i].insurancE_PLANName,
        status: '${in1![i].is_Acive}',
        dedtype: in1![i].deductType,
        dedamount: '${in1![i].deductibleAmount}',
        expd: in1![i].expireDate!.substring(0, 10),
      ));
    }

    return insurance1;
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
}
