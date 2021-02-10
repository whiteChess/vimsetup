import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:prayer_times/constants.dart';
import 'package:prayer_times/main.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Row(children: [
              CircleAvatar(
                child: Icon(
                  LineIcons.male,
                  color: Colors.white,
                ),
                backgroundColor: kAppBackgroundColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'User',
                style: TextStyle(color: Colors.white),
              ),
            ]),
            decoration: BoxDecoration(
              color: kTopBarBackgroundColor,
            ),
          ),
          ListTile(
            title: Text('عربي'),
            onTap: () {
              MyApp.setLocale(context, Locale('ar'));
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('english'),
            onTap: () {
              MyApp.setLocale(context, Locale('en'));
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
