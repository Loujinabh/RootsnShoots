import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Keys.dart';

showSnackBar(String text) {
  final snackBar = SnackBar(content: Text(text));
  Keys.messengerKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
