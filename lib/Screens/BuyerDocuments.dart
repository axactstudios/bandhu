import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:bandhunew/Classes/Documents.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyerDocuments extends StatefulWidget {
  @override
  _BuyerDocumentsState createState() => _BuyerDocumentsState();
}

class _BuyerDocumentsState extends State<BuyerDocuments> {
  final dbRef = FirebaseDatabase.instance.reference();

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
    var aadharref =
        dbRef.child('Buyers').child(uid).child('Documents').child('Aadhar');

    await aadharref.once().then((DataSnapshot snapshot) async {
      Links.aadharlink = await snapshot.value['Link'];
      setState(() {
        print(Links.aadharlink);
      });
    });
  }

  Future getPan() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    var panref =
        dbRef.child('Buyers').child(uid).child('Documents').child('PAN Card');

    await panref.once().then((DataSnapshot snapshot) async {
      Links.panlink = await snapshot.value['Link'];
      setState(() {
        print(Links.panlink);
      });
    });
  }

  Future getGst() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    var gstref =
        dbRef.child('Buyers').child(uid).child('Documents').child('GST or TIN');

    await gstref.once().then((DataSnapshot snapshot) async {
      Links.gstlink = await snapshot.value['Link'];
      setState(() async {
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
    storageReference =
        _storage.ref().child("Documents/Buyers/${user.uid}/$fileType");

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    Fluttertoast.showToast(msg: 'Uploading...', gravity: ToastGravity.CENTER);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");

    dbRef
        .child('Buyers')
        .child(user.uid)
        .child('Documents')
        .child(fileType)
        .set({'Link': url});
    Fluttertoast.showToast(
        msg: 'Upload Complete', gravity: ToastGravity.CENTER);
    setState(() {
      refresh();
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
      file = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg'],
      );
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
    setState(() {
      refresh();
      print(fileName);
    });
  }

  refresh() {
    getAadhar();
    getPan();
    getGst();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Documents',
          style: GoogleFonts.varelaRound(
            textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
          ),
        ),
        backgroundColor: Color(0xFFA96DA3),
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
                                style: GoogleFonts.varelaRound(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23,
                                  ),
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
                                              'Status :',
                                              style: GoogleFonts.varelaRound(
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
                                              style: GoogleFonts.varelaRound(
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
                                              'Status :',
                                              style: GoogleFonts.varelaRound(
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
                                              style: GoogleFonts.varelaRound(
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
                                      )),
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
                                    color: Color(0xFFA96DA3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: ((MediaQuery.of(context).size).width *
                                      0.8),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Upload',
                                        style: GoogleFonts.varelaRound(
                                          textStyle: TextStyle(
                                              fontSize: 16,
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
                                style: GoogleFonts.varelaRound(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23,
                                  ),
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
                                            style: GoogleFonts.varelaRound(
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
                                            style: GoogleFonts.varelaRound(
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
                                            style: GoogleFonts.varelaRound(
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
                                            style: GoogleFonts.varelaRound(
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
                                    color: Color(0xFFA96DA3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: ((MediaQuery.of(context).size).width *
                                      0.8),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Upload',
                                        style: GoogleFonts.varelaRound(
                                          textStyle: TextStyle(
                                              fontSize: 16,
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
                                'GST/TIN No.',
                                style: GoogleFonts.varelaRound(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23,
                                  ),
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
                                            style: GoogleFonts.varelaRound(
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
                                            style: GoogleFonts.varelaRound(
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
                                            style: GoogleFonts.varelaRound(
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
                                            style: GoogleFonts.varelaRound(
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
                                    color: Color(0xFFA96DA3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: ((MediaQuery.of(context).size).width *
                                      0.8),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Upload',
                                        style: GoogleFonts.varelaRound(
                                          textStyle: TextStyle(
                                              fontSize: 16,
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
