import 'package:flutter/material.dart';
import 'package:soul/constants.dart';
import 'package:soul/Components/addButton.dart';
import 'package:soul/Components/background.dart';

class MedicalHistory extends StatefulWidget {
  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  bool _val = false, _val2 = false, _val3 = false, _val4 = false;
  String? chMedicine, chName, chDuration;
  String? genMedicine, genName, genDuration;
  String? oprName, opWhen, hospName, drName, drPhone;
  String? injuryType, when;
  final _formKey = GlobalKey<FormState>();

  TextEditingController chNameController = TextEditingController();
  TextEditingController chMedicineController = TextEditingController();
  TextEditingController chDurationController = TextEditingController();

  TextEditingController genNameController = TextEditingController();
  TextEditingController genMedicineController = TextEditingController();
  TextEditingController genDurationController = TextEditingController();

  TextEditingController opNameController = TextEditingController();
  TextEditingController opWhenController = TextEditingController();
  TextEditingController hosNameController = TextEditingController();
  TextEditingController drNameController = TextEditingController();
  TextEditingController drPhoneController = TextEditingController();

  TextEditingController injuryTypeController = TextEditingController();
  TextEditingController whenController = TextEditingController();

  @override
  void dispose() {
    chNameController.dispose();
    chMedicineController.dispose();
    chDurationController.dispose();
    genNameController.dispose();
    genMedicineController.dispose();
    genDurationController.dispose();
    opNameController.dispose();
    opWhenController.dispose();
    hosNameController.dispose();
    drNameController.dispose();
    drPhoneController.dispose();
    injuryTypeController.dispose();
    whenController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      title: 'Add Medical History',
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            //shrinkWrap:true,
            // scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                height: 20.0,
              ),
              CheckboxListTile(
                  value: _val,
                  title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Chronic Disease')),
                  onChanged: (bool? newVal) {
                    setState(() {
                      _val = newVal!;
                    });
                  }),
              _val
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Disease Name'),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Enter The Disease Name'
                                        : null,
                                    controller: chNameController,
                                    onChanged: (value) {
                                      setState(() {
                                        chName = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Medicine'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Enter The Medicine'
                                        : null,
                                    controller: chMedicineController,
                                    onChanged: (value) {
                                      setState(() {
                                        chMedicine = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Duration'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Enter The Duration'
                                        : null,
                                    controller: chDurationController,
                                    onChanged: (value) {
                                      setState(() {
                                        chDuration = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              CheckboxListTile(
                  value: _val2,
                  title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Genetic Disease')),
                  onChanged: (bool? newVal) {
                    setState(() {
                      _val2 = newVal!;
                    });
                  }),
              _val2
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Disease Name'),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Required Field'
                                        : null,
                                    controller: genNameController,
                                    onChanged: (value) {
                                      setState(() {
                                        genName = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Medicine'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Required Field'
                                        : null,
                                    controller: genMedicineController,
                                    onChanged: (value) {
                                      setState(() {
                                        genMedicine = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Duration'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Required Field'
                                        : null,
                                    controller: genDurationController,
                                    onChanged: (value) {
                                      setState(() {
                                        genDuration = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              CheckboxListTile(
                  value: _val3,
                  title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Have an operation')),
                  onChanged: (bool? newVal) {
                    setState(() {
                      _val3 = newVal!;
                    });
                  }),
              _val3
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Operation Name'),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Required Field'
                                        : null,
                                    controller: opNameController,
                                    onChanged: (value) {
                                      setState(() {
                                        oprName = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('When'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Required Field'
                                        : null,
                                    controller: opWhenController,
                                    onChanged: (value) {
                                      setState(() {
                                        opWhen = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Hospital Name'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Required Field'
                                        : null,
                                    controller: hosNameController,
                                    onChanged: (value) {
                                      setState(() {
                                        hospName = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Doctor Name'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Required Field'
                                        : null,
                                    controller: drNameController,
                                    onChanged: (value) {
                                      setState(() {
                                        drName = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Doctor Phone'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Required Field'
                                        : null,
                                    controller: drPhoneController,
                                    onChanged: (value) {
                                      setState(() {
                                        drPhone = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              CheckboxListTile(
                  value: _val4,
                  title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Have an accident')),
                  onChanged: (bool? newVal) {
                    setState(() {
                      _val4 = newVal!;
                    });
                  }),
              _val4
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('Injury Type'),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Required Field'
                                        : null,
                                    controller: injuryTypeController,
                                    onChanged: (value) {
                                      setState(() {
                                        injuryType = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              _textLabel('When'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 45.0,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * .5,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                      shape: BoxShape.rectangle
                                      //borderRadius: BorderRadius.circular(29),
                                      ),
                                  child: TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? 'Required Field'
                                        : null,
                                    controller: whenController,
                                    onChanged: (value) {
                                      setState(() {
                                        when = value;
                                      });
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Center(
                child: AddButton(
                  text: 'Add',
                  press: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textLabel(String label) => Text(label,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 12.0, color: kPrimaryLightColor));

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}
