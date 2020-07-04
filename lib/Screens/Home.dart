import 'package:bandhunew/auth/SignInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Text(
                'Home',
                style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 25)),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: RaisedButton(
                color: Color(0xFF6F35A5),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  pushNewScreen(context,
                      screen: SignInPage(), withNavBar: false);
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(33)),
                child: Text(
                  'Sign Out',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
