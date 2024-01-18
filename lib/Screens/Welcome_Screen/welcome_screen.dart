import 'package:flutter/material.dart';
import 'package:soul/Components/rounded_button.dart';
import 'package:soul/constants.dart';
import 'package:soul/Screens/Signup_Screen/signup_screen.dart';
import 'package:soul/Screens/Login_Screen/Login.dart';
import 'package:soul/Components/circular_image.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
    color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CirculerImage(imageName: 'welcom.png',width: 200.0,height: 200.0,),
          SizedBox(height:30.0 ,),
          RoundedButton(
            text: 'Login',
            color: kPrimaryColor,
            press: (){
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation,
                      Widget child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.easeIn);
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                      alignment: Alignment.center,
                    );
                  },
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation) {
                    return Login();
                  },
                ),
              );
            },
          ),
          RoundedButton(
            text: 'Sign up',
            color: kPrimarySecColor,
            press: (){
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation,
                      Widget child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.easeIn);
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                      alignment: Alignment.center,
                    );
                  },
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation) {
                    return SignUp();
                  },
                ),
              );

            },
          )
        ],
      ),);


  }
}
