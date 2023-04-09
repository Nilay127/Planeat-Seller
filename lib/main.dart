import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Widgets/color.dart';
import 'firebase_options.dart';
import 'models/menuitemdinner.dart';
import 'models/menuitemlunch.dart';
import 'Authentication/authenication.dart';
import 'Config/config.dart';
import 'Screen/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  MenuItemdinner.sharedPreferences = await SharedPreferences.getInstance();
  MenuItemlunch.sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (EcommerceApp.sharedPreferences.getString(EcommerceApp.language) ==
        "English") {
      _locale = Locale.fromSubtags(languageCode: 'en');
    } else if (EcommerceApp.sharedPreferences
            .getString(EcommerceApp.language) ==
        "Hindi") {
      _locale = Locale.fromSubtags(languageCode: 'hi');
    } else {
      Locale.fromSubtags(languageCode: 'gu');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiffin App',
      
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => UploadPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/auth': (context) => AuthenticScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green, fontFamily: 'Montserrat'),
      home:
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID) != null
              ? UploadPage()
              : AuthenticScreen(),
    );
  }
}
