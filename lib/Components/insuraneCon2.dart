import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul/Components/insuranceContain.dart';


class InsuranceCon2 extends StatelessWidget {
  final String? name;
  final String? plan, status, dedtype, dedamount, expd;

  const InsuranceCon2({Key? key,
    this.name,
    this.plan,
    this.status,
    this.dedtype,
    this.dedamount,
    this.expd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                Color(0xFA00568A),
                Color(0xFF034C81),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            child: SingleChildScrollView( // Added SingleChildScrollView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.card_membership, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          name!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis, // Prevents text overflow
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.white54, thickness: 1.5),
                  SizedBox(height: 10),
                  insuranceCon2(text1: "Plan", text2: plan!),
                  insuranceCon2(text1: "Status", text2: status!),
                  insuranceCon2(text1: "Deduction Type", text2: dedtype!),
                  insuranceCon2(text1: "Deduction Amount", text2: dedamount!),
                  insuranceCon2(text1: "Expiration Date", text2: expd!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget insuranceCon2({required String text1, required String text2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          Text(text2, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
