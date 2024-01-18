import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soul/Entities/medication.dart'; // Ensure this import is correct
import 'package:soul/constants.dart'; // Ensure any custom constants are correctly imported

class CommonListItem extends StatelessWidget {
  final void Function()? onItemClicked;
  final String? firstTitle; // date
  final String? secondTitle;
  final IconData? secondTitleIcon;
  final String? thirdTitle; // doctor name
  final IconData? thirdTitleIcon;
  final String? fourthTitle; // department name
  final IconData? fourthTitleIconFront;
  final IconData? fourthTitleIconRear;
  final String? EncounterId;
  final String? PageTYpe;
  final String? Prescid;
  final List<Medication>? medicationDetails;

  const CommonListItem({
    Key? key,
    this.onItemClicked,
    this.firstTitle,
    this.secondTitle,
    this.secondTitleIcon,
    this.thirdTitle,
    this.thirdTitleIcon,
    this.fourthTitle,
    this.fourthTitleIconFront,
    this.fourthTitleIconRear,
    this.EncounterId,
    this.PageTYpe,
    this.Prescid,
    this.medicationDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (firstTitle != null)
              Text(
                firstTitle!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            SizedBox(height: 10),
            if (thirdTitle != null)
              Row(
                children: [
                  Icon(
                    thirdTitleIcon,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      thirdTitle!,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 10),
            if (medicationDetails != null && medicationDetails!.isNotEmpty)
              ExpansionTile(
                title: Text('Dose Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                children: medicationDetails!.map((dose) {
                  String formattedDate = DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.parse(dose.OrderedDate!));
                  return ListTile(
                    title: Text(
                      '${dose.medicationDescription ?? 'No Description'} - $formattedDate',
                      style: TextStyle(fontSize: 15),
                    ),
                    subtitle: Text(
                      "Instructions: ${dose.instruction ?? 'No instructions'}",
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
