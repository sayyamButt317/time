import '../Views/stain.dart';
import '../Views/month.dart';
import '../Views/home.dart';
import 'package:flutter/material.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int selectedIndex = 0;

  final Widget _stainPage = const Stain();
  final Widget _yearPage = const YearCalendarPage();
  final Widget _homePage = const MyHomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "Month",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return _homePage;
    } else if (selectedIndex == 1) {
      return _yearPage;
    } else if (selectedIndex == 2) {
      return _stainPage;
    } else {
      return _homePage;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
