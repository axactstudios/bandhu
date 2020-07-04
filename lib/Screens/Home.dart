import 'package:bandhunew/Classes/delayed_animation.dart';
import 'package:bandhunew/auth/SignInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../Profile/MyProfileScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final int delayedAmount = 500;

  String dropdownitem = 'Profile';
  List<String> newList = ['Profile', 'My Documents', 'Activity'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6F35A5),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    pushNewScreen(context,
                        screen: SignInPage(), withNavBar: false);
                  },
                  child: Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DelayedAnimation(
                child: Image.asset('assets/bandhu.png'),
                delay: delayedAmount + 1000,
              ),
              DelayedAnimation(
                child: Container(
                  color: Colors.white,
                  child: Text(
                    'Welcome to Bandhu',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                delay: delayedAmount + 2000,
              ),
              DelayedAnimation(
                child: Container(
                  color: Colors.white,
                  child: Text(
                    'An initiative to promote self reliant India and empower its citizens',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                delay: delayedAmount + 3000,
              ),
              DelayedAnimation(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  color: Colors.white,
                  child: Text(
                    'Use the menu options to manage your profile, list activities and pictures/videos to promote your products.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
//              RaisedButton(
//                padding: EdgeInsets.fromLTRB(148, 10, 148, 10),
//                color: Color(0xFF6F35A5),
//                onPressed: () {
//                },
//                shape: RoundedRectangleBorder(
//                    side: BorderSide(color: Colors.white),
//                    borderRadius: BorderRadius.circular(33)),
//                child: Text(
//                  'Sign Out',
//                  style: GoogleFonts.poppins(
//                    textStyle: TextStyle(
//                        fontWeight: FontWeight.w400,
//                        color: Colors.white,
//                        fontSize: 20),
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
