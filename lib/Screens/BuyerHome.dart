import 'package:bandhunew/Profile/BuyerProfileScreen.dart';
import 'package:bandhunew/Screens/BuyerActivity.dart';
import 'package:bandhunew/Screens/BuyerDashboard.dart';
import 'package:bandhunew/Screens/BuyerDocuments.dart';
import 'package:bandhunew/Screens/BuyerProfile.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BuyerHome extends StatefulWidget {
  @override
  _BuyerHomeState createState() => _BuyerHomeState();
}

class _BuyerHomeState extends State<BuyerHome> {
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
    return [
      BuyerProfileScreen(),
      BuyerDashboard(),
      BuyerDocuments(),
      BuyerActivity()
    ];
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
