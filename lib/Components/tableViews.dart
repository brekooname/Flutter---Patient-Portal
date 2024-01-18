import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soul/Entities/orders.dart';
import 'package:soul/constants.dart';

class TableViews extends StatelessWidget {
  final List<Order>? result;
  TableViews({Key? key, @required this.result});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: result?.length ?? 0,
        itemBuilder: (context, index) {
          final order = result![index];
          return Card(
            color: Colors.white,
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.lightBlue.shade50),
            ),
            child: ListTile(
              leading: Icon(Icons.medical_services, color: Colors.blue),
              title: Text(
                order.productName ?? 'N/A',
                style: TextStyle(color: Colors.blueGrey),
              ),
              subtitle: Text(
                'Result: ${order.resultName ?? 'N/A'}\nUnit: ${order.resultUnit ?? 'N/A'}\nRange: ${order.test_Normal_Range ?? 'N/A'}',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              trailing: IconButton(
                icon: Icon(Icons.share, color: Colors.blue),
                onPressed: () => _showActionSheet(context),
              ),
              onTap: () {
                // Additional actions on tap, if any
              },
            ),
          );
        },
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _actionSheetOption('WhatsApp', 'assets/icons/whatsapp-svgrepo-com.svg', () {}),
              _actionSheetOption('Email', Icons.email, () {}),
              _actionSheetOption('SMS', Icons.sms, () {}),
            ],
          ),
        );
      },
    );
  }

  Widget _actionSheetOption(String title, dynamic icon, VoidCallback onTap) {
    return GestureDetector(
      child: ListTile(
        leading: icon is IconData
            ? Icon(icon, color: Colors.blue)
            : SvgPicture.asset(icon, height: 25.0, width: 25.0, color: Colors.blue),
        title: Text(title, style: TextStyle(color: Colors.blueGrey)),
      ),
      onTap: onTap,
    );
  }
}
