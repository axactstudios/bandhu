import 'package:bandhunew/MyHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/Profile.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final dbRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String access = 'Self';
  List<String> accessList = ['Self', 'Purchased from outside', 'Both'];

  String federation = '¸ÁUÀgÀ ¹ÛçÃ§AzsÀÄ MPÀÆÌl';
  List<String> federationList = [
    '¸ÁUÀgÀ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'gÁªÀÄZÀAzÀæ¥ÀÄgÀ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'ªÀiÁgÀÄw¥ÀÄgÀ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'ºÉÆ£Áß½ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'eÉÆÃUÀ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'eÉÃ¤ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    '¸ÉÆ£À¯É ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'ªÀÄAqÀWÀlÖ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'wÃxÀðºÀ½î ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'ºÀ¸ÀÆr ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'PÉÆÃmÉUÀAUÀÆgÀÄ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'PÉÆÃqÀÆgÀÄ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'n¥ÀÅöà£ÀUÀgÀ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    '£É®ªÁV®Ä ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'zÉÃªÀAV ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    '¨Á¼ÉPÉÆ¥Àà ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'ªÀiÁ«£ÀPÉgÉ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'PÀÄA¹ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'gÁVUÀÄqÀØ  ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'UÀAfÃ£À½î ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    '²PÁj¥ÀÅgÀ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'DAiÀÄ£ÀÆgÀÄ ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    '±ÀgÁªÀw ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'ºÁgÀ£ÀºÀ½î ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    '£ÁåªÀÄw ¹ÛçÃ§AzsÀÄ MPÀÆÌl',
    'PÁgÉÃºÀ½î ¹ÛçÃ§AzsÀÄ MPÀÆÌl'
  ];

  User userData = User();

  getDatabaseRef() async {
    FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
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
      setState(() {});
    });
  }

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
    _phNo1 = TextEditingController(text: "");
    _phNo2 = TextEditingController(text: "");
    _bankName = TextEditingController(text: "");
    _accNo = TextEditingController(text: "");
    _ifscCode = TextEditingController(text: "");
    _coordinates = TextEditingController(text: "");
    _members = TextEditingController(text: "");
    _shgName = TextEditingController(text: "");
  }

  @override
  void initState() {
    getDatabaseRef();
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
                            'Federation : ',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color(0xFF6F35A5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17),
                            ),
                          ),
                          DropdownButton(
                            dropdownColor: Color(0xFFF1E6FF),
                            value: federation,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            iconSize: 18,
                            onChanged: (String newVal) {
                              setState(() {
                                federation = newVal;
                              });
                            },
                            items: federationList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                  width: 110,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontFamily: 'Nudi'),
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
        'federation': federation,
        'shgName': _shgName.text
      });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }
}
