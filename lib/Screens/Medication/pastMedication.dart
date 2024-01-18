import 'package:flutter/material.dart';
import 'package:soul/Screens/Appoitments/commonListItem.dart';
import 'package:soul/Screens/Medication/medication.dart';
import 'package:soul/constants.dart';

class PastMedication extends StatelessWidget {
  final List<CommonListItem>? medication;

  const PastMedication({Key? key, this.medication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: queryData.size.height * 0.08,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Medication1()),
              );
            },
            child: Icon(Icons.arrow_back // add custom icons also
                ),
          ),
          title: Center(
              child: Text("Medication Result",
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
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: medication!.length,
            // The list items
            itemBuilder: (context, index) {
              return Container(
                child: medication![index],
              );
            },
          ),
        ),
      ),
    );
  }
}
