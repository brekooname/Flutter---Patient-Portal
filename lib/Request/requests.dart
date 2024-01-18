import 'dart:convert';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Entities/appUser.dart';
import 'package:soul/Entities/appointmentsTimeList.dart';
import 'package:soul/Entities/auth.dart';
import 'package:soul/Entities/clinic.dart';
import 'package:soul/Entities/doctor.dart';
import 'package:soul/Entities/familyMem.dart';
import 'package:soul/Entities/medication.dart';
import 'package:soul/Entities/patientEncounters.dart';
import 'package:soul/Entities/prescription.dart';
import 'package:soul/Entities/previousAppointment.dart';
import 'package:soul/Entities/radRes.dart';
import 'package:soul/Entities/userHospital.dart';
import 'package:soul/Entities/verificationCoderesponse.dart';
import 'package:soul/Entities/vital.dart';
import 'package:soul/apiConstants.dart';
import 'package:http/http.dart' as http;
import '../Entities/insurance.dart';
import '../Entities/orders.dart';

class Requests {
  dynamic headers;
  //Requests({this.headers});

  //to get clinics and doctor when user go to book appointment page
  Future<List<Doctor>> GetDoctorsDetailsOfClinic(
      FacilityName, token, ClinicId) async {
    List<Doctor> result;
    final url1 =
        '$url$routClinic$clinicWithDoctors?FacilityName=$FacilityName&ClinicId=$ClinicId';
    print("url" + url1.toString());
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print("ress" + response.body.toString());
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print("parssed" + parsed.toString());
      result = parsed.map<Doctor>((json) => Doctor.fromJson(json)).toList();
      print("ress" + response.body.toString());
      print("result" + result.toString());
      return result;
    } else
      throw Exception('Failed to load Clinics and doctors');
  }

  Future<List<Clinic>> GetClinics(String FacilityName, String token) async {
    // ignore: deprecated_member_use
    final pref = await SharedPreferences.getInstance();
    bool s;
    List<Clinic> result;

    String url1 = "$url$routClinic$clinicName?FacilityName=$FacilityName";

    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');
      s = await pref.setString("clinics", response.body);
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Clinic>((json) => Clinic.fromJson(json)).toList();
    } else
      throw Exception('Failed to load Clinics');
  }

//get available time for the doctor at specific date
  Future<dynamic> GetAvailableTimes(
      FacilityName, DoctorId, DepartmentId, Date) async {
    List<String> result;
    final url1 = Uri.parse('$url/posts');
    headers = {"Content-type": "application/json"} as HttpHeaders;
    final json =
        '{"FacilityName": $FacilityName,"DoctorId" :$DoctorId,"DepartmentId ": $DepartmentId, "Date":$Date }';
    final response = await http.get(url1, headers: headers);
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      return result = jsonDecode(response.body);
    } else
      throw Exception('Failed to load Available times');
  }

// book an appointment
  Future<String> createAppointment(
      FacilityName,
      clinicid,
      patientid,
      doctorname,
      AppointmentDateTime,
      additionalapp,
      duration,
      TypeId,
      facilityid,
      String token) async {
    final data = {
      "DepartmentID": clinicid,
      "PatientID": patientid,
      "Source": doctorname,
      "AppointmentDateTime": AppointmentDateTime,
      "IsAdditionaAppointment": additionalapp,
      "Duration": duration,
      "FacilityId": facilityid,
      "TypeId": TypeId,
    };
    //var postdata = json.encode(data);
    final url1 = Uri.parse(
        '$url$appointmentApi$create_Apointments?FacilityName=Caritas');
    // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    // if statment to check if user choose time from additional quta or not  if()
    //final js = '{"FacilityName": $FacilityName,"postdata":$postdata}';
    final response = await post(url1,
        headers: {
          'Content-Type': 'application/json',
          'charset': 'utf-8',
          "token": token,
          "Authorization": "Bearer " + token
        },
        body: json.encode(data));
    print('Status code: ${response.statusCode}');
    print(url1.toString());
    print(json.encode(data));
    if (response.statusCode == 200) {
      print("ressss11" + response.body);
      return "Appointment created succssfuly";
    } else
      throw Exception('Failed to create Appointment');
  }

