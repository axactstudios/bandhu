import 'package:bandhunew/MyHomePage.dart';
import 'package:bandhunew/Profile/BuyerProfileEdit.dart';
import 'package:bandhunew/Profile/ProfileEdit.dart';
import 'package:bandhunew/Screens/BuyerDashboard.dart';
import 'package:bandhunew/Screens/BuyerHome.dart';
import 'package:bandhunew/Screens/Home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'OTPinput.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber, userType;
  OTPScreen({Key key, @required this.mobileNumber, @required this.userType})
      : assert(mobileNumber != null),
        super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration =
      UnderlineDecoration(enteredColor: Colors.black, hintText: '333333');

  bool isCodeSent = false;
  String _verificationId;

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Image.asset('assets/signup_top.png',
                    height: size.height * 0.15),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset('assets/main_bottom.png',
                    height: size.height * 0.15),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  SvgPicture.asset(
                    'assets/agriculture.svg',
                    height: size.height * 0.26,
                  ),
                  Text(
                    'ENTER OTP',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 25.0,
                          letterSpacing: 5),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0, bottom: 16, top: 4),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 16, 0),
                          child: Text(
                            "OTP sent to ${widget.mobileNumber}",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'sf_pro',
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PinInputTextField(
                              pinLength: 6,
                              decoration: _pinDecoration,
                              controller: _pinEditingController,
                              autoFocus: true,
                              textInputAction: TextInputAction.done,
                              onSubmit: (pin) {
                                if (pin.length == 6) {
                                  _onFormSubmitted();
                                } else {
                                  showToast("Invalid OTP", Colors.red);
                                }
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 16, right: 16),
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: RaisedButton(
                                  color: Color(0xFF6F35A5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Text(
                                    "ENTER OTP",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    if (_pinEditingController.text.length ==
                                        6) {
                                      _onFormSubmitted();
                                    } else {
                                      showToast("Invalid OTP", Colors.white);
                                    }
                                  },
                                  padding: EdgeInsets.all(16.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Color(0xFF6F35A5),
      fontSize: 16.0,
    );
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) async {
        if (value.user != null) {
          FirebaseUser user = await FirebaseAuth.instance.currentUser();
          if (widget.userType == 'Seller') {
            DatabaseReference useraddressref = FirebaseDatabase
                .instance //Used the UID of the user to check if record exists in the database or not
                .reference()
                .child('Users')
                .child(user.uid)
                .child('Details');
            useraddressref.once().then((DataSnapshot snap) {
              // ignore: non_constant_identifier_names
              var DATA = snap.value;
              if (DATA == null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileEdit(
                              userType: widget.userType,
                            )),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              }
            });
          } else {
            DatabaseReference useraddressref = FirebaseDatabase
                .instance //Used the UID of the user to check if record exists in the database or not
                .reference()
                .child('Buyers')
                .child(user.uid)
                .child('Details');
            useraddressref.once().then((DataSnapshot snap) {
              // ignore: non_constant_identifier_names
              var DATA = snap.value;
              if (DATA == null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BuyerProfileEdit(
                              userType: widget.userType,
                            )),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuyerHome(),
                  ),
                );
              }
            });
          }
        } else {
          showToast("Error validating OTP, try again", Colors.white);
        }
      }).catchError((error) {
        showToast("Try again in sometime", Colors.white);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      showToast(authException.message, Colors.white);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showToast('sent', Colors.white);
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91${widget.mobileNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _pinEditingController.text,
    );

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((AuthResult value) async {
      if (value.user != null) {
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        if (widget.userType == 'Seller') {
          DatabaseReference useraddressref = FirebaseDatabase
              .instance //Used the UID of the user to check if record exists in the database or not
              .reference()
              .child('Users')
              .child(user.uid)
              .child('Details');
          useraddressref.once().then((DataSnapshot snap) {
            // ignore: non_constant_identifier_names
            var DATA = snap.value;
            if (DATA == null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileEdit(
                            userType: widget.userType,
                          )),
                  (Route<dynamic> route) => false);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            }
          });
        } else {
          DatabaseReference useraddressref = FirebaseDatabase
              .instance //Used the UID of the user to check if record exists in the database or not
              .reference()
              .child('Buyers')
              .child(user.uid)
              .child('Details');
          useraddressref.once().then((DataSnapshot snap) {
            // ignore: non_constant_identifier_names
            var DATA = snap.value;
            if (DATA == null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BuyerProfileEdit(
                            userType: widget.userType,
                          )),
                  (Route<dynamic> route) => false);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyerDashboard(),
                ),
              );
            }
          });
        }
      } else {
        showToast("Error validating OTP, try again", Colors.white);
      }
    }).catchError((error) {
      showToast("Something went wrong", Colors.white);
    });
  }
}
