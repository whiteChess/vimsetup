import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prayer_times/constants.dart';

class TapButton {
  TapButton({@required this.icon, @required this.buttonText});
  final String buttonText;
  final IconData icon;
}

class NavigationTaps extends StatelessWidget {
  NavigationTaps({this.onChange, this.selectedIndex, this.tapButtons});
  final Function onChange;
  final int selectedIndex;
  final List<TapButton> tapButtons;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kAppBottomNavigationBarBoxDecoration,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
              gap: 8,
              activeColor: kBottomTapsActiveColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: Duration(milliseconds: 600),
              tabBackgroundColor: kBottomTapsTabBackgroundColor,
              tabs: tapButtons
                  .map((tapButton) => GButton(
                        textColor: kBottomTapsTextColor,
                        iconColor: kBottomTapsTextColor,
                        icon: tapButton.icon,
                        text: tapButton.buttonText,
                      ))
                  .toList(),
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                onChange(index);
              })),
    );
  }
}
