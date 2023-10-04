// ignore: file_names
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class StyledFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isHidden;
  final IconData? icon;
  final String hintText;
  final String? Function(String?)? validator;

  const StyledFormTextField(
      {super.key,
      required this.controller,
      required this.isHidden,
      this.icon,
      required this.hintText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 1,
            color: Colors.white60,
          )),
      child: TextFormField(
        controller: controller,
        obscureText: isHidden,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Colors.white.withOpacity(.8),
                  size: 20,
                )
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white60, fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
