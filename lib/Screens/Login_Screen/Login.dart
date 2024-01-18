import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Components/rounded_button.dart';
import 'package:soul/Components/rounded_input_field.dart';
import 'package:soul/Components/rounded_password_field.dart';
import 'package:soul/Entities/userHospital.dart';
import 'package:soul/Request/requests.dart';
import 'package:soul/Screens/MainPage_Screen/main_page.dart';
import 'package:soul/Screens/Signup_Screen/verification-information.dart';

import '../../Entities/auth.dart';
import '../../constants.dart';
import '../Signup_Screen/verificationCode.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation? animation;
  UserHospital? app = UserHospital();
  String? _email, _password;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool? reset;
  Auth? auth;
  static final REQUIRED = "required";
  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
      upperBound: 100.0,
    )..addListener(() {
        setState(() {});
      });

    controller.forward();
    print(controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoginScreen();
  }
  bool isLoading = false;

  Widget _buildLoginScreen() {
    Size size = MediaQuery.of(context).size;
    double responsiveSpace = size.height * 0.03; // Adjusted for responsiveness

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08), // Responsive padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.1), // Top spacing
                    _buildLogo(size),
                    SizedBox(height: responsiveSpace),
                    _buildLoginFields(),
                    SizedBox(height: responsiveSpace),
                    _buildLoginButton(),
                    SizedBox(height: responsiveSpace),
                    _buildForgotPasswordLink(),
                    SizedBox(height: responsiveSpace),
                    _buildVerificationCodeLink(),
                    SizedBox(height: responsiveSpace),
                    _buildSignUpLink(),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.grey.withOpacity(0.5),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }



  Widget _buildLogo(Size size) {
    return Container(
      width: size.width * 0.6, // Adjusted width
      height: size.height * 0.25, // Adjusted height
      child: Image.asset(
        'assets/images/gg2.png',
        fit: BoxFit.contain,
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  Widget _buildLoginFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            RoundedInputField(
              hintText: "User Name",
              onChanged: (value) => _email = value,
              valid: (value) => value == null || value.isEmpty ? 'Required' : null,
            ),
            SizedBox(height: 15),
            RoundedPasswordField(
              hinttext: 'Password',
              onChanged: (value) => _password = value,
              valid: (value) => value == null || value.isEmpty ? 'Required' : null,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: _buildElevatedButton(
        text: "LOGIN",
        onPressed: check,
      ),
    );
  }

  Widget _buildElevatedButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: kPrimaryColor,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: TextStyle(fontSize: 18),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.25),
      ),
    );
  }


  Widget _buildForgotPasswordLink() {
    return InkWell(
      onTap: _handleForgotPassword,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: 16 * MediaQuery.of(context).textScaleFactor, // Responsive font size
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationCodeLink() {
    return InkWell(
      onTap: _handleVerificationCode,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          "Need Verification Code?",
          style: TextStyle(
            fontSize: 16,
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't Have An Account? ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          InkWell(
            onTap: _handleSignUp,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 16,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _handleForgotPassword() {
    if (_email != null) {
      reset = true;
      setFromSHared();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerificationInformation()),
      );
    } else {
      showAlertDialog1(context);
    }
  }

  void _handleVerificationCode() {
    reset = false;
    setFromSHared();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerificationCode()),
    );
  }

  void _handleSignUp() {
    reset = false;
    setFromSHared();
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => VerificationInformation(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }


  Future<Auth> getToken() async {
    Requests req = new Requests();
    Auth? value = await req.Authentication(_email!, _password!,context);
    auth = value;
    return auth!;
  }

  Future<UserHospital> log() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Requests req = new Requests();
    try {
      app = await req.Login(_email!, _password!, context);
      await getToken();
      navigateToHome();
    } catch (e) {
      // Handle error, for example, show a dialog with an error message
      print(e);
    }
    return app!;
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  void check() {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        isLoading = true;
      });
      Timer(Duration(seconds: 1), () async {
        try {
          await log();
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  void navigateToHome() {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MainPage('', '', false),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOutCubic));
        var opacityAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 800), // Adjust the duration for a smoother effect
    ));
  }

  Future<void> setFromSHared() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setBool("reset", reset!);
  }

  void showAlertDialog1(BuildContext context) {
    _showAlertDialog(context, "Please enter user name");
  }

  void showAlertDialog2(BuildContext context) {
    _showAlertDialog(context, "Please enter user name and password");
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            "Missing Username",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: kPrimaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: kPrimaryColor),
                ),
              ),
              child: Text(
                "OK",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }}