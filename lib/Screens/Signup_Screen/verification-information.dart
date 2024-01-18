import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Components/rounded_input_field.dart';
import 'package:soul/Entities/appUser.dart';
import 'package:soul/Entities/verificationCoderesponse.dart';
import 'package:soul/Request/requests.dart';
import 'package:soul/constants.dart';

import '../../Entities/auth.dart';
import '../../Entities/userHospital.dart';
import '../Login_Screen/Login.dart';

class VerificationInformation extends StatefulWidget {
  const VerificationInformation({
    Key? key,
  }) : super(key: key);

  @override
  _VerificationInformation createState() => _VerificationInformation();
}

class _VerificationInformation extends State<VerificationInformation>
    with SingleTickerProviderStateMixin {
  static UserHospital? user;
  AppUser? app;
  AnimationController? controller;
  Animation? animation;
  bool toEmail = false;
  bool toPhone = false;
  bool sameCode = false;
  String btnname = "Next";
  VerivicationCodeResponse? verify=VerivicationCodeResponse();
  //final _auth = FirebaseAuth.instance;
  String? _patientId, _NationalId, _phoneNumber, _code, _Email;
  bool? reset;
  final patientIdController = TextEditingController();
  final NationalIdController = TextEditingController();
  final phoneNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String EmailorPhone = "phone";
  Auth? auth;
  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Icon(Icons.arrow_back, color:kPrimaryColor ,size:30,),
          ),
          title: Text(
            "Information Verification",
            style: TextStyle(
              fontSize: 22,color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor:Colors.white
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(height: 30),
              _buildVerificationInputField(
                label: "Patient Id:",
                icon: Icons.person_outline,
                onChanged: (value) => _patientId = value,
              ),
              SizedBox(height: 20),
              _buildVerificationInputField(
                label: "National Id:",
                icon: Icons.credit_card_outlined,
                onChanged: (value) => _NationalId = value,
              ),
              SizedBox(height: 20),
              _buildVerificationInputField(
                label: "Phone Number:",
                icon: Icons.phone_android_outlined,
                onChanged: (value) => _phoneNumber = value,
              ),
              SizedBox(height: 20),
              _buildVerificationInputField(
                label: "Email:",
                icon: Icons.email_outlined,
                onChanged: (value) => _Email = value,
              ),
              SizedBox(height: 30),
              Text(
                'Verify using:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
              _buildRadioOption(title: "Email", value: 'email'),
              _buildRadioOption(title: "Phone", value: 'Mobile'),
              SizedBox(height: 30),
              _buildElevatedButton(
                text: setname(),
                onPressed: () {
                  if (_Email != null &&
                      _phoneNumber != null &&
                      _NationalId != null &&
                      _patientId != null) {
                    getCode(context);
                  }
                },
              ),
            ],
          ),
        ),

      ),
    );

  }
  Widget _buildVerificationInputField({
    required String label,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(icon, color: kPrimaryColor),
              border: InputBorder.none,
              hintText: label,
              hintStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption({required String title, required String value}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Radio<String>(
        activeColor: kPrimaryColor,
        value: value,
        groupValue: EmailorPhone,
        onChanged: (val) => setState(() {
          EmailorPhone = val!;
        }),
      ),
      title: Text(title, style: TextStyle(fontSize: 16)),
    );
  }
  Widget _buildElevatedButton({required String text, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor:kPrimaryColor,
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  String setname() {
    getReset();
    if (reset == true) {
      btnname = "Reset";
    }

    return btnname;
  }

  void _show(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 10,
        context: ctx,
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 120),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                      controller: codeController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: 'Enter Verivication Code',
                          errorText: _errorText,
                          labelStyle: TextStyle(color: kPrimaryColor)),
                      onChanged: (value) {
                        setState(() {
                          _code = value;
                        });
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      getReset();
                      // if reset true
                      if (reset == false) {
                        print("reset" + reset.toString());
                        vrifyCode();
                        if (user != null) {
                          Navigator.pushNamed(context, '/signup');
                        } else
                          print("try again 2");
                        // }else print("try again");
                      } else {
                        print("reset" + reset.toString());
                        vrifyCodeForReset();
                        if (app != null) {
                          Navigator.pushNamed(context, '/');
                        } else
                          print("try again 2");
                        // }else print("try again");
                      }
                    },
                    child: const Text('Submit'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: kPrimaryLightColor,
                    ),
                  )
                ],
              ),
            ));
  }

  Future<VerivicationCodeResponse> getCode(BuildContext context) async {
    print("requestooooooooo");

    Requests req = new Requests();
    print("requestooooooooo");
    getReset();
    print("reset" + reset.toString());

    if (reset == false) {
      req.GetVerificationCode(_patientId!, _phoneNumber!, _NationalId!, _Email!,
              toPhone, toEmail)
          .then((value) {
        setState(() {
          verify = value;
          if (verify != null) {
            _show(context);
          }
        });
      });
    } else {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String username;
      username = sh.getString("loginusername")!;
      print("user name");
      req.ResetPssword(
              username, _patientId!, _phoneNumber!, _Email!, toPhone, toEmail)
          .then((value) {
        setState(() {
          verify = value;
          if (verify != null) {
            _show(context);
          }
        });
        return verify;
      });
    }
    return verify!;
    //print(clinicName.toString());
  }

  Future<UserHospital> vrifyCode() async {
    Requests req = new Requests();
    SharedPreferences pref = await SharedPreferences.getInstance();
    int code = int.parse(_code!);

    print("requestooooooooo");

    req.VerifyCode(code, _patientId!).then((value) {
      user = value;
      print("validity" + user!.UserID.toString());
      pref.setString("userId", user!.UserID!);
      //pref.setString("hospitalId", user.HospitalID);
    });
    setState(() {
      sameCode = true;
    });

    return user!;
  }

  Future<AppUser> vrifyCodeForReset() async {
    Requests req = new Requests();
    SharedPreferences pref = await SharedPreferences.getInstance();
    int code = int.parse(_code!);

    print("requestooooooooo");

    req.VerifyCodeForReset(code, _patientId!, toPhone, toEmail).then((value) {
      app = value;
    });
    setState(() {
      sameCode = true;
    });

    return app!;
  }

  String get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = codeController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (verify!.vCode != int.parse(_code!)) {
      return ' not same code';
    }
    // return null if the text is valid
    return 'null';
  }

  Future<bool> getReset() async {
    SharedPreferences sh = await SharedPreferences.getInstance();

    reset = sh.getBool("reset");
    print("reset1" + reset.toString());
    return reset!;
  }
}
