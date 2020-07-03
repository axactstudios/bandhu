import 'dart:io';

import 'package:bandhunew/Widgets/CustomTextField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';

class NewActivity extends StatefulWidget {
  @override
  _NewActivityState createState() => _NewActivityState();
}

final activityName = TextEditingController();
final rawMaterial = TextEditingController();
File file;
String fileName = '';
final avgProduction = TextEditingController();
final dbRef = FirebaseDatabase.instance.reference();
final FirebaseAuth mAuth = FirebaseAuth.instance;

class _NewActivityState extends State<NewActivity> {
  void _uploadFile(File file, String filename, String key) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://bandhu-d4b07.appspot.com');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    StorageReference storageReference;
    storageReference = _storage.ref().child("ActivityImages/${user.uid}/$key");

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    dbRef.child('Activities').child(user.uid).child(key).set({
      'Link': url,
      'activtyName': activityName.text,
      'rawMaterial': rawMaterial.text,
      'avgProduction': avgProduction.text,
    });
    Fluttertoast.showToast(
        msg: 'Upload Complete', gravity: ToastGravity.CENTER);
    setState(() {
      print(key);
    });
  }

  Future filePicker(BuildContext context, String key) async {
    try {
      file = await FilePicker.getFile(type: FileType.any);
      setState(() {
        fileName = p.basename(file.path);
      });
      print(fileName);
      _uploadFile(file, fileName, key);
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
    int keyLength = randomBetween(5, 15);
    String key = randomAlpha(keyLength);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new activity',
          style: GoogleFonts.poppins(
              textStyle:
                  TextStyle(fontWeight: FontWeight.w400, letterSpacing: 7)),
        ),
        backgroundColor: Color(0xFF6F35A5),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CustomTextField(activityName, 'Activity Name'),
            CustomTextField(rawMaterial, 'Raw material used'),
            CustomTextField(avgProduction, 'Average Production'),
            InkWell(
              onTap: () {
                setState(() {});
                filePicker(context, key);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF6F35A5),
                  borderRadius: BorderRadius.circular(33),
                ),
                width: ((MediaQuery.of(context).size).width * 0.8),
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
            InkWell(
              child: Text('Publish'),
              onTap: () {
                writeData();
                print(activityName.text);
              },
            )
          ],
        ),
      ),
    );
  }

  void writeData() async {
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    print(uid);
    dbRef.child('Activities').child(uid).push().set({
      'activtyName': activityName.text,
      'rawMaterial': rawMaterial.text,
      'avgProduction': avgProduction.text,
    });

    Navigator.pop(context);
  }
}
