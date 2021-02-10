import 'package:flutter/material.dart';
import 'package:prayer_times/constants.dart';
import 'package:prayer_times/screens/home/background.dart';

class HomeScreen extends StatefulWidget {
  static String name = "HomeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.animation.addListener(() {
      setState(() {
        _selectedIndex = (_tabController.animation.value).round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: Background(),
    );
  }
}
