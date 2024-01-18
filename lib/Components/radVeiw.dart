//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:soul/Entities/radRes.dart';
import 'package:soul/constants.dart';
import 'package:url_launcher/url_launcher.dart';


class RadView extends StatelessWidget {
  final RadRes? report;

  RadView({Key? key, @required this.report}) : super(key: key);

  @override

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(report!.orderDate!))}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
          ),
          Divider(color: Colors.blueGrey.shade100, thickness: 1),
          SizedBox(height: 8),
          _infoRow('Order ID:', report!.orderID),
          _infoRow('Physician:', report!.orderingPhysician),
          _infoRow('Status:', report!.status),
          _infoRow('Examination Date:', DateFormat('yyyy-MM-dd').format(DateTime.parse(report!.examinationDate!))),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _iconButton(
                icon: Icons.description_outlined,
                label: 'Report',
                onTap: () {}, // Your onTap logic here
              ),
              _iconButton(
                icon: Icons.image_outlined,
                label: 'Image',
                onTap: () {
                  _launchURL('https://google.com'); // URL for the image
                },
              ),
              _iconButton(
                icon: Icons.share_outlined,
                label: 'Share',
                onTap: () {
                  showActionsheet(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: kPrimaryColor, size: 24),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  showActionsheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Choose An Option'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('report'),
            onPressed: () {
              // Navigator.pop(context, 'Delete For Me');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('image'),
            onPressed: () {
              // Navigator.pop(context, 'Delete For Me');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Both'),
            onPressed: () {
              // Navigator.pop(context, 'Delete For Me');
            },
          ),

          // CupertinoActionSheetAction(
          //   child: const Text('Delete For Everyone'),
          //   isDestructiveAction: true,
          //   onPressed: () {
          //   //  Navigator.pop(context, 'Delete For Everyone');
          //   },
          // ),
        ],
        message: CupertinoActionSheetAction(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              width: 50,
            ),
            SvgPicture.asset(
              'assets/icons/gmail-logo-2561.svg',
              height: 40.0,
              width: 40.0,
            ),
            SizedBox(
              width: 30,
            ),
            SvgPicture.asset(
              'assets/icons/facebook-messenger-2881.svg',
              height: 40.0,
              width: 40.0,
            ),
            SizedBox(
              width: 30,
            ),
            SvgPicture.asset(
              'assets/icons/whatsapp-logo-4466.svg',
              height: 40.0,
              width: 40.0,
            ),
          ]),
          onPressed: () {},
        ),
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
        ),
      ),
      barrierDismissible: true,
    );
  }
}
