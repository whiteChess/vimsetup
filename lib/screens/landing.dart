import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prayer_times/screens/home.dart';

class LandingScreen extends StatelessWidget {
  static String name = "LandingScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => {Navigator.pushNamed(context, HomeScreen.name)},
          child: Text(AppLocalizations.of(context).helloWorld),
        ),
      ),
    );
  }
}
