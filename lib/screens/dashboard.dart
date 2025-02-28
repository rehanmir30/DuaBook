import 'package:duabook/constants/userData.dart';
import 'package:duabook/controller/userController.dart';
import 'package:duabook/screens/subScreens/home.dart';
import 'package:duabook/screens/subScreens/notification.dart';
import 'package:duabook/screens/subScreens/prayer.dart';
import 'package:duabook/screens/subScreens/search.dart';
import 'package:duabook/screens/subScreens/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/localization.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  Widget _selectedScreen=Container();

  final List<Widget> _screens = [
    HomeScreen(),
    PrayerScreen(),
    SettingsScreen(),
    // SearchScreen(),
    NotificationScreen(),
  ];


  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    setState(() {
      _selectedScreen=_screens[0];
    });
  }

  getSharedPrefs()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    isLoggedIn= await prefs.getBool("isLoggedIn")??false;
    points=await prefs.getInt("userPoints")??0;
    userName = await prefs.getString("userName")??"Guest User";
    avatar = await prefs.getString("userAvatar")??"";
    String? selectedLang=await prefs.getString("selectedLanguage");

    print(prefs.getString("selectedLanguage"));
    Get.find<UserController>().setSelectedLanguage(selectedLang??"english");
    Get.find<UserController>().setUserName(userName);
    Get.find<UserController>().setLoggedIn(false);
    Get.find<UserController>().setPoints(points);
    Get.find<UserController>().setAvatar(avatar);

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedScreen=_screens[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedScreen,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onItemTapped(0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Image.asset("assets/images/prayer.png"),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onItemTapped(1),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Image.asset("assets/images/home.png"),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onItemTapped(2),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Image.asset("assets/images/settings.png"),
            ),
            label: '',
          ),
          // BottomNavigationBarItem(
          //   icon: InkWell(
          //     onTap: () => _onItemTapped(3),
          //     splashColor: Colors.transparent,
          //     highlightColor: Colors.transparent,
          //     child: Image.asset(
          //       "assets/images/search.png",
          //       width: 30,
          //       height: 30,
          //     ),
          //   ),
          //   label: '',
          // ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onItemTapped(3),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Image.asset(
                "assets/images/notification.png",
                width: 30,
                height: 30,
              ),
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        // onTap: _onItemTapped,
      ),
    );
  }
}
