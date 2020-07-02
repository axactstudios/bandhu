import 'dart:io';

import 'package:bandhunew/Classes/Documents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDocuments extends StatefulWidget {
  @override
  _MyDocumentsState createState() => _MyDocumentsState();
}

class _MyDocumentsState extends State<MyDocuments> {
  final dbRef = FirebaseDatabase.instance.reference().child('Users');

  Documents Links = Documents();

  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';

  Future getAadhar() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    var aadharref = dbRef.child(uid).child('Documents').child('Aadhar');

    await aadharref.once().then((DataSnapshot snapshot) async {
      setState(() async {
        Links.aadharlink = await snapshot.value['Link'];
        print(Links.aadharlink);
      });
    });
  }

  Future getPan() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    var panref = dbRef.child(uid).child('Documents').child('PAN Card');

    await panref.once().then((DataSnapshot snapshot) async {
      setState(() async {
        Links.panlink = await snapshot.value['Link'];
        print(Links.panlink);
      });
    });
  }

  Future getGst() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    var gstref = dbRef.child(uid).child('Documents').child('GST or TIN');

    await gstref.once().then((DataSnapshot snapshot) async {
      setState(() async {
        Links.gstlink = await snapshot.value['Link'];
        print(Links.gstlink);
      });
    });
  }

  @override
  void initState() {
    getAadhar();
    getPan();
    getGst();
    super.initState();
  }

  void _uploadFile(File file, String filename) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://bandhu-d4b07.appspot.com');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    StorageReference storageReference;
    storageReference = _storage.ref().child("Documents/${user.uid}/$fileType");

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    dbRef.child(user.uid).child('Documents').child(fileType).set({'Link': url});
    Fluttertoast.showToast(
        msg: 'Upload Complete', gravity: ToastGravity.CENTER);
    setState(() {
      if (fileType == 'Aadhar') {
        Links.aadharlink = url;
      } else if (fileType == 'PAN Card') {
        Links.panlink = url;
      } else {
        Links.gstlink = url;
      }
    });
  }

  Future filePicker(BuildContext context) async {
    try {
      file = await FilePicker.getFile(type: FileType.any);
      setState(() {
        fileName = p.basename(file.path);
      });
      print(fileName);
      _uploadFile(file, fileName);
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MY DOCUMENTS',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 7),
          ),
        ),
        backgroundColor: Color(0xFF6F35A5),
      ),
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Color(0xFFF1E6FF),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                'AADHAR CARD',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25,
                                      letterSpacing: 5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: Links.aadharlink == null
                                  ? Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Status : ',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Not Uploaded',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Status : ',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Uploaded',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: FlatButton.icon(
                                              onPressed: () {
                                                launchUrl(Links.aadharlink);
                                              },
                                              icon: Icon(Icons.visibility),
                                              label: Text('View')),
                                        )
                                      ],
                                    ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    fileType = 'Aadhar';
                                  });
                                  filePicker(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF6F35A5),
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                  width: ((MediaQuery.of(context).size).width *
                                      0.8),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Upload',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
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
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Color(0xFFF1E6FF),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                'PAN CARD',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25,
                                      letterSpacing: 5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: Links.panlink == null
                                  ? Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Status : ',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Not Uploaded',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Status : ',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Uploaded',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: FlatButton.icon(
                                              onPressed: () {
                                                launchUrl(Links.panlink);
                                              },
                                              icon: Icon(Icons.visibility),
                                              label: Text('View')),
                                        )
                                      ],
                                    ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    fileType = 'PAN Card';
                                  });
                                  filePicker(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF6F35A5),
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                  width: ((MediaQuery.of(context).size).width *
                                      0.8),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Upload',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
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
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Color(0xFFF1E6FF),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                'GST / TIN No.',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25,
                                      letterSpacing: 5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: Links.gstlink == null
                                  ? Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Status : ',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Not Uploaded',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Status : ',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Uploaded',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: FlatButton.icon(
                                              onPressed: () {
                                                launchUrl(Links.gstlink);
                                              },
                                              icon: Icon(Icons.visibility),
                                              label: Text('View')),
                                        )
                                      ],
                                    ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    fileType = 'GST or TIN';
                                  });
                                  filePicker(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF6F35A5),
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                  width: ((MediaQuery.of(context).size).width *
                                      0.8),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Upload',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
