import 'package:bandhunew/Classes/Activity.dart';
import 'package:bandhunew/Classes/BuyerActivityClass.dart';
import 'package:bandhunew/Screens/BuyerVideoList.dart';
import 'package:bandhunew/Screens/EditActivity.dart';
import 'package:bandhunew/Screens/EditBuyerActivity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../videolistScreen.dart';

// ignore: must_be_immutable
class BuyerActivityCard extends StatefulWidget {
  BuyerActivityClass activity;
  BuildContext activitiesContext;
  BuyerActivityCard(this.activity, this.activitiesContext);
  @override
  _BuyerActivityCardState createState() => _BuyerActivityCardState();
}

class _BuyerActivityCardState extends State<BuyerActivityCard> {
  @override
  void initState() {
    super.initState();
    // getUrls();
    imageList = widget.activity.imageList;
  }

  void delete() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var ref = FirebaseDatabase.instance
        .reference()
        .child('Buyers')
        .child(user.uid)
        .child('Activities')
        .child(widget.activity.key)
        .remove();
    print(widget.activity.key);
    Scaffold.of(widget.activitiesContext).setState(() {});
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.activity.name,
                    style: TextStyle(
                      fontFamily: 'Nudi',
                      fontWeight: FontWeight.w400,
                      fontSize: 23,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          for (int i = 0; i < imageList.length; i++) {
                            print(
                                "---------------__${imageList[0]}---------------------");
                          }
                          if (imageList.length == 0 &&
                              widget.activity.videoList.length == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditBuyerActivity(
                                        activityToEdit: BuyerActivityClass(
                                          name: widget.activity.name,
                                          requirement:
                                              widget.activity.requirement,
                                          key: widget.activity.key,
                                        ),
                                        contextToRefresh:
                                            widget.activitiesContext,
                                      )),
                            );
                          }
                          if (imageList.length == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditBuyerActivity(
                                        activityToEdit: BuyerActivityClass(
                                            name: widget.activity.name,
                                            requirement:
                                                widget.activity.requirement,
                                            key: widget.activity.key,
                                            videoList:
                                                widget.activity.videoList),
                                        contextToRefresh:
                                            widget.activitiesContext,
                                      )),
                            );
                          } else if (widget.activity.videoList.length == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditBuyerActivity(
                                        activityToEdit: BuyerActivityClass(
                                          name: widget.activity.name,
                                          requirement:
                                              widget.activity.requirement,
                                          key: widget.activity.key,
                                          imageList: imageList,
                                        ),
                                        contextToRefresh:
                                            widget.activitiesContext,
                                      )),
                            );
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditBuyerActivity(
                                      activityToEdit: BuyerActivityClass(
                                          name: widget.activity.name,
                                          requirement:
                                              widget.activity.requirement,
                                          key: widget.activity.key,
                                          imageList: imageList,
                                          videoList: widget.activity.videoList),
                                      contextToRefresh:
                                          widget.activitiesContext,
                                    )),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 10, 10, 0),
                          child: Icon(
                            Icons.edit,
                            color: Color(0xFFA96DA3),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          delete();
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Icon(
                            Icons.delete,
                            color: Color(0xFFA96DA3),
                          ),
                        ),
                      ),
                    ],
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
                    'Requirement :',
                    style: GoogleFonts.varelaRound(
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
                    width: 170,
                    child: Text(
                      widget.activity.requirement,
                      style: GoogleFonts.varelaRound(
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
                height: 20,
              ),
              imageList != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GFCarousel(
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
                                  child: CachedNetworkImage(
                                    imageUrl: url,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                        height: 100,
                                        width: 100,
                                        child: GFLoader(
                                          type: GFLoaderType.ios,
                                        )),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
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
                      ))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('No Images'),
                    ),
              InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BuyerVideoList(widget.activity)),
                    );
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFA96DA3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Text(
                        'View Uploaded Videos',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.varelaRound(
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
    DatabaseReference urlRef = FirebaseDatabase.instance.reference()
      ..child('Buyers').child(uid).child('Activities');
    print(widget.activity.name);
    urlRef.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snap.value;
      imageList.clear();
      for (var key in KEYS) {
        if (key == widget.activity.key) {
          print(widget.activity.name);
          imageList = (DATA[key]['Images']);
        }
      }
      setState(() {
        print("---------------__${imageList.length}---------------------");
      });
    });
  }
}
