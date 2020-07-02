import 'dart:io';
import 'package:bandhunew/Screens/MyDocuments.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';

  void _uploadFile(File file, String filename) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://bandhu-d4b07.appspot.com');

    StorageReference storageReference;
    if (fileType == 'image') {
      storageReference = _storage.ref().child("images/$filename");
    }
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    Fluttertoast.showToast(msg: 'Upload Complete');
    Navigator.pop(context);
  }

  Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.image);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
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
      backgroundColor: Color(0xFFF1E6FF),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                'Image',
                style: TextStyle(color: Colors.black),
              ),
              leading: Icon(
                Icons.image,
                color: Color(0xFF6F35A5),
              ),
              onTap: () {
                setState(() {
                  fileType = 'image';
                });
                filePicker(context);
              },
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              result,
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.cloud_upload),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'UPLOAD DOCUMENTS',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.w400)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6F35A5),
      ),
    );
  }
}
