import 'package:bandhunew/Classes/Activity.dart';
import 'package:bandhunew/Classes/BuyerActivityClass.dart';
import 'package:bandhunew/Screens/NewBuyerActivity.dart';
import 'package:bandhunew/Widgets/ActivityCard.dart';
import 'package:bandhunew/Widgets/BuyerActivityCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'NewActivity.dart';

class BuyerActivity extends StatefulWidget {
  @override
  _BuyerActivityState createState() => _BuyerActivityState();
}

class _BuyerActivityState extends State<BuyerActivity> {
  final dbRef = FirebaseDatabase.instance.reference().child('Users');
  final FirebaseAuth mAuth = FirebaseAuth.instance;

  List<BuyerActivityCard> buyerActivityList = List();

  getDatabaseRef() async {
    await buyerActivityList.clear();
    FirebaseUser user = await mAuth.currentUser();
    String uid = await user.uid;
    DatabaseReference dbref =
        FirebaseDatabase.instance.reference().child('Activities').child(uid);
    await dbref.once().then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = await snapshot.value;
      values.forEach((key, values) {
        print(values['Videos']);
        buyerActivityList.add(BuyerActivityCard(BuyerActivityClass(
            name: values['activtyName'],
            requirement: values['requirement'],
            key: key,
            imageList: values['Images'],
            videoList: values['Videos'])));
        print(buyerActivityList);
      });
    });
    setState(() {
      print('done');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getDatabaseRef();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 58.0),
          child: Center(
            child: Text(
              'Activities',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 25,
              )),
            ),
          ),
        ),
        backgroundColor: Color(0xFF6F35A5),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewBuyerActivity()),
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              getDatabaseRef();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: buyerActivityList.length != 0
              ? Column(
                  children: buyerActivityList,
                )
              : Center(child: Text('Please Reload')),
        ),
      ),
    );
  }
}