// get order details
  dynamic getOrderDetails( context,
      FacilityName, type, FromDate, ToDate, PatientId, token) async {
    dynamic result;
    print('FromDate - getOrderDetails '+FromDate);
    print('ToDate - getOrderDetails '+ToDate);
    final url1 = Uri.parse(
        '$url$routOrders$orderRes?FacilityName=$FacilityName&type=$type&FromDate=$FromDate&ToDate=$ToDate&PatientId=$PatientId');
    print("url==" + url1.toString());

    final response = await http.get(url1,
        headers: {"token": token, "Authorization": "Bearer " + token});
    print('Status code: ${response.statusCode}');
    print("resbody" + response.body);
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print("hsbc" +
          parsed
              .map<Order>((json) => Order.fromJson(json))
              .toList()
              .toString());
      result = parsed.map<Order>((json) => Order.fromJson(json)).toList();
      return result;
    }
    else if (response.statusCode == 200&&jsonDecode(response.body).cast<Map<String, dynamic>>().toString()=='[]') {

      showMessageDialog(
        context,
        "No readings found in the given date interval.",
      );
      result = null;
      return result!;
    }
    else
      throw Exception('Failed to lab orders');
  }

  Future<List<RadRes>> getOrderDetailsForRadiology(      BuildContext context, // Add the BuildContext parameter

      FacilityName, type, FromDate, ToDate, PatientId, token) async {
    dynamic result;
    final url1 = Uri.parse(
        //'http://192.168.20.124/backendapi/api/Orders/GetOrdersDetails?FacilityName=$FacilityName&type=$type&FromDate=$FromDate&ToDate=$ToDate&PatientId=$PatientId'
        '$url$routOrders$orderRes?FacilityName=$FacilityName&type=$type&FromDate=$FromDate&ToDate=$ToDate&PatientId=$PatientId');
    print("url==" + url1.toString());

    final response = await http.get(url1,
        headers: {"token": token, "Authorization": "Bearer " + token});
    print('Status code: ${response.statusCode}');
    print("resbody " + response.body);
    print("resbody len rad " + response.body.length.toString());
    print("response.body.isEmpty len rad " + response.body.isEmpty.toString());
    if (response.statusCode == 200&&jsonDecode(response.body).cast<Map<String, dynamic>>().toString()!='[]') {

      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print('parsed rad res '+parsed.toString());
      print("hsbc" +
          parsed
              .map<RadRes>((json) => RadRes.fromJson(json))
              .toList()
              .toString());
      return parsed.map<RadRes>((json) => RadRes.fromJson(json)).toList();
    } else if (response.statusCode == 200&&jsonDecode(response.body).cast<Map<String, dynamic>>().toString()=='[]') {

      showMessageDialog(
        context,
        "No readings found in the given date interval.",
      );
      result = null;
      return result!;
    } else {
      // Handle other error cases
      throw Exception('Failed to load lab orders');
    }
  }

