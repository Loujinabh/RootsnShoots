import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Views/Dashboard.dart';
import 'package:plant_diary/Views/MyGarden.dart';
import 'package:plant_diary/Views/Diagnose.dart';

class LayoutPage extends StatefulWidget {
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _currentIndex = 0;
  DateTime? lastBackPressed;

  void navigateBack() {
    _navigationStack.removeLast();
    setState(
      () {
        _currentIndex = _navigationStack.last;
      },
    );
  }

  void navigate(int index) {
    setState(
      () {
        _currentIndex = index;
        if (_navigationStack.last != index) {
          _navigationStack.add(index);
        }
      },
    );
  }

  final List<int> _navigationStack = [0];

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      Dashboard(navigateCallback: navigate),
      const Diagnose(),
      MyGarden(
        navigateBackCallback: navigateBack,
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (_navigationStack.length > 1) {
          return false;
        } else if (lastBackPressed == null ||
            DateTime.now().difference(lastBackPressed!) >
                const Duration(seconds: 2)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text("Press back again to exit")),
            ),
          );
          lastBackPressed = DateTime.now();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.main,
          selectedItemColor: AppColors.contrast,
          currentIndex: _currentIndex,
          onTap: (int index) => navigate(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_services),
              label: 'Diagnose',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_florist),
              label: 'My Garden',
            ),
          ],
        ),
      ),
    );
  }
}
