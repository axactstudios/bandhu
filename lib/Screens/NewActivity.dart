import 'dart:io';

import 'package:bandhunew/Widgets/CustomTextField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String unique;
  List<Asset> images = List<Asset>();
  Map<String, String> vids = Map<String, String>();
  String _error = 'No Error Dectected';
  List<String> imageUrls = <String>[];
  List<String> vidUrls = <String>[];
  ProgressDialog pr;
  bool _isLoading = false;
  double _progress = 0;
  String _path;
  Map<String, String> _paths;

  List<StorageUploadTask> _tasks = <StorageUploadTask>[];

  Future<void> openFileExplorer() async {
    try {
      _path = null;

      _paths = await FilePicker.getMultiFilePath(type: FileType.any);
      vids = _paths;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
  }

  uploadToFirebase(String key) async {
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      textDirection: TextDirection.rtl,
      isDismissible: true,
    );
    pr.style(
      message: 'Uploading videos...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    await pr.show();
    _paths.forEach((fileName, filePath) => {
          upload(fileName, filePath, key).then((downloadUrl) async {
            final FirebaseStorage _storage =
                FirebaseStorage(storageBucket: 'gs://bandhu-d4b07.appspot.com');
            StorageReference storageReference;
            storageReference =
                _storage.ref().child("ActivityImages/${user.uid}/$key");
            final String url = await storageReference.getDownloadURL();
            vidUrls.add(url);
            if (vidUrls.length == vids.length) {
              dbRef
                  .child('Activities')
                  .child(user.uid)
                  .child(key)
                  .set({"Vids": vidUrls}).then((_) {
                Fluttertoast.showToast(msg: "Successfully Uploaded");

                setState(() async {
                  await pr.hide();
                  vids.clear();
                  vidUrls.clear();
                });
              });
            }
          })
        });
  }

  upload(fileName, filePath, String key) async {
    vidUrls.clear();
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://bandhu-d4b07.appspot.com');
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    StorageReference storageReference;
    storageReference = _storage.ref().child("ActivityImages/${user.uid}/$key");
//    _extension = fileName.toString().split('.').last;

    final StorageUploadTask uploadTask = storageReference.putFile(
      File(filePath),
      StorageMetadata(
        contentType: 'video/mp4',
      ),
    );
    uploadTask.events.listen((event) {
      setState(() {
        _isLoading = true;
        _progress = (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble()) *
            100;
        print('${_progress.toStringAsFixed(2)}%');
        pr.update(
          progress: double.parse(_progress.toStringAsFixed(2)),
          maxProgress: 100.0,
        );
      });
    }).onError((error) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    });

    setState(() {
      print(vidUrls.length);
      _tasks.add(uploadTask);
    });
  }

  Future<dynamic> postImage(Asset imageFile, String key) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://bandhu-d4b07.appspot.com');
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    StorageReference storageReference;
    storageReference = _storage.ref().child("ActivityImages/${user.uid}/$key");
    StorageUploadTask uploadTask = storageReference
        .putData((await imageFile.getByteData()).buffer.asUint8List());
    uploadTask.events.listen((event) {
      setState(() {
        _isLoading = true;
        _progress = (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble()) *
            100;
        print('${_progress.toStringAsFixed(2)}%');
        pr.update(
          progress: double.parse(_progress.toStringAsFixed(2)),
          maxProgress: 100.0,
        );
      });
    }).onError((error) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    });

    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());

    return storageTaskSnapshot.ref.getDownloadURL();
  }

  void uploadImages(String key) async {
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      textDirection: TextDirection.rtl,
      isDismissible: true,
    );
    pr.style(
      message: 'Uploading photos...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    await pr.show();
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
    Future.delayed(Duration(seconds: 2)).then((value) {
      pr.hide().whenComplete(() {
        print(pr.isShowing());
      });
    });
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Add new activity',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 25)),
        ),
        backgroundColor: Color(0xFF6F35A5),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                onTap: () async {
                  await openFileExplorer();

                  await uploadToFirebase(unique);
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
                        'Upload Videos',
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