//get previous appointment
  Future<List<previousAppointment>> GetPreviousAppointments(
      FacilityName, PatientId, token) async {
    List<previousAppointment> result;
    String url1 =
        "$url$appointmentApi$previousApp?FacilityName=$FacilityName&PatientId=$PatientId";

    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());
    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      result = parsed
          .map<previousAppointment>(
              (json) => previousAppointment.fromJson(json))
          .toList();
      print("resss" + result.toString());
      return result;
    } else
      throw Exception('Failed to load Insurance');
  }

  Future<List<previousAppointment>> GetUpcomingAppointments(
      FacilityName, PatientId, token) async {
    List<previousAppointment> result;
    String url1 =
        "$url$appointmentApi$UpComingTab?FacilityName=$FacilityName&PatientId=$PatientId";

    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());
    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      result = parsed
          .map<previousAppointment>(
              (json) => previousAppointment.fromJson(json))
          .toList();
      print("resss" + result.toString());
      return result;
    } else
      throw Exception('Failed to load Insurance');
  }

  Future<List<AppointmentsTimeList>> GetAppointmentTimeSlots(
      FacilityName, PatientId, ResourceId, DepartmentId, Date, token) async {
    List<AppointmentsTimeList> result;
    final url1 = Uri.parse(
        '$url$appointmentApi$timeSlot?FacilityName=$FacilityName&PatientId=$PatientId&ResourceId=$ResourceId&DepartmentId=$DepartmentId&Date=$Date');
    // headers = {"Content-type": "application/json"} as HttpHeaders;

    final response = await http.get(url1,
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("url//" + url1.toString());
    print('Status code: ${response.statusCode}');
    print("ress get timeslots " + response.body.toString());
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      result = parsed
          .map<AppointmentsTimeList>(
              (json) => AppointmentsTimeList.fromJson(json))
          .toList();
      print("resss" + result.toString());
      return result;
    } else
      throw Exception('Failed to load time slots');
  }

  Future<Vital> GetVitalSignReadDetails(String FacilityName, String PatientId,
      encounterId, String readid, String token) async {
    Vital? result;

    //String url1 = "$url$routvital$getvital?FacilityName=$FacilityName&PatientId=$PatientId";
    String url1 =
        '$url$routvital$getvitalDetails?FacilityName=$FacilityName&PatientId=$PatientId&EncounterId=$encounterId&Readid=$readid';
    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());

// Map<String,dynamic> resp = response.body as Map<String, dynamic>;

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');

      result = Vital.fromJson(jsonDecode(response.body));

      print(result.toString());
      return result;
      //print("result"+result.bmi);
      // ignore: dead_code
    } else if (response.statusCode == 404) {
      result = null;
      return result!;
    } else
      throw Exception('Failed to load vital signs');
  }
  void showMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20),
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 50,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "No Readings Found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }


  Future<List<Vital>> GetVitalSignRead(
      BuildContext context, // Add the BuildContext parameter
      String FacilityName,
      String PatientId,
      encounterId,
      String fromdate,
      String todate,
      String token) async {
    List<Vital>? result;

    String formattedFromDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(fromdate));
    String formattedToDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(todate));

    String url1 =
        '$url$routvital$getvital?FacilityName=$FacilityName&PatientId=$PatientId&EncounterId=$encounterId&Fromdate=$formattedFromDate&Todate=$formattedToDate';

    print("url===" + url1.toString());


    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      result = parsed.map<Vital>((json) => Vital.fromJson(json)).toList();

      print(result.toString());
      return result!;
    } else if (response.statusCode == 404) {

      showMessageDialog(
        context,
        "No readings or vital signs found in the given date interval.",
      );
      result = null;
      return result!;
    } else {
      // Handle other error cases
      throw Exception('Failed to load vital signs');
    }
  }

  Future<List<Insurance>> GetInsuranceDetails(
      String FacilityName, String PatientId, String token) async {
    // ignore: deprecated_member_use
    List<Insurance> result = [];

    String url1 =
        "$url$routInsurance$getinsurance?FacilityName=$FacilityName&PatientId=$PatientId";

    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(
        // 'http://192.168.20.124:80/backendapi/api/InsuranceDetails/GetInsuranceDetails?FacilityName=Caritas&PatientId=C447036'
        url1), headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());

