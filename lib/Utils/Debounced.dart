import 'dart:async';
import 'package:flutter/material.dart';

class Debounced {
  Debounced(this.milliseconds);
  final int milliseconds;
  Timer timer = Timer(const Duration(milliseconds: 0), () {});

  run(VoidCallback action) {
    if (timer.isActive) {
      timer.cancel();
      timer = Timer(Duration(milliseconds: milliseconds), action);
      return;
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
