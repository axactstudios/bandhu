import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regexed_validator/regexed_validator.dart';

import 'NewBuyerScreen.dart';

class BuyerRegisterForm extends StatefulWidget {
  @override
  _BuyerRegisterFormState createState() => _BuyerRegisterFormState();
}

class _BuyerRegisterFormState extends State<BuyerRegisterForm> {
  TextEditingController email = new TextEditingController(text: '');
  TextEditingController phone = new TextEditingController(text: '');

  final _formKey = GlobalKey<FormState>();

  Widget spacer() {
    return SizedBox(
      height: 16,
    );
  }

  double radius = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA96DA3),
        title: Text(
          'New Buyer',
          style: GoogleFonts.varelaRound(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Buyer Registration',
                style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: Colors.purple)),
              ),
              spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  validator: (value) {
                    if (!validator.email(value)) {
                      return 'Invalid email';
                    } else {
                      return null;
                    }
                  },
                  controller: email,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      hintStyle: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                            color: Color(0xFFA96DA3),
                            fontWeight: FontWeight.w400),
                      ),
                      hintText: "Email address"),
                ),
              ),
              spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  validator: (value) {
                    if (!validator.phone(value)) {
                      return 'Invalid phone number';
                    } else {
                      return null;
                    }
                  },
                  controller: phone,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      hintStyle: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                            color: Color(0xFFA96DA3),
                            fontWeight: FontWeight.w400),
                      ),
                      hintText: "Phone number"),
                ),
              ),
              spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewBuyer(),
                      ),
                    );
//                      writeData();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFA96DA3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: ((MediaQuery.of(context).size).width * 0.93),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'SUBMIT',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 2,
                              color: Colors.white,
                              fontSize: 20),
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
}
