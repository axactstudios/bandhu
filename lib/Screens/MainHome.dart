import 'package:bandhunew/MyHomePage.dart';
import 'package:bandhunew/Profile/BuyerProfileEdit.dart';
import 'package:bandhunew/Screens/BuyerDashboard.dart';
import 'package:bandhunew/Screens/BuyerForm.dart';
import 'package:bandhunew/Screens/BuyerHome.dart';
import 'package:bandhunew/Screens/Home.dart';
import 'package:bandhunew/Screens/NewBuyerScreen.dart';
import 'package:bandhunew/auth/SignInPage.dart';
import 'package:diagonal/diagonal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  FirebaseAuth mAuth = FirebaseAuth.instance;

  bool isSignedIn, isCompleted;

  void getStatus() async {
    FirebaseUser currentUser = await mAuth.currentUser();
    if (currentUser != null) {
      setState(() {
        isSignedIn = true;
        print(isSignedIn);
      });
      DatabaseReference dbref = FirebaseDatabase.instance
          .reference()
          .child('Buyers')
          .child(currentUser.uid)
          .child('Details');
      await dbref.once().then((DataSnapshot snap) async {
        // ignore: non_constant_identifier_names
        isCompleted = await snap.value['isCompleted'];
        setState(() {
          print(isCompleted);
          print('All statuses have been updated\n\n');
        });
      });
    } else {
      isSignedIn = false;
      setState(() {
        print('--------Is the user signed in? $isSignedIn -------------------');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              // ignore: unnecessary_statements
              (isCompleted != null
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BuyerHome(),
                      ),
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BuyerRegisterForm(),
                      ),
                    ));
            },
            child: Diagonal(
              child: Container(
                height: pHeight * 0.475,
                width: pWidth,
                color: Color(0xFFA96DA3),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: pHeight * 0.08,
                      ),
                      Image.asset(
                        'assets/buyer.png',
                        height: pHeight * 0.2,
                      ),
                      SizedBox(
                        height: pHeight * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: pWidth * 0.04,
                          ),
                          Text(
                            'CONTINUE AS A\nBUYER',
                            style: GoogleFonts.varelaRound(
                                textStyle: TextStyle(
                                    fontSize: pHeight * 0.03,
                                    color: Color(0xFFF1E6FF))),
                          ),
                          SizedBox(
                            width: pWidth * 0.1,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xFFF1E6FF),
                            size: pHeight * 0.06,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              clipHeight: pHeight * 0.1,
              position: Position.BOTTOM_LEFT,
            ),
          ),
          Text(
            'OR',
            style: GoogleFonts.varelaRound(
              textStyle: TextStyle(fontSize: pHeight * 0.035),
            ),
          ),
          Diagonal(
            child: InkWell(
              onTap: () async {
                FirebaseUser currentUser = await mAuth.currentUser();
                print(currentUser);
                currentUser == null
                    ? Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInPage(
                            userType: 'Seller',
                          ),
                        ),
                      )
                    : Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
              },
              child: Container(
                color: Color(0xFFF1E6FF),
                height: pHeight * 0.475,
                width: pWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: pHeight * 0.08,
                      ),
                      Image.asset(
                        'assets/seller.png',
                        height: pHeight * 0.2,
                      ),
                      SizedBox(
                        height: pHeight * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.chevron_left,
                            color: Color(0xFFA96DA3),
                            size: pHeight * 0.06,
                          ),
                          SizedBox(
                            width: pWidth * 0.1,
                          ),
                          Text(
                            'CONTINUE AS A\nSELLER',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.varelaRound(
                              textStyle: TextStyle(
                                fontSize: pHeight * 0.025,
                                color: Color(0xFFA96DA3),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: pWidth * 0.06,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            clipHeight: pHeight * 0.1,
            position: Position.TOP_RIGHT,
          ),
        ],
      ),
    );
  }
}
