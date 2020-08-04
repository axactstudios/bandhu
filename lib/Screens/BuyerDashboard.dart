import 'package:bandhunew/Classes/delayed_animation.dart';
import 'package:bandhunew/Profile/BuyerProfileScreen.dart';
import 'package:bandhunew/Screens/BuyerActivity.dart';
import 'package:bandhunew/Screens/BuyerDocuments.dart';
import 'package:bandhunew/Screens/BuyerProfile.dart';
import 'package:bandhunew/Screens/FAQ.dart';
import 'package:bandhunew/Screens/MainHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

class BuyerDashboard extends StatefulWidget {
  @override
  _BuyerDashboardState createState() => _BuyerDashboardState();
}

class _BuyerDashboardState extends State<BuyerDashboard> {
  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(Choice choice) {
    switch (choice.title) {
      case 'Main Home':
        pushNewScreen(context, screen: MainHome(), withNavBar: false);
        break;
      case 'Profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BuyerProfileScreen()),
        );
        break;
      case 'Documents':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BuyerDocuments()),
        );
        break;
      case 'Activities':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BuyerActivity()),
        );
        break;
      case 'FAQs':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FAQ()),
        );
        break;
    }

    setState(() {
      _selectedChoice = choice;
    });
  }

  final int delayedAmount = 500;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA96DA3),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PopupMenuButton<Choice>(
                onSelected: _select,
                itemBuilder: (BuildContext context) {
                  return choices.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: Text(choice.title),
                    );
                  }).toList();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    pushNewScreen(context,
                        screen: MainHome(), withNavBar: false);
                  },
                  child: Icon(
                    Icons.exit_to_app,
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
                    style: GoogleFonts.varelaRound(
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
                    style: GoogleFonts.varelaRound(
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
                    style: GoogleFonts.varelaRound(
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
//                  style: GoogleFonts.varelaRound(
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

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Main Home', icon: Icons.home),
  const Choice(title: 'Profile', icon: Icons.directions_bus),
  const Choice(title: 'Documents', icon: Icons.directions_railway),
  const Choice(title: 'Activities', icon: Icons.directions_walk),
  const Choice(title: 'FAQs', icon: Icons.question_answer),
];
