import 'package:bandhunew/MyHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/Profile.dart';

class ProfileUpdate extends StatefulWidget {
  String stateName,
      districtName,
      producerName,
      fatherName,
      age,
      education,
      religion,
      sex,
      maritalStatus,
      address,
      phNo1,
      phNo2,
      bankName,
      accNo,
      ifscCode,
      coordinates,
      members,
      access,
      shgName;
  ProfileUpdate(
      this.stateName,
      this.districtName,
      this.producerName,
      this.fatherName,
      this.age,
      this.education,
      this.religion,
      this.sex,
      this.maritalStatus,
      this.address,
      this.phNo1,
      this.phNo2,
      this.bankName,
      this.accNo,
      this.ifscCode,
      this.coordinates,
      this.members,
      this.access,
      this.shgName);
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final dbRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String access = 'Self';
  List<String> accessList = ['Self', 'Purchased from outside', 'Both'];

//  String federation = '¸ÁUÀgÀ ¹ÛçÃ§AzsÀÄ MPÀÆÌl';
//  List<String> federationList = [
//    '¸ÁUÀgÀ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
//    'gÁªÀÄZÀAzÀæ¥ÀÄgÀ ¹ÛçÃ§AzsÀÄ MPÀÆÌl'
//  ];

  User userData = User();

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
  TextEditingController _coordinates;
  TextEditingController _members;
  TextEditingController _shgName;

  initialize() {
    _stateName = TextEditingController(text: widget.stateName);
    _districtName = TextEditingController(text: widget.districtName);
    _producerName = TextEditingController(text: widget.producerName);
    _fatherName = TextEditingController(text: widget.fatherName);
    _age = TextEditingController(text: widget.age);
    _education = TextEditingController(text: widget.education);
    _religion = TextEditingController(text: widget.religion);
    _sex = TextEditingController(text: widget.sex);
    _maritalStatus = TextEditingController(text: widget.maritalStatus);
    _address = TextEditingController(text: widget.address);
    _phNo1 = TextEditingController(text: widget.phNo1);
    _phNo2 = TextEditingController(text: widget.phNo2);
    _bankName = TextEditingController(text: widget.bankName);
    _accNo = TextEditingController(text: widget.accNo);
    _ifscCode = TextEditingController(text: widget.ifscCode);
    _coordinates = TextEditingController(text: widget.coordinates);
    _members = TextEditingController(text: widget.members);
    _shgName = TextEditingController(text: widget.shgName);
    access = widget.access;
  }

  @override
  void initState() {
    initialize();
  }

  Widget spacer() {
    return SizedBox(
      height: 16,
    );
  }

  double radius = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E6FF),
      appBar: AppBar(
        title: Text(
          'Bandhu',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            fontWeight: FontWeight.w400,
          )),
        ),
        backgroundColor: Color(0xFF6F35A5),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Profile Setup',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          color: Colors.purple)),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "State Name"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "District"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Producer's Name"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Father/Husband's Name"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Age"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Education qualification"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Religion"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Gender (Male, Female or Other)"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Marital status"),
                  ),
                ),
                spacer(),
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
                    maxLines: 4,
                    minLines: 3,
                    controller: _address,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your address"),
                  ),
                ),
                spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.length < 13) {
                        return 'Invalid phone number';
                      } else {
                        return null;
                      }
                    },
                    controller: _phNo1,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Primary mobile number"),
                  ),
                ),
                spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.length < 13) {
                        return 'Invalid phone number';
                      } else {
                        return null;
                      }
                    },
                    controller: _phNo2,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Secondary mobile number"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Bank name"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Bank account number"),
                  ),
                ),
                spacer(),
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
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Bank\'s IFSC Code"),
                  ),
                ),
                spacer(),
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
                    controller: _coordinates,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Your co-ordinates"),
                  ),
                ),
                spacer(),
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
                    controller: _members,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Number of members"),
                  ),
                ),
                spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Access : ',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color(0xFF6F35A5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17),
                            ),
                          ),
                          DropdownButton(
                            dropdownColor: Color(0xFFF1E6FF),
                            underline: Container(
                              color: Color(0xFFF1E6FF),
                            ),
                            value: access,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFF6F35A5),
                            ),
                            iconSize: 18,
                            onChanged: (String newVal) {
                              setState(() {
                                access = newVal;
                              });
                            },
                            items: accessList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Color(0xFF6F35A5),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                spacer(),
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
                    controller: _shgName,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.w400),
                        ),
                        hintText: "Enter your SHG Name"),
                  ),
                ),
                spacer(),
//                Padding(
//                  padding: const EdgeInsets.all(4.0),
//                  child: Container(
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(radius),
//                        border: Border.all(color: Colors.black)),
//                    child: Padding(
//                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text(
//                            'Federation : ',
//                            style: GoogleFonts.poppins(
//                              textStyle: TextStyle(
//                                  color: Color(0xFF6F35A5),
//                                  fontWeight: FontWeight.w400,
//                                  fontSize: 17),
//                            ),
//                          ),
//                          DropdownButton(
//                            dropdownColor: Color(0xFFF1E6FF),
//                            value: federation,
//                            icon: Icon(
//                              Icons.arrow_drop_down,
//                              color: Colors.white,
//                            ),
//                            iconSize: 18,
//                            onChanged: (String newVal) {
//                              setState(() {
//                                federation = newVal;
//                              });
//                            },
//                            items: federationList
//                                .map<DropdownMenuItem<String>>((String value) {
//                              return DropdownMenuItem<String>(
//                                value: value,
//                                child: Text(
//                                  value,
//                                  style: GoogleFonts.poppins(
//                                    textStyle: TextStyle(
//                                      color: Color(0xFF6F35A5),
//                                    ),
//                                  ),
//                                ),
//                              );
//                            }).toList(),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//                spacer(),
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
                                letterSpacing: 2,
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
        'ifsc': _ifscCode.text,
        'coordinates': _coordinates.text,
        'members': _members.text,
        'access': access,
        'shgName': _shgName.text
      });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }
}
