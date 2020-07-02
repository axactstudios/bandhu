import 'package:bandhunew/Screens/ImageUploadScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class MyDocuments extends StatefulWidget {
  @override
  _MyDocumentsState createState() => _MyDocumentsState();
}

class _MyDocumentsState extends State<MyDocuments> {
  final dbRef = FirebaseDatabase.instance.reference().child('Users');

  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';

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
    dbRef
        .child(user.uid)
        .child('Documents')
        .child(fileType)
        .set({fileType: url});
    Fluttertoast.showToast(
        msg: 'Upload Complete', gravity: ToastGravity.CENTER);
  }

  Future filePicker(BuildContext context) async {
    try {
      file = await FilePicker.getFile(type: FileType.image);
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
                              child: Text(
                                'Status : ',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
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
                              child: Text(
                                'Status : ',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
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
                              child: Text(
                                'Status : ',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
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
}
