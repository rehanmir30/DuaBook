import 'package:duabook/screens/subScreens/home.dart';
import 'package:duabook/screens/subScreens/notification.dart';
import 'package:duabook/screens/subScreens/prayer.dart';
import 'package:duabook/screens/subScreens/search.dart';
import 'package:duabook/screens/subScreens/settings.dart';
import 'package:flutter/material.dart';

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
    SearchScreen(),
    NotificationScreen(),
  ];


  @override
  void initState() {
    setState(() {
      _selectedScreen=_screens[0];
    });
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
              child: Image.asset("assets/images/home.png"),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onItemTapped(1),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Image.asset("assets/images/prayer.png"),
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
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onItemTapped(3),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Image.asset(
                "assets/images/search.png",
                width: 30,
                height: 30,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onItemTapped(4),
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
