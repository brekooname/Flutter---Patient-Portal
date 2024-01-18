import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:soul/Screens/Login_Screen/Login.dart';
import 'package:soul/Screens/Signup_Screen/signup_screen.dart';

import 'Screens/Splash_Screen/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This is the root widget of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        maxWidth: 2460, // Increased max width for larger screens
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        background: Container(color: const Color(0xFFF5F5F5)),
      ),
      debugShowCheckedModeBanner: false,initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/': (context) => Login(),
        '/signup': (context) => SignUp(),
      },
    );
  }
}
