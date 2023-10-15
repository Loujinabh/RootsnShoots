import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Keys.dart';
import 'package:plant_diary/Layouts/LayoutPage.dart';
import 'package:plant_diary/Views/Login/Login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Keys.messengerKey,
      navigatorKey: Keys.navigatorKey,
      title: 'Roots & Shoots',
      theme: ThemeData(
        fontFamily: 'quick',
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LayoutPage();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
