import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prayer_times/assets_cache.dart';
import 'package:prayer_times/screens/home.dart';
import 'package:prayer_times/screens/landing.dart';
import 'package:prayer_times/screens/profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AssetsCache.load().then((success) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.changeLanguage(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Locale _locale = Locale('en');
  bool assetsReady = false;
  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Devicelocale.currentLocale.then((value) {
      setState(() {
        _locale = Locale(value);
      });
      print(value);
    });
    // AssetsCache.load().then((success) {
    //   setState(() {
    //     assetsReady = true;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // if (assetsReady) {
    //   Future.delayed(Duration(seconds: 2), () {
    //     Navigator.pushNamed(context, HomeScreen.name);
    //   });
    // }
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: [
        Locale('en', ''),
        Locale('ar'),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.name,
      routes: {
        HomeScreen.name: (context) => HomeScreen(),
        LandingScreen.name: (context) => LandingScreen(),
        ProfileScreen.name: (context) => ProfileScreen(),
      },
    );
  }
}
