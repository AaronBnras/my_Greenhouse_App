import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_greenhouse/UI/screens/Profile.dart';
import 'package:my_greenhouse/UI/screens/dashboard.dart';
import 'package:my_greenhouse/UI/screens/home_page.dart';
import 'package:my_greenhouse/constants.dart';





class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> pages = const [
    HomePage(),
    DashboardPage(),
    ProfilePage(),

  ];

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.dashboard,
    Icons.person,

  ];

  //list of the pages tittle
  List<String> tittleList = [
    'Home',
    'Dashboard',
    'Profile',

  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tittleList[_bottomNavIndex],
                style: TextStyle(
                    color: Constants.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 24
                ),
              ),
              const Stack(
                children: [
                  // Your RootPage content here
                  Positioned.fill(
                    child: DashboardPage(),
                  ),
                ],
              )
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // backgroundColor: Constants.primaryColor,
          elevation: 0.0,
        ),

        body: Container(
          padding: const EdgeInsets.only(top: 10),
          child: IndexedStack(
            index: _bottomNavIndex,
            children: pages,
          ),
        ),

        bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: Constants.primaryColor,
          backgroundColor: Constants.primaryColor.withOpacity(1),
          activeColor: Constants.blackColor,
          inactiveColor: Colors.white.withOpacity(.7),
          borderWidth: 10,
          borderColor: Constants.blackColor.withOpacity(1),
          icons: iconList,
          activeIndex: _bottomNavIndex,
          leftCornerRadius: 30,
          rightCornerRadius: 30,
          gapLocation: GapLocation.none,
          onTap: (index) => setState(
              () => _bottomNavIndex = index
          ),
        ),
      ),
    );
  }
}

