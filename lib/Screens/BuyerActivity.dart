import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyerActivity extends StatefulWidget {
  @override
  _BuyerActivityState createState() => _BuyerActivityState();
}

class _BuyerActivityState extends State<BuyerActivity> {
  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Text(
          'Buyer\'s Activity',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: pHeight * 0.04),
          ),
        ),
      ),
    );
  }
}
