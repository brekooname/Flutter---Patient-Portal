import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../constants.dart';
import '../MainPage_Screen/main_page.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,  // subtle elevation
          toolbarHeight: queryData.size.height * 0.08,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage('', '', false)),
              );
            },
            child: Icon(Icons.arrow_back, size: 30, color: kPrimaryColor),
          ),
          title: Center(
            child: Text(
              "Settings",
              style: TextStyle(color: kPrimaryColor, fontSize: 22),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),  // padding added
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,  // Setting container background color to white
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListView.builder(
              itemCount: 2, // you can adjust this as per the number of tiles you need
              itemBuilder: (context, index) {
                switch(index) {
                  case 0:
                    return ListTile(
                      leading: Icon(Icons.language, color: kPrimaryColor),
                      title: Text('Language'),
                      trailing: Text('English'),
                      onTap: () {
                        // Add your onTap action here
                      },
                    );
                  case 1:
                    return ListTile(
                      leading: Icon(Icons.format_paint, color: kPrimaryColor),
                      title: Text('Enable custom theme'),
                      trailing: Switch(
                        value: true, // this can be based on some variable
                        onChanged: (value) {
                          // Handle the switch toggle action here
                        },
                      ),
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
