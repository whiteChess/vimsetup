import 'package:prayer_times/constants.dart';
import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kTopBarBackgroundColor,
      title: Text(""),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return AppBar().preferredSize;
  }
}
