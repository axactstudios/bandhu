import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'SignInPage.dart';
import 'package:bandhunew/MyHomePage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                        'assets/agriculture.svg',
                        height: size.height * 0.26,
                      ),
                      Text(
                        'SIGN UP',
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
                          hintStyle: GoogleFonts.poppins(),
                        ),
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
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(148, 10, 148, 10),
                        color: Color(0xFF6F35A5),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            signUp(
                                phone: _phoneController.text,
                                password: _passwordController.text);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(33)),
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.235,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already registered?',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 16)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()),
                              );
                            },
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6F35A5),
                                    fontSize: 16),
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
      ),
    );
  }

  void signUp({String phone, String password}) async {
    await mAuth
        .createUserWithEmailAndPassword(email: phone, password: password)
        .then((AuthResult) async {
      FirebaseUser user = await mAuth.currentUser();

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        Fluttertoast.showToast(
            msg: 'Sign Up Failed',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
    });
  }
}
