import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Components/rounded_button.dart';
import 'package:soul/Components/rounded_input_field.dart';
import 'package:soul/Entities/appUser.dart';
import 'package:soul/constants.dart';
import 'package:soul/Components/or_driver.dart';
import 'package:soul/Components/already_have_an_account_acheck.dart';
import 'package:soul/Screens/Login_Screen/Login.dart';

import '../../Components/rounded_password_field.dart';
import '../../Request/requests.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DateTime? _birthDate;
  String? username, ln, ph, e, pass, confirm;

  final _formKey = GlobalKey<FormState>();
  AppUser? app;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: queryData.size.height * 0.08,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Icon(Icons.arrow_back // add custom icons also
                ),
          ),
          title: Center(
              child: Text("Sign up",
                  style: TextStyle(
                    fontSize: 25,
                  ))),
          backgroundColor: kPrimaryColor,
          // bottom: const TabBar(
          //   labelColor: Colors.white,

          //   tabs: tabs,
          // ),
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    // Text(
                    //   'sign up',
                    //   style: TextStyle(
                    //       color: kPrimaryLightColor,
                    //       fontSize: 50,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    RoundedInputField(
                      hintText: 'UserName',
                      valid: (value) => value.isEmpty ? 'Required Field' : null,
                      controller: userNameController,
                      // icon: null,
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      errorText: _errorText,
                    ),

                    // RoundedInputField(
                    //   hintText: 'Password',
                    //   valid: (value) => value.isEmpty ? 'Required Field' : null,
                    //   controller: passwordController,
                    //   icon: null,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       pass = value;
                    //     });
                    //   },
                    // ),
                    RoundedPasswordField(
                      hinttext: 'Enter your password',
                      valid: (value) => value.isEmpty ? 'Required Field' : null,
                      onChanged: (value) {
                        setState(() {
                          pass = value;
                        });
                      },
                      errorText: _errorText,
                    ),
                    RoundedPasswordField(
                      hinttext: 'Confirm Password',
                      valid: (value) => value.isEmpty ? 'Required Field' : null,
                      controller: passwordController,
                      onChanged: (value) {
                        setState(() {
                          confirm = value;
                        });
                      },
                      errorText: _errorText,
                    ),
                    RoundedButton(
                      text: 'Signup',
                      press: () async {
                        if (username != null &&
                            pass != null &&
                            confirm != null) {
                          register();

                          print(Exception);
                        } else
                          print("enter full data ");
                      },
                    ),
                    OrDivider(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     SocalIcon(
                    //       iconSrc: "assets/icons/facebook.svg",
                    //       press: () {},
                    //     ),
                    //     SocalIcon(
                    //       iconSrc: "assets/icons/twitter.svg",
                    //       press: () {},
                    //     ),
                    //     SocalIcon(
                    //       iconSrc: "assets/icons/google-plus.svg",
                    //       press: () {},
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<AppUser> register() async {
    print("requestooooooooo");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString("userId")!;
    Requests req = new Requests();
    print("requestooooooooo");
    print(userid);

    AppUser? value = await req.Registration(username!, pass!, userid);

    if (value != null) {
      app = value;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      print("registration failed");
    }

    return app!;
  }

  String get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = confirmpasswordController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (confirm != pass) {
      return ' not same passowrrd';
    }
    // return null if the text is valid
    return 'null';
  }
}