// Map<String,dynamic> resp = response.body as Map<String, dynamic>;

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      result =
          parsed.map<Insurance>((json) => Insurance.fromJson(json)).toList();
      print("resss" + result.toString());
      return result;
    } else
      throw Exception('Failed to load Insurance');
  }

  Future<Auth> Authentication(String userName, String Password,BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // ignore: deprecated_member_use
    Auth? result;
    final login = {
      "LoginUserName": userName,
      "Password": Password,
    };
    //String url1 = "$url$routvital$getvital?FacilityName=$FacilityName&PatientId=$PatientId";
    String url1 = '$url/Authentication/authenticate';

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.post(Uri.parse(url1),
        body: json.encode(login), headers: headers);
    print("responce.body" + response.body.toString());

// Map<String,dynamic> resp = response.body as Map<String, dynamic>;

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');

      result = Auth.fromJson(jsonDecode(response.body));
      print("ress token auth - " + result.token!);
      print("ress loginUserName - " + result.loginUserName!);
      pref.setString("token", result.token!);
      pref.setString("username", result.loginUserName!);
      return result;
      //print("result"+result.bmi);
      // ignore: dead_code
    }
    // else if(response.statusCode==401){
    //   showModalBottomSheet(
    //     context: context,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(20.0),
    //     ),
    //     builder: (BuildContext context) {
    //       return Container(
    //         height: 150,
    //         padding: EdgeInsets.all(20),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Text(
    //               'Error',
    //               style: TextStyle(
    //                 fontSize: 24,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.red,
    //               ),
    //             ),
    //             Text(
    //               'Username or password is incorrect',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 fontSize: 16,
    //               ),
    //             ),
    //             ElevatedButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 primary: Color(0xFF6677AA),
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(20.0),
    //                 ),
    //               ),
    //               child: Text('OK'),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // }
       throw Exception('Failed to load data');

  }

  Future<List<Doctor>> GetMyDoctors(String PatientId, String token) async {
    // ignore: deprecated_member_use
    List<Doctor> result = [];
    print('url get MD'+url.toString());
    print('routClinic get MD'+routClinic.toString());
    print('myDoctor get MD'+myDoctor.toString());
    print('PatientId get MD'+PatientId.toString());
    String url1 = "$url$routClinic$myDoctor?PatientId=$PatientId";

    print("url=== get MD " + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());

// Map<String,dynamic> resp = response.body as Map<String, dynamic>;

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Doctor>((json) => Doctor.fromJson(json)).toList();
    } else
      throw Exception('Failed to load  Doctors');
  }

  Future<List<String>?> GetMedication( BuildContext context, // Add the BuildContext parameter
      FacilityName, PatientId, token, encounterId, fromdate, todate) async {
    dynamic result;
    //"["1","2","3"]"
    print('fromdate - getMedication '+fromdate);
    print('todate - getMedication '+todate);
    String url1 =
        "$url$routMedication$getMedication?FacilityName=$FacilityName&PatientId=$PatientId&EncounterId=$encounterId&Fromdate=$fromdate&Todate=$todate";

    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());
    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');

      result = (jsonDecode(response.body) as List<dynamic>).cast<String>();

      print("resss" + result.toString());
      return result;
    } else if (response.statusCode == 404) {
      showMessageDialog(
        context,
        "No readings or Medication found in the given date interval.",
      );
      result = null;
      return result!;
    } else
      throw Exception('Failed to load medication List111 ');
  }

  Future<List<Medication>> GetMedicationsDoses(FacilityName, PatientId,
      DrugName, EncounterId, token, fromdate, todate) async {
    List<Medication>? result;
    String url1 =
        "$url$routMedication$getMedicationsDoses?FacilityName=$FacilityName&PatientId=$PatientId&Drugname=$DrugName&Encounterid=$EncounterId&Fromdate=$fromdate&Todate=$todate";

    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());
    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      result =
          parsed.map<Medication>((json) => Medication.fromJson(json)).toList();
      print("resss" + result.toString());
      return result!;
    } else {
      print("resss" + result.toString());
      throw Exception('Failed to load medication List');
    }
  }

  Future<List<Prescription>?> Getprescriptions(BuildContext context,
      FacilityName, PatientId, encounterId, token, fromdate, todate) async {
    dynamic result;
    String url1 =
        "$url$routMedication$getPrescription?FacilityName=$FacilityName&PatientId=$PatientId&EncounterId=$encounterId&Fromdate=$fromdate&Todate=$todate";

    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());
    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      result = parsed
          .map<Prescription>((json) => Prescription.fromJson(json))
          .toList();
      print("resss" + result.toString());
      return result;
    } else if (response.statusCode == 404) {

      showMessageDialog(
        context,
        "No readings or prescriptions found in the given date interval.",
      );
      result = null;
      return result!;
    }else
      throw Exception('Failed to load prescription list');
  }

  Future<Prescription> GetprescriptionsDetails(
      FacilityName, PatientId, PrescriptionId, encounterid, token) async {
    Prescription result;
    String url1 =
        "$url$routMedication$getPrescriptionDetails?FacilityName=$FacilityName&PatientId=$PatientId&EncounterId=$encounterid&PrescriptionId=$PrescriptionId";

    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());
    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');

      result = Prescription.fromJson(jsonDecode(response.body));

      print("resss" + result.toString());
      return result;
    } else
      throw Exception('Failed to load prescription list');
  }

  Future<VerivicationCodeResponse> GetVerificationCode(
      String PatientId,
      String mobileNumber,
      String nationalId,
      String email,
      bool ToMobile,
      bool ToEmail) async {
    // ignore: deprecated_member_use
    VerivicationCodeResponse result;

    //String url1 = "$url$routvital$getvital?FacilityName=$FacilityName&PatientId=$PatientId";
    String url1 =
        '$url$routpatient$verifypatient?Patientid=$PatientId&MobileNumber=$mobileNumber&NationalId=$nationalId&EmailAddress=$email&ToMobile=$ToMobile&ToEmail=$ToEmail';
    print("url===" + url1.toString());
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(Uri.parse(url1), headers: headers);
    print("responce.body" + response.body.toString());

// Map<String,dynamic> resp = response.body as Map<String, dynamic>;

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');

      result = VerivicationCodeResponse.fromJson(jsonDecode(response.body));
      print(result.toString());
      return result;
      //print("result"+result.bmi);
      // ignore: dead_code
    } else
      throw Exception('Failed to get Code');
  }

  Future<UserHospital> VerifyCode(int Code, String PatientId) async {
    // ignore: deprecated_member_use
    UserHospital result;

    //String url1 = "$url$routvital$getvital?FacilityName=$FacilityName&PatientId=$PatientId";
    String url1 =
        '$url$routverification$verifycode?Code=$Code&PatientId=$PatientId';
    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1));
    print("responce.body" + response.body.toString());

