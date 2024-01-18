import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Entities/userHospital.dart';
import 'package:soul/constants.dart';

import '../../Entities/verificationCoderesponse.dart';
import '../../Request/requests.dart';
import '../Login_Screen/Login.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({
    Key? key,
  }) : super(key: key);

  @override
  _VerificationCode createState() => _VerificationCode();
}

class _VerificationCode extends State<VerificationCode>
    with SingleTickerProviderStateMixin {
  UserHospital? user;
  VerivicationCodeResponse? verify;
  String str = " ";
  bool isExpired = false;
  AnimationController? controller;
  bool sameCode = false;
  Animation? animation;
  //final _auth = FirebaseAuth.instance;
  String? _patientId, _code;
  final patientIdController = TextEditingController();
  final codeController = TextEditingController();

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
      upperBound: 100.0,
    );
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
    print(controller!.value);
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100], // A soft shade of grey
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kPrimaryColor, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
          title: Text(
            "VERIFICATION",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          backgroundColor: Colors.grey[100],
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTextField(
                  controller: patientIdController,
                  label: 'Enter PatientId',
                  icon: Icons.person,
                ),
                SizedBox(height: size.height * 0.03),
                _buildTextField(
                  controller: codeController,
                  label: 'Enter Verification Code',
                  icon: Icons.vpn_key,
                ),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildElevatedButton(
                      text: 'Check',
                  onPressed: () async {
                    setState(() {
                      isExpired = false;
                    });
                    await getCode(patientIdController.text,codeController.text);
                    if (user != null) {
                      Navigator.pushNamed(context, '/signup');
                    }
                  },

                    ),
                    SizedBox(width: 30),
                    _buildElevatedButton(
                      text: 'Resend Code',
                      onPressed: () {
    setState(() {
    isExpired = true;
    });
    if (_patientId != null) {
    getCode(patientIdController.text,codeController.text);
    }

                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: kPrimaryColor),
        labelText: label,
        labelStyle: TextStyle(color: kPrimaryColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
        ),
      ),
    );
  }
  Widget _buildElevatedButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor:kPrimaryColor,// Dark blue color
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        textStyle: TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }


  Future<void> getCode(patientId1,VerificationCode1) async {
    print("requestooooooooo");
    SharedPreferences pref = await SharedPreferences.getInstance();
    Requests req = new Requests();
    print("requestooooooooo");
    if (_code == null) {
      _code = "1";
      isExpired = true;
    }
    req.CheckMyCode(int.parse(VerificationCode1!), patientId1!, isExpired).then((value) {
      if (isExpired == false && value != 500) {
        setState(() {
          user = UserHospital.fromJson(value);
          pref.setString("userId", user!.UserID!);
          //pref.setString("hospitalId", user.HospitalID);
          print("userrr" + user!.UserID!);
        });
      } else if (isExpired == false && value == 500) {
        print(value.toString());
        setState(() {
          str = "Code is Expired";
        });
      } else if (isExpired == true) {
        setState(() {
          verify = VerivicationCodeResponse.fromJson(value);
        });
      }
    });

    //print(clinicName.toString());
  }

  String get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = codeController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (str == "Code is Expired") {
      return 'code is expired';
    }
    // return null if the text is valid
    return 'null';
  }
}
// void vrifyCode(){
//  if (verify.valid == true) {
//    print("valid  "+verify.valid.toString());
//         if (verify.vCode == int.parse(_code)) {
//           print("validity" + verify.valid.toString());
//           setState(() {
//             sameCode=true;
//           });
//    } else
//           print("not same code");
//       } else
//         print("not valid");
// }
