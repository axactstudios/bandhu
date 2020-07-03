import 'package:bandhunew/Screens/Activities.dart';
import 'package:bandhunew/Screens/MyProfileScreen.dart';
import 'package:bandhunew/auth/SignInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

import 'Screens/Home.dart';
import 'Screens/MyDocuments.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 1);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      items: _navBarsItems(),
      screens: _buildScreens(),
      showElevation: true,
      navBarCurve: NavBarCurve.upperCorners,
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      iconSize: 26.0,
      navBarStyle:
          NavBarStyle.neumorphic, // Choose the nav bar style with this property
      onItemSelected: (index) {
        print(index);
      },
    );
  }

  List<Widget> _buildScreens() {
    return [MyProfileScreen(), Home(), MyDocuments(), MyActivities()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Second Screen"),
        activeColor: Color(0xFF6F35A5),
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColor: Color(0xFF6F35A5),
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.folder),
        title: ("My Documents"),
        activeColor: Color(0xFF6F35A5),
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.add),
        title: ("My Activities"),
        activeColor: Color(0xFF6F35A5),
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }
}