// Map<String,dynamic> resp = response.body as Map<String, dynamic>;

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');

      result = UserHospital.fromJson(jsonDecode(response.body));
      print(result.toString());
      return result;
      //print("result"+result.bmi);
      // ignore: dead_code
    } else
      throw Exception('Failed to get Code');
  }

  Future<dynamic> CheckMyCode(
      int Code, String PatientId, bool IsExpired) async {
    // ignore: deprecated_member_use
    dynamic result;

    //String url1 = "$url$routvital$getvital?FacilityName=$FacilityName&PatientId=$PatientId";
    String url1 =
        '$url/VerficationCode/CheckMyCode?Code=$Code&PatientId=$PatientId&IsExpired=$IsExpired';
    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1));
    print("responce.body" + response.body.toString());

// Map<String,dynamic> resp = response.body as Map<String, dynamic>;

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');

      result = jsonDecode(response.body);
      print(result.toString());
      return result;
      //print("result"+result.bmi);
      // ignore: dead_code
    }
    if (response.statusCode == 500) {
      result = response.statusCode;
      return result;
    } else
      throw Exception('Failed to get Code');
  }

  Future<AppUser> Registration(
      String userName, String Password, String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // ignore: deprecated_member_use
    AppUser result;
    final register = {
      "userID": "87119038",
      "loginUserName": userName,
      "password": Password,
    };
    //String url1 = "$url$routvital$getvital?FacilityName=$FacilityName&PatientId=$PatientId";
    String url1 = '$url/User/UserRegistration';

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.post(Uri.parse(url1),
        body: json.encode(register), headers: headers);
    print("responce.body" + response.body.toString());

// Map<String,dynamic> resp = response.body as Map<String, dynamic>;

    print("response" + response.body.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');

      result = AppUser.fromJson(jsonDecode(response.body));
      print("ress" + result.toString());
      pref.setString("userName", result.loginUserName!);
      return result;
      //print("result"+result.bmi);
      // ignore: dead_code
    } else
      throw Exception('Failed to load data');
  }

  Future<UserHospital?> Login(String userName, String Password, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserHospital? result;
    final String url1 = '$url/User/CheckUserLogin?LoginUserName=$userName&passowrd=$Password';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    final response = await http.get(Uri.parse(url1), headers: headers);
  print('response.statusCode login 1 '+response.statusCode.toString() );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print('responseBody login 1 '+responseBody.toString());
      if (responseBody is bool) {
        // If the response is boolean, show a dialog
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          builder: (BuildContext context) {
            return Container(
              height: 150,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Error',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'Username or password is incorrect',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF6677AA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          },
        );

        return null;
      } else {
        result = UserHospital.fromJson(responseBody);
        pref.setString("patientid", result.PatientID!);
        pref.setString("userid", result.UserID!);
        pref.setString('facilityname', result.facilityname!);
        pref.setString('facilityid', result.facilityid!);
        pref.setString('defaultencounter', result.defaultencounterid!);
        return result;
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<VerivicationCodeResponse> ResetPssword(
      String userName,
      String PatientId,
      String mobileNumber,
      String email,
      bool ToMobile,
      bool toEmail) async {
    // ignore: deprecated_member_use
    VerivicationCodeResponse result;

    //String url1 = "$url$routvital$getvital?FacilityName=$FacilityName&PatientId=$PatientId";
    String url1 =
        '$url/User/ResetPssword?LoginUserName=$userName&Patientid=$PatientId&MobileNumber=$mobileNumber&EmailAddress=$email&ToMobile=false&ToEmail=true';

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1), headers: headers);
    print("responce.body" + response.body.toString());

// Map<String,dynamic> resp = response.body as Map<String, dynamic>;

    print("response" + response.body.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');

      result = VerivicationCodeResponse.fromJson(jsonDecode(response.body));
      print("ress" + result.toString());
      return result;
      //print("result"+result.bmi);
      // ignore: dead_code
    } else
      throw Exception('Failed to load data');
  }

  Future<AppUser> VerifyCodeForReset(
      int code, String patientId, bool toEmail, bool toMobile) async {
    // ignore: deprecated_member_use
    AppUser result;

    //String url1 = "$url$routvital$getvital?FacilityName=$FacilityName&PatientId=$PatientId";
    String url1 =
        '$url/User/VerifyCodeForReset?Code=$code&PatientId=$patientId&ToMobile=false&ToEmail=true';

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1), headers: headers);
    print("responce.body" + response.body.toString());

