import 'package:flutter/material.dart';
import 'package:soul/constants.dart';
import 'package:soul/Components/rounded_input_field.dart';
import 'package:soul/Components/addButton.dart';
import 'package:soul/Components/background.dart';

class FamilyHistory extends StatefulWidget {
  @override
  _FamilyHistoryState createState() => _FamilyHistoryState();
}

class _FamilyHistoryState extends State<FamilyHistory> {
  final _formKey = GlobalKey<FormState>();
  String? relation, disease, personName;

  TextEditingController relationController = TextEditingController();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController personNameController = TextEditingController();

  @override
  void dispose() {
    relationController.dispose();
    diseaseController.dispose();
    personNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      title: 'Add Family History',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            _textLabel('Relation'),
            RoundedInputField(
              valid: (value) => value.isEmpty ? 'Required Field' : null,
              controller: relationController,
              //  icon: null,
              onChanged: (value) {
                setState(() {
                  relation = value;
                });
              },
            ),
            _textLabel('Disease'),
            RoundedInputField(
              valid: (value) => value.isEmpty ? 'Required Field' : null,
              controller: diseaseController,
              //  icon: null,
              onChanged: (value) {
                setState(() {
                  disease = value;
                });
              },
            ),
            _textLabel('Person Name'),
            RoundedInputField(
              valid: (value) => value.isEmpty ? 'Required Field' : null,
              controller: personNameController,
              //icon: null,
              onChanged: (value) {
                setState(() {
                  personName = value;
                });
              },
            ),
            Center(
              child: AddButton(
                text: 'Add',
                press: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      _showSnackBar(context, 'Added');
                    }
                    relationController.clear();
                    diseaseController.clear();
                    personNameController.clear();
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _textLabel(String label) => Text(label,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 18.0, color: kPrimaryLightColor));

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}
