import 'dart:io';

import 'package:bandhunew/Widgets/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';

class NewActivity extends StatefulWidget {
  @override
  _NewActivityState createState() => _NewActivityState();
}

final activityName = TextEditingController();
final rawMaterial = TextEditingController();
final avgProduction = TextEditingController();
final dbRef = FirebaseDatabase.instance.reference();
final FirebaseAuth mAuth = FirebaseAuth.instance;
String name = "";

class _NewActivityState extends State<NewActivity> {
  String unique;
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  List<String> imageUrls = <String>[];

  Future<dynamic> postImage(Asset imageFile, String key) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://bandhu-d4b07.appspot.com');
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    StorageReference storageReference;
    storageReference = _storage.ref().child("ActivityImages/${user.uid}/$key");
    StorageUploadTask uploadTask = storageReference
        .putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  void uploadImages(String key) async {
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    for (var imageFile in images) {
      postImage(imageFile, key).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          dbRef
              .child('Activities')
              .child(user.uid)
              .child(key)
              .update({"Images": imageUrls}).then((_) {
            Fluttertoast.showToast(msg: "Successfully Uploaded");

            setState(() {
              images.clear();
              imageUrls.clear();
            });
          });
        }
      });
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 12,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  void initState() {
    imageUrls.clear();
    images.clear();
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
              textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 25)),
        ),
        backgroundColor: Color(0xFF6F35A5),
      ),
      body: Container(
        color: Color(0xFFF1E6FF),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            CustomTextField(activityName, 'Activity Name'),
            CustomTextField(rawMaterial, 'Raw material used'),
            CustomTextField(avgProduction, 'Average Production'),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                await loadAssets();
                unique = key;
                uploadImages(unique);
                setState(() {
                  name = activityName.text;
                  print(name);
                });
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
                      'Upload Photos',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {});
                writeData(unique);

                print(activityName.text);
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
                      'Publish',
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
          ],
        ),
      ),
    );
  }

  void writeData(String key) async {
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    print(uid);
    dbRef.child('Activities').child(uid).child(key).update({
      'activtyName': activityName.text,
      'rawMaterial': rawMaterial.text,
      'avgProduction': avgProduction.text,
    });

    activityName.clear();
    rawMaterial.clear();
    avgProduction.clear();
    Navigator.pop(context);
  }
}
