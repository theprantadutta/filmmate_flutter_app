import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomTextInput extends StatelessWidget {
  final void Function(String)? onChanged;
  final String labelText;
  final bool obscureText;

  const CustomTextInput({
    super.key,
    this.onChanged,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: kPrimaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: kPrimaryColor),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: kPrimaryColor,
          ),
        ),
        obscureText: obscureText,
        cursorColor: kPrimaryColor,
        onChanged: onChanged,
      ),
    );
  }
}
