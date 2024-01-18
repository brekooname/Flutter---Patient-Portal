import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

class HealthHistory extends StatefulWidget {
  @override
  _HealthHistoryState createState() => _HealthHistoryState();
}

class _HealthHistoryState extends State<HealthHistory> {
  String? currentUser, name;

  DateTime? birth;
  int? age;
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 3.0,
          shape: ContinuousRectangleBorder(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
          ),
          title: Align(
            alignment: Alignment.center,
            child: Text('Health History'),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Summery',
                      style: TextStyle(fontSize: 40, color: kPrimaryLightColor),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 8,
                            ),
                            Row(children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Information',
                                style: TextStyle(
                                    fontSize: 20, color: kPrimaryLightColor),
                              ),
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Name:'),
                                SizedBox(
                                  width: 90,
                                ),
                                Text('Age:'),
                                SizedBox(
                                  width: 70,
                                ),
                                Text('Blood Type:'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text('Height:'),
                              SizedBox(
                                width: 90,
                              ),
                              Text('Width:'),
                              SizedBox(
                                width: 70,
                              ),
                            ])
                          ]),
                      width: 350,
                      height: 120,
                      decoration: BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey)),
                    ),
                  ]),
                  SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Allergy',
                      style: TextStyle(fontSize: 20, color: kPrimaryLightColor),
                    ),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Type:'),
                      SizedBox(
                        width: 90,
                      ),
                      Text('Cause:'),
                      SizedBox(
                        width: 70,
                      ),
                      Text('Medicine:'),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Appointment',
                      style: TextStyle(fontSize: 20, color: kPrimaryLightColor),
                    ),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('physition:'),
                    SizedBox(
                      width: 120,
                    ),
                    Text('Time:'),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Status:'),
                    SizedBox(
                      width: 138,
                    ),
                    Text('Date:'),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Vital Signs',
                      style: TextStyle(fontSize: 20, color: kPrimaryLightColor),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Tempreture:'),
                      SizedBox(
                        width: 105,
                      ),
                      Text('Pulse Rate:'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Blood Presure:'),
                    SizedBox(
                      width: 90,
                    ),
                    Text('Time:'),
                    SizedBox(
                      width: 70,
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Familly History',
                      style: TextStyle(fontSize: 20, color: kPrimaryLightColor),
                    ),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Name:'),
                      SizedBox(
                        width: 140,
                      ),
                      Text('Relation:'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Disease:'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Medical History',
                      style: TextStyle(fontSize: 20, color: kPrimaryLightColor),
                    ),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    children: [
                      Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text('Chronic Disease',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text('Name:'),
                          SizedBox(
                            width: 100,
                          ),
                          Text('Medicine:'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text('Duration:'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text('Genetic Disease',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text('Name:'),
                          SizedBox(
                            width: 100,
                          ),
                          Text('Medicine:'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text('Duration:'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text('Have an Operation?',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text('Name:'),
                          SizedBox(
                            width: 100,
                          ),
                          Text('When:'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text('Where:'),
                          SizedBox(
                            width: 99,
                          ),
                          Text('Dr Name:'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text('Dr Phone:'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text('Have an Accedent?',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text('Injury Type:'),
                          SizedBox(
                            width: 100,
                          ),
                          Text('When:'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