// Map<String,dynamic> resp = response.body as Map<String, dynamic>;

    print("response" + response.body.toString());
    print('Status code: ${response.statusCode}');

      print('resStatus: ${response.statusCode}');

      result = AppUser.fromJson(jsonDecode(response.body));
      print("ress" + result.toString());

      return result;
      //print("result"+result.bmi);
      // ignore: dead_code

  }

  Future<List<FamilyMem>> GetfamilyMember(
      String FacilityName, String patientId, String token) async {
    // ignore: deprecated_member_use
    final pref = await SharedPreferences.getInstance();
    bool s;
    List<FamilyMem> result;

    String url1 =
        "$url/Members/GetFamilyMembers?FacilityName=$FacilityName&PatientId=$patientId";

    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');
      s = await pref.setString("clinics", response.body);
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<FamilyMem>((json) => FamilyMem.fromJson(json)).toList();
    } else
      throw Exception('Failed to load family members');
  }

  Future<List<PatientEncounters>> GetPatientEncounters(
      String FacilityId, String patientId, String token) async {
    // ignore: deprecated_member_use
    final pref = await SharedPreferences.getInstance();
    bool s;
    //List<FamilyMem> result;

    String url1 =
        "$url/Patients/GetPatientEncounters?FacilityId=$FacilityId&Patientid=$patientId";

    print("url===" + url1.toString());
    //headers = {"Content-type": "application/json"} as HttpHeaders;
    final response = await http.get(Uri.parse(url1),
        headers: {"token": token, "Authorization": "Bearer " + token});
    print("responce.body" + response.body.toString());

    print("response" + response.toString());
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('resStatus: ${response.statusCode}');

      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<PatientEncounters>((json) => PatientEncounters.fromJson(json))
          .toList();
    } else
      throw Exception('Failed to load');
  }
}
