import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poonia_brothers/add_forms/add_user_manger.dart';
import 'package:poonia_brothers/auth/login_page.dart';
import 'package:poonia_brothers/dashboard/user_manager.dart';
import 'package:poonia_brothers/provider/circular_provider.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyATsL4A5-3cCDq7dWD1VrB9CejcyO8iJps",
            authDomain: "poonia-bbaea.firebaseapp.com",
            projectId: "poonia-bbaea",
            storageBucket: "poonia-bbaea.appspot.com",
            messagingSenderId: "1080065949975",
            appId: "1:1080065949975:web:b5983142be78a12630f752",
            measurementId: "G-XMTDKHJM60"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CircularProgressProvider()),
      ],
      child: MyApp(),
    ),
  );
}

void setPageTitle(String title, BuildContext context) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: title,
    primaryColor: Theme.of(context).primaryColor.value, // This line is required
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poonia Brothers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/business': (context) => UserManager(),
        // '/settings': (context) => SettingsPage(),
      },
      home: LoginPage(),
    );
  }
}
