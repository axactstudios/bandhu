import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../MyHomePage.dart';
import 'SignUpPage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _phoneController;
  TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
            Form(
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
                    TextFormField(
                      validator: (value) {
                        if (value.length < 13) {
                          return 'Invalid phone number';
                        } else {
                          return null;
                        }
                      },
                      controller: _phoneController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33)),
                          hintText: 'Your email',
                          hintStyle: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Invalid password';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33),
                          ),
                          hintText: 'Password',
                          hintStyle: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          signIn(
                              phone: _phoneController.text,
                              password: _passwordController.text);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF6F35A5),
                          borderRadius: BorderRadius.circular(33),
                        ),
                        width: ((MediaQuery.of(context).size).width * 0.87),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'SIGN IN',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    letterSpacing: 4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.173,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an Account?',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 16)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6F35A5),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signIn({String phone, String password}) async {
    mAuth
        .signInWithEmailAndPassword(email: phone, password: password)
        .then((AuthResult) async {
      FirebaseUser user = await mAuth.currentUser();

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        Fluttertoast.showToast(
            msg: 'Login Failed',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
      }
    });
  }
}

//RaisedButton(
//padding: EdgeInsets.fromLTRB(152, 10, 152, 10),
//color: Color(0xFF6F35A5),
//onPressed: () {
//if (_formKey.currentState.validate()) {
//signIn(
//phone: _phoneController.text,
//password: _passwordController.text);
//}
//},
//shape: RoundedRectangleBorder(
//side: BorderSide(color: Color(0xFFF1E6FF)),
//borderRadius: BorderRadius.circular(33),
//),
//child: Text(
//'Sign in',
//style: GoogleFonts.poppins(
//textStyle: TextStyle(
//fontWeight: FontWeight.w400,
//color: Colors.white,
//fontSize: 20),
//),
//),
//),
