import 'package:bandhunew/Classes/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final dbRef = FirebaseDatabase.instance.reference().child('Users');
  final FirebaseAuth mAuth = FirebaseAuth.instance;

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
          'MY PROFILE',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 20, letterSpacing: 7, fontWeight: FontWeight.w400)),
        ),
        backgroundColor: Color(0xFF6F35A5),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            width: size.width,
            child: Column(
              children: <Widget>[
                userData.stateName != null
                    ? Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'State      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.stateName,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.districtName != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'District      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.districtName,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.producerName != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Producer      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.producerName,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.fatherName != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Father / Husband      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.fatherName,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.age != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Age      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '${userData.age}',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.education != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Education      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.education,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.religion != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Religion      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.religion,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.sex != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Sex      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.sex,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.maritalStatus != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Marital Status      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.maritalStatus,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.address != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Address      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.address,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.phNo1 != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Primary Number      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.phNo1,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.phNo2 != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Secondary Number      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.phNo2,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.bankName != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Bank Name      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.bankName,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.accNo != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Account Number      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.accNo,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
                        ),
                      ),
                userData.ifscCode != null
                    ? Card(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 35),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Color(0xFF6F35A5),
                        child: Container(
                          width: size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'IFSC Code      : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  userData.ifscCode,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: SpinKitWave(
                          color: Color(0xFF6F35A5),
                          size: 30,
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
