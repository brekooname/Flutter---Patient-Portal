import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Components/doctorCard.dart';
import 'package:soul/Entities/previousAppointment.dart';

// import 'tabs/pastTab.dart';
// import 'tabs/upComingTab.dart';
import 'package:soul/constants.dart';

import '../../Entities/doctor.dart';
import '../../Request/requests.dart';
import '../MainPage_Screen/main_page.dart';

class MyDoctors extends StatefulWidget {
  @override
  _MyDoctors createState() => _MyDoctors();
}

class _MyDoctors extends State<MyDoctors> {
  @override
  void initState() {
    getpatientid();
    getMyDoctors();

    super.initState();
  }

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Data Loaded',
  );
  bool load = false;
  List<Doctor> doctor = [];
  List<DoctorCard> doctorCards = [];
  String? patientid;
  List<Doctor> filteredDoctors = [];
  List<DoctorCard> filteredDoctorCards = [];
TextEditingController _searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<DoctorCard> filteredDoctorCards = filteredDoctors.map((doc) {
      String d = doc.previousapp![doc.previousapp!.length - 1].date!.substring(0, 10);
      List<previousAppointment> prev = doc.previousapp!;
      return DoctorCard(
          doctorname: doc.fullName,
          specialty: doc.specialty,
          lastvisit: d,
          doctor: prev
      );
    }).toList();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
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
          "My Doctors",
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFF056195), // Adjust color based on the design
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.sort, color: Color(0xFF056195)), // You can add sorting functionality here
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    filteredDoctors = doctor.where((doc) =>
                    (doc.fullName!.toLowerCase().contains(value.toLowerCase())) ||
                        (doc.specialty!.toLowerCase().contains(value.toLowerCase()))
                    ).toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search by name or specialty...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFF056195)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),

            // Future Builder
            Expanded(
              child: FutureBuilder<String>(
                future: _calculation,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return filteredDoctorCards.length != 0
                        ? ListView.builder(
                      itemCount: filteredDoctorCards.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: filteredDoctorCards[index],
                      ),
                    )
                        : Center(child: Text("No doctors found."));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, color: Colors.red, size: 60),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${snapshot.error}'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget toolbarView(String label, MediaQueryData queryData) => Container(
      height: queryData.size.height * 0.08,
      padding: EdgeInsets.only(left: 130, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(label,
          style: TextStyle(
              color: kPrimaryColor, fontSize: 25, fontWeight: FontWeight.w600)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.2),
              offset: const Offset(0, 1.0),
              blurRadius: 4.0,
              spreadRadius: 2.0,
            ),
          ]));

  Widget _titleHeader() => Container(
        height: 80.0,
        padding: EdgeInsets.only(bottom: 10, top: 10),
        alignment: Alignment.topLeft,
        child: Text(
          'My Doctors',
          style: TextStyle(
              color: kPrimaryColor, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      );

  Future<List<DoctorCard>> getMyDoctors() async {
    print("requestooooooooo");
    List<previousAppointment> prev = [];
    Requests req = new Requests();
    print("requestooooooooo");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String s = pref.getString("token")!;
    String d;
    req.GetMyDoctors(patientid!, s).then((value) {
      setState(() {
 value.forEach((item) => doctor.add(item));
 filteredDoctors = List.from(doctor);
 filteredDoctorCards = filteredDoctors.map((doc) {
   String d = doc.previousapp![doc.previousapp!.length - 1].date!.substring(0, 10);
   List<previousAppointment> prev = doc.previousapp!;
   return DoctorCard(
       doctorname: doc.fullName,
       specialty: doc.specialty,
       lastvisit: d,
       doctor: prev
   );
 }).toList();
       });

      return doctorCards;
    });
    //print(clinicName.toString());
    return doctorCards;
  }

  Future<String> getpatientid() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    patientid = sh.getString('patientid');
    return patientid!;
  }
}
