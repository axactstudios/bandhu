import 'dart:io';
import 'package:bandhunew/Classes/Activity.dart';
import 'package:bandhunew/Screens/Activities.dart';
import 'package:bandhunew/Widgets/CustomTextField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:path/path.dart' as p;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:random_string/random_string.dart';

class EditActivity extends StatefulWidget {
  Activity activityToEdit;
  EditActivity({this.activityToEdit});
  @override
  _EditActivityState createState() => _EditActivityState();
}

final activityName = TextEditingController();
final rawMaterial = TextEditingController();
final avgProduction = TextEditingController();
List imageList = [];
final dbRef = FirebaseDatabase.instance.reference();
final FirebaseAuth mAuth = FirebaseAuth.instance;
String name = "";

class _EditActivityState extends State<EditActivity> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String federation = '';
  List<String> federationList = [
    'CrPÉ ºÁ¼É vÀmÉÖ',
    'CrPÉ £À¸Àðj',
    'ºÀ¹ CrPÉ',
    'UÉÆÃlÄ CrPÉ',
    'a°©° UÉÆÃlÄ',
    '±ÀÄAp',
    '¨Á¼ÉºÀtÄÚ',
    'vÀgÀPÁj',
    '«Ã¼ÀåzÉ¯É',
    'vÉAV£ÀPÁ¬Ä',
    'PÉÆ§âj',
    'ZÀPÀÄÌ°',
    'PÉÆÃqÀÄ§¼É',
    'D®ÆUÀqÉØ a¥ïì',
    'ªÀiÁ®Äàj',
    'ºÀ¥Àà¼À',
    'gÉÆnÖ',
    '±Áå«UÉ',
    '±ÉÃAUÁ',
    'SÁgÀ',
    '§ÆA¢',
    '®qÀÄØ',
    '¨ÁzÀÄµÀ',
    'vÉAV£À £Áj£À ºÀUÀÎ',
    '©¢gÀÄ §ÄnÖ',
    'Mt«ÄÃ£ÀÄ',
    'PÀÈvÀPÀ gÀvÀß& D¨sÀgÀt',
    'ªÀiÁåmï',
    '¨É®è'
  ];

  ProgressDialog pr;
  bool _isLoading = false;
  double _progress = 0;
  List<dynamic> imageList = [];
  List<dynamic> videoList = [];
  String unique;
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';
  List<String> imageUrls = [];
  List<String> videoUrls = [];

  Future<void> _uploadImage(
      File file, String filename, String urlToBeReplaced) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://bandhu-d4b07.appspot.com');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    StorageReference storageReference;
    storageReference =
        _storage.ref().child("ActivityImages").child(user.uid).child(fileName);

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    Fluttertoast.showToast(msg: 'Uploading...', gravity: ToastGravity.BOTTOM);
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
      print(
          '!!!!!!!!!!!!!!!!!!!!!!!!!!!!${error.toString()}!!!!!!!!!!!!!!!!!!!!!!!!!');
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    });
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    for (int i = 0; i < imageList.length; i++) {
      if (imageList[i] == urlToBeReplaced) {
        imageList[i] = url;
      }
    }
    Fluttertoast.showToast(
        msg: 'Upload Complete', gravity: ToastGravity.CENTER);
    setState(() async {
      await pr.hide();
    });
  }

  Future imagePicker(BuildContext context, String urlToBeReplaced) async {
    try {
      file = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      await setState(() {
        fileName = p.basename(file.path);
      });
      print(fileName);
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

      await _uploadImage(file, fileName, urlToBeReplaced);

      setState(() async {
        //await pr.hide();
        print(fileName);
      });
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
//    setState(() async {
//      await pr.hide();
//      print(fileName);
//    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rawMaterial.text = widget.activityToEdit.rawMaterial;
    avgProduction.text = widget.activityToEdit.avgProduction;
    federation = widget.activityToEdit.name;
    imageList = widget.activityToEdit.imageList;
    videoList = widget.activityToEdit.videoList;
    for (int i = 0; i < imageList.length; i++) {}
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyActivities()),
              );
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Add new activity',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 25)),
        ),
        backgroundColor: Color(0xFF6F35A5),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFF1E6FF),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Activity : ',
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
                                width: 170,
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
              CustomTextField(rawMaterial, 'Raw material used'),
              CustomTextField(avgProduction, 'Average Production'),
              SizedBox(
                height: 20,
              ),
              Text('Tap on an image to edit'),
              imageList.length != 0
                  ? Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageList.length,
                        itemBuilder: (context, index) {
                          print(
                              "---------------__${imageList[index]}---------------------");
                          return InkWell(
                            onTap: () {
                              imagePicker(context, imageList[index]);
                            },
                            child: Card(
                              elevation: 8,
                              margin: EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: CachedNetworkImage(
                                    imageUrl: imageList[index],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                        height: 100,
                                        width: 100,
                                        child: GFLoader(
                                          type: GFLoaderType.ios,
                                        )),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : GFLoader(
                      type: GFLoaderType.ios,
                    ),
              SizedBox(
                height: 20,
              ),
              Text('Tap on an video to preview and  double tap to edit'),
              videoList != null
                  ? Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: videoList.length,
                        itemBuilder: (context, index) {
                          print(
                              "---------------__${videoList[index]}---------------------");
                          return InkWell(
                            onTap: () {
                              imagePicker(context, videoList[index]);
                            },
                            child: Card(
                                elevation: 8,
                                margin: EdgeInsets.all(8.0),
                                child: Text('Video ${index + 1}')),
                          );
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No Videos'),
                    ),
              InkWell(
                onTap: () {
                  setState(() {});
                  writeData(widget.activityToEdit.key);
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
    dbRef.child('Activities').child(uid).child(key).update({
      'activtyName': federation,
      'rawMaterial': rawMaterial.text,
      'avgProduction': avgProduction.text,
      "Images": imageList,
      "Videos": videoUrls
    }).then((_) {
      Fluttertoast.showToast(msg: "Successfully Uploaded");

      setState(() {
        imageList.clear();
        videoUrls.clear();

        activityName.clear();
        rawMaterial.clear();
        avgProduction.clear();
      });
    });

    Fluttertoast.showToast(msg: 'Completed', toastLength: Toast.LENGTH_SHORT);
  }

  getUrls() async {
    final FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;
    print(user.uid);
    DatabaseReference urlRef = FirebaseDatabase.instance
        .reference()
        .child('Activities')
        .child(user.uid);
    print(widget.activityToEdit.name);
    urlRef.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snap.value;
      imageList.clear();
      for (var key in KEYS) {
        if (key == widget.activityToEdit.key) {
          print(widget.activityToEdit.name);
          imageList = (DATA[key]['Images']);
        }
      }
      setState(() {});
    });
  }
}
