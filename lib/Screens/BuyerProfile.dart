import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyerProfile extends StatefulWidget {
  @override
  _BuyerProfileState createState() => _BuyerProfileState();
}

class _BuyerProfileState extends State<BuyerProfile> {
  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Text(
          'Buyer\'s Profile',
          style: GoogleFonts.varelaRound(
            textStyle: TextStyle(fontSize: pHeight * 0.04),
          ),
        ),
      ),
    );
  }
}
