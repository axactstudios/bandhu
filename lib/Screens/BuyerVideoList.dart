import 'package:bandhunew/Classes/BuyerActivityClass.dart';
import 'package:bandhunew/videoPlayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class BuyerVideoList extends StatefulWidget {
  BuyerActivityClass activity;
  BuyerVideoList(this.activity);
  @override
  _BuyerVideoListState createState() => _BuyerVideoListState();
}

class _BuyerVideoListState extends State<BuyerVideoList> {
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  List<dynamic> vidList = <dynamic>[];
  @override
  void initState() {
    getUrls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFA96DA3),
          title: Text('Videos'),
        ),
        body: vidList != null
            ? ListView(
                children: [
                  for (int i = 0; i < vidList.length; i++) card(vidList[i], i)
                ],
              )
            : Container(
                child: SafeArea(
                    child: Center(
                  child: Text(
                    'NO VIDEOS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                )),
              ));
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
      vidList.clear();
      for (var key in KEYS) {
        if (key == widget.activity.key) {
          print(widget.activity.name);
          vidList = (DATA[key]['Videos']);
        }
      }
      setState(() {
        print('vidList.length');
      });
    });
  }

  Widget card(url, i) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoPlayerScreen(url)),
        );
      },
      child: Container(
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
                  'Video ${i + 1}',
                  style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
