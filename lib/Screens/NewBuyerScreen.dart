import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer2/mailer.dart';

class NewBuyer extends StatefulWidget {
  @override
  _NewBuyerState createState() => _NewBuyerState();
}

class _NewBuyerState extends State<NewBuyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA96DA3),
        title: Text(
          'New Buyer',
          style: GoogleFonts.varelaRound(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'Your registration request is sent to Net Analytiks. We will contact you soon for completing the process!',
            textAlign: TextAlign.center,
            style: GoogleFonts.varelaRound(
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
