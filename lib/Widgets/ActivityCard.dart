import 'package:bandhunew/Classes/Activity.dart';
import 'package:bandhunew/Screens/LinksScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityCard extends StatefulWidget {
  Activity activity;
  ActivityCard(this.activity);
  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  List<String> urls = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Color(0xFFF1E6FF),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20, bottom: 20),
          child: Column(
            children: <Widget>[
              Text(
                widget.activity.name,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 23,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Raw Material :\nUsed',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 190,
                    child: Text(
                      widget.activity.rawMaterial,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Production :',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.activity.avgProduction,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.green),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    getUrls(widget.activity.name);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF6F35A5),
                    borderRadius: BorderRadius.circular(33),
                  ),
                  width: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Text(
                        'View Uploaded\nImages and Videos',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getUrls(String activityName) async {
    urls.clear();
    FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    DatabaseReference dbref = FirebaseDatabase.instance
        .reference()
        .child('Activities')
        .child(uid)
        .child('Activity Doc Links')
        .child(activityName);
    await dbref.once().then((DataSnapshot snapshot) async {
      List<dynamic> values = await snapshot.value;
      for (int i = 0; i < values.length; i++) {
        var linkref = dbref.child(i.toString());
        await linkref.once().then((DataSnapshot snapshot) async {
          String link = await snapshot.value['Link'];
          urls.add(link);
          print(link);
        });
      }
    });
    setState(() {
      print('ululululu');
    });

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LinksScreen(
                urls: urls,
              )),
    );
  }
}
//Expanded(
//flex: 1,
//child: FlatButton.icon(
//onPressed: () {
////                                  launchUrl(Links.aadharlink);
//},
//icon: Icon(Icons.visibility),
//label: Text('View')),
//)
