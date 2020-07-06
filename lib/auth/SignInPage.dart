import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'OtpScreen.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _phoneNumberController;

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  bool isValid = false;

  Future<Null> validate() async {
    if (_phoneNumberController.text.length == 10) {
      setState(() {
        isValid = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/main_top.png',
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/login_bottom.png',
              width: size.width * 0.45,
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    SvgPicture.asset(
                      'assets/farmercolor.svg',
                      height: size.height * 0.25,
                      width: size.width * 0.25,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      'SIGN IN',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25.0,
                            letterSpacing: 5),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(16),
                      height: MediaQuery.of(context).size.height,
                      child: new Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _phoneNumberController,
                                      autofocus: true,
                                      onChanged: (text) {
                                        validate();
                                      },
                                      decoration: InputDecoration(
                                        labelText: "10 digit mobile number",
                                        prefix: Container(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text(
                                            "+91",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      autovalidate: true,
                                      autocorrect: false,
                                      maxLengthEnforced: true,
                                      validator: (value) {
                                        return !isValid
                                            ? 'Please provide a valid 10 digit phone number'
                                            : null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: RaisedButton(
                                          color: !isValid
                                              ? Color(0xFF6F35A5)
                                              : Colors.teal,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          child: Text(
                                            !isValid
                                                ? "ENTER PHONE NUMBER"
                                                : "CONTINUE",
                                            style: !isValid
                                                ? TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold)
                                                : TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            if (isValid) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OTPScreen(
                                                      mobileNumber:
                                                          _phoneNumberController
                                                              .text,
                                                    ),
                                                  ));
                                            } else {
                                              validate();
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
