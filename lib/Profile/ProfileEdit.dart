import 'package:bandhunew/MyHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final dbRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _stateName;
  TextEditingController _districtName;
  TextEditingController _producerName;
  TextEditingController _fatherName;
  TextEditingController _age;
  TextEditingController _education;
  TextEditingController _religion;
  TextEditingController _sex;
  TextEditingController _maritalStatus;
  TextEditingController _address;
  TextEditingController _phNo1;
  TextEditingController _phNo2;
  TextEditingController _bankName;
  TextEditingController _accNo;
  TextEditingController _ifscCode;

  @override
  void initState() {
    _stateName = TextEditingController(text: "");
    _districtName = TextEditingController(text: "");
    _producerName = TextEditingController(text: "");
    _fatherName = TextEditingController(text: "");
    _age = TextEditingController(text: "");
    _education = TextEditingController(text: "");
    _religion = TextEditingController(text: "");
    _sex = TextEditingController(text: "");
    _maritalStatus = TextEditingController(text: "");
    _address = TextEditingController(text: "");
    _phNo1 = TextEditingController(text: "+91-");
    _phNo2 = TextEditingController(text: "+91");
    _bankName = TextEditingController(text: "");
    _accNo = TextEditingController(text: "");
    _ifscCode = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E6FF),
      appBar: AppBar(
        title: Text(
          'SET UP YOUR PROFILE',
          style: GoogleFonts.poppins(
              textStyle:
                  TextStyle(fontWeight: FontWeight.w400, letterSpacing: 7)),
        ),
        backgroundColor: Color(0xFF6F35A5),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _stateName,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter the name of your state"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _districtName,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter the name of your district"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _producerName,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter producer's Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _fatherName,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter the name of your father or husband"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _age,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your age"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _education,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your education qualification"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _religion,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your religion"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _sex,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your gender (Male, Female or Other)"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _maritalStatus,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your marital status"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _address,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your address"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.length < 14) {
                        return 'Invalid phone number';
                      } else {
                        return null;
                      }
                    },
                    controller: _phNo1,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your primary mobile number"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.length < 14) {
                        return 'Invalid phone number';
                      } else {
                        return null;
                      }
                    },
                    controller: _phNo2,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your secondary mobile number"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _bankName,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter the name of your bank"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _accNo,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your bank account number"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field can\'t be left empty';
                      } else {
                        return null;
                      }
                    },
                    controller: _ifscCode,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your bank\'s IFSC Code"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      writeData();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF6F35A5),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      width: ((MediaQuery.of(context).size).width * 0.93),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            'SUBMIT',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                letterSpacing: 5,
                                color: Colors.white,
                                fontSize: 20),
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
      ),
    );
  }

  void writeData() async {
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    dbRef.child('Users').child(uid)
      ..child('Details').set({
        'state': _stateName.text,
        'district': _districtName.text,
        'producer': _producerName.text,
        'fatherorhusband': _fatherName.text,
        'age': _age.text,
        'education': _education.text,
        'religion': _religion.text,
        'sex': _sex.text,
        'maritalStatus': _maritalStatus.text,
        'address': _address.text,
        'phNo1': _phNo1.text,
        'phNo2': _phNo2.text,
        'bankName': _bankName.text,
        'accNo': _accNo.text,
        'ifsc': _ifscCode.text
      });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }
}
