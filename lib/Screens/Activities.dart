import 'package:bandhunew/Classes/Activity.dart';
import 'package:bandhunew/Screens/NewActivity.dart';
import 'package:bandhunew/Widgets/ActivityCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyActivities extends StatefulWidget {
  @override
  _MyActivitiesState createState() => _MyActivitiesState();
}

class _MyActivitiesState extends State<MyActivities> {
  final dbRef = FirebaseDatabase.instance.reference().child('Users');
  final FirebaseAuth mAuth = FirebaseAuth.instance;

  List<ActivityCard> activityList = List();

  getDatabaseRef() async {
    await activityList.clear();
    FirebaseUser user = await mAuth.currentUser();
    String uid = await user.uid;
    DatabaseReference dbref =
        FirebaseDatabase.instance.reference().child('Activities').child(uid);
    await dbref.once().then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = await snapshot.value;
      values.forEach((key, values) {
        print(values['Videos']);
        activityList.add(ActivityCard(Activity(
            name: values['activtyName'],
            rawMaterial: values['rawMaterial'],
            avgProduction: values['avgProduction'],
            key: key,
            imageList: values['Images'],
            videoList: values['Videos'])));
        print(activityList);
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
        backgroundColor: Color(0xFFA96DA3),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewActivity()),
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
          alignment: Alignment.center,
          child: activityList.length != 0
              ? Column(
                  children: activityList,
                )
              : Center(child: Text('No Activities')),
        ),
      ),
    );
  }
}
