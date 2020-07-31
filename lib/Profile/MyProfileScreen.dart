import 'package:bandhunew/Classes/Profile.dart';
import 'package:bandhunew/Profile/ProfileUpdate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final dbRef = FirebaseDatabase.instance.reference().child('Users');
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  double size1 = 15;

  User userData = User();

  getDatabaseRef() async {
    FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    var ref = dbRef.child(uid).child('Details');
    DatabaseReference dbref = FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(uid)
        .child('Details');
    await dbref.once().then((DataSnapshot snap) async {
      // ignore: non_constant_identifier_names
      userData.stateName = await snap.value['state'];
      userData.districtName = await snap.value['district'];
      userData.producerName = await snap.value['producer'];
      userData.fatherName = await snap.value['fatherorhusband'];
      userData.age = await snap.value['age'];
      userData.education = await snap.value['education'];
      userData.religion = await snap.value['religion'];
      userData.sex = await snap.value['sex'];
      userData.maritalStatus = await snap.value['maritalStatus'];
      userData.address = await snap.value['address'];
      userData.phNo1 = await snap.value['phNo1'];
      userData.phNo2 = await snap.value['phNo2'];
      userData.bankName = await snap.value['bankName'];
      userData.accNo = await snap.value['accNo'];
      userData.ifscCode = await snap.value['ifsc'];
      userData.coordinates = await snap.value['coordinates'];
      userData.members = await snap.value['members'];
      userData.access = await snap.value['access'];
      userData.shgName = await snap.value['shgName'];
      userData.federationName = await snap.value['federation'];
      userData.userType = await snap.value['userType'];
      setState(() {});
    });
  }

  @override
  void initState() {
    getDatabaseRef();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF1E6FF),
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.varelaRound(
              textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w400)),
        ),
        backgroundColor: Color(0xFFA96DA3),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                pushNewScreen(context,
                    screen: ProfileUpdate(
                        userData.stateName,
                        userData.districtName,
                        userData.producerName,
                        userData.fatherName,
                        userData.age,
                        userData.education,
                        userData.religion,
                        userData.sex,
                        userData.maritalStatus,
                        userData.address,
                        userData.phNo1,
                        userData.phNo2,
                        userData.bankName,
                        userData.accNo,
                        userData.ifscCode,
                        userData.coordinates,
                        userData.members,
                        userData.access,
                        userData.shgName,
                        userData.userType),
                    withNavBar: false);
              },
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
              width: size.width,
              child: userData.stateName != null
                  ? Column(children: <Widget>[
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'User Type :',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text(
                                    userData.userType,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.varelaRound(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.only(top: 15),
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'State:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.stateName,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'District:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.districtName,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Producer:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: size.width * 0.5,
                                  child: Text(
                                    userData.producerName,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.varelaRound(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Father / Husband:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text(
                                    userData.fatherName,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.varelaRound(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Age:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '${userData.age}',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Education:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.education,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Religion:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.religion,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Sex:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.sex,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Marital Status:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.maritalStatus,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Address:',
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: size.width * 0.5,
                                  child: Text(
                                    userData.address,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.varelaRound(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Primary Number:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.phNo1,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Secondary Number:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.phNo2,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Bank Name:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.bankName,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Account Number:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.accNo,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'IFSC Code:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.ifscCode,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Coordinates:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.coordinates,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Number of Members:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.members,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Access:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.access,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'SHG Name:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.shgName,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 35),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFFA96DA3),
                        child: Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Federation:',
                                  style: GoogleFonts.varelaRound(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: size1,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    userData.federationName,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontFamily: 'Nudi',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ])
                  : Center(
                      child: SpinKitWave(
                        color: Color(0xFFA96DA3),
                        size: 30,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
