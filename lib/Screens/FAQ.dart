import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'FAQs',
          style: GoogleFonts.varelaRound(
            textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
          ),
        ),
        backgroundColor: Color(0xFFA96DA3),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'What is the vision behind Bandhu?',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.028,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Our vision is to enable far reaching markets to the local produce for the sustainable all inclusive growth of India.',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.022,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'What is the mission behind Bandhu?',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.028,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Bandhu is formed with a mission to connect producers and wholesalers together with an efficient tech enabled platform to ensure sustainable demand and supply.',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.022,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Who can register on this platform?',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.028,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Any member can register in the platform who has the capacity to produce home made products.',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.022,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'What is the use of registering on this platform?',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.028,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'The platform connects members with Farmer Produce Organizations (FPOs) and Wholesalers to ensure there is sustained demand and supply.',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.022,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'What help does the platform provides to the members?',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.028,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'There will be guides and best practices which can be followed by the members to grow the produce in a best possible way to get the best returns.',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.022,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Who will provide the raw materials to produce the items?',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.028,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Members can request for the raw materials in the platform or can declare that they have the required materials to develop the produce. If they request for raw materials then it will be supplied by the FPO\'s and coordinated by the FPOs.',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.022,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'How to check the demand for a particular produce?',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.028,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Members can see the demand for the items once they open the application. If they have the item they can respond with the quantity available with them.',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.022,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'What is the role of FPOs on the platform?',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.028,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'FPOs manage the demand and supply by coordinating with both the members and the wholesalers (buyers).',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.022,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 30),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'How can the wholesalers or the buyers register on the platform?',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.028,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Wholesalers can send a request to the Bandhu support team with the required details and will be registered once approved by Bandhu.',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.022,
                              color: Colors.black.withOpacity(0.6),
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
        ),
      ),
    );
  }
}
