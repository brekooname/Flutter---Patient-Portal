import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Entities/familyMem.dart';
import '../MainPage_Screen/main_page.dart';

class FamilyMember extends StatelessWidget {
  final String? loginpatientid;
  final List<FamilyMem>? family;
  final String? Encounterid;

  FamilyMember({this.family, this.loginpatientid, this.Encounterid});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          // Limited height for family members list
          Container(
            height: 200, // Adjust the height as needed
            child: family != null && family!.isNotEmpty
                ? ListView.builder(
              itemCount: family!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.white12,
                      child: Text(family![index].patientName!),
                    ),
                    title: Text(family![index].relation.toString()),
                    subtitle: Text('More Details..'),
                    onTap: () {
                      Navigator.push(
                        context,
                          MaterialPageRoute(
                            builder: (context) => MainPage('', '', false),
                          )
                      );
                    },
                  ),
                );
              },
            )
                : Center(child: Text('No family members found')),
          ),
          // Spacing

          // Reset button
          ElevatedButton(
            onPressed: () async {
              print(loginpatientid);
              print(Encounterid);
              // SharedPreferences prefs =
              //     await SharedPreferences
              //     .getInstance();
              // await prefs.remove('patientid');
              // await prefs.remove('facilityname');
              // await prefs.remove('userid');

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage('', '', false),
                ),
              );
            },
            child: Text('Reset'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey,
              onPrimary: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
