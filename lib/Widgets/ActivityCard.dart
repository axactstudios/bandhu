import 'package:bandhunew/Classes/Activity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import '../videolistScreen.dart';

// ignore: must_be_immutable
class ActivityCard extends StatefulWidget {
  Activity activity;
  ActivityCard(this.activity);
  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  void initState() {
    super.initState();
    getUrls();
  }

  List<dynamic> imageList = [];

  FirebaseAuth mAuth = FirebaseAuth.instance;

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
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: imageList.isNotEmpty
                      ? GFCarousel(
                          items: imageList.map(
                            (url) {
                              return Card(
                                elevation: 8,
                                margin: EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: Image.network(url,
                                        fit: BoxFit.cover, width: 1000.0),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          onPageChanged: (index) {
                            setState(() {
                              index;
                            });
                          },
                          enlargeMainPage: true,
                          pagination: true,
                          passiveIndicator: Colors.black,
                          activeIndicator: Colors.white,
                          pagerSize: 10,
                        )
                      : Text('No Images')),
              InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoList(widget.activity)),
                    );
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
                        'View Uploaded Videos',
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

  getUrls() async {
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    print(user.uid);
    DatabaseReference urlRef = FirebaseDatabase.instance
        .reference()
        .child('Activities')
        .child(user.uid);
    print(widget.activity.name);
    urlRef.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snap.value;
      imageList.clear();
      for (var key in KEYS) {
        if (DATA[key]['activtyName'] == widget.activity.name) {
          print(widget.activity.name);
          imageList = (DATA[key]['Images']);
        }
      }
      setState(() {
        print(imageList.length);
      });
    });
  }
}
