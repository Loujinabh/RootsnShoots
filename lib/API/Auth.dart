import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Config/Keys.dart';

Future<int> signUpWithEmailAndPassword(
    BuildContext context, String email, String password, String name) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: CircularProgressIndicator(
        color: AppColors.main,
      ),
    ),
  );
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
    }

    Keys.navigatorKey.currentState!.popUntil((route) => route.isFirst);
    return 200;
  } catch (e) {
    print('Failed to sign up: $e');
    Keys.navigatorKey.currentState!.popUntil((route) => route.isFirst);
    return 400;
  }
}

Future<int> signIn(BuildContext context, String email, String password) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: CircularProgressIndicator(
        color: AppColors.main,
      ),
    ),
  );

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    Keys.navigatorKey.currentState!.popUntil((route) => route.isFirst);

    return 200;
  } catch (e) {
    print('Failed to sign in: $e');
    Keys.navigatorKey.currentState!.popUntil((route) => route.isFirst);
    return 400;
  }
}

Future<int> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    return 200;
  } catch (e) {
    print('Failed to sign out: $e');
    return 400;
  }
}
