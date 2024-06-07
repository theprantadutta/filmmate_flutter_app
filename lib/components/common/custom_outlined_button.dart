import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final bool selected;
  final void Function()? onPressed;

  const CustomOutlinedButton({
    super.key,
    required this.title,
    this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor:
            selected ? kPrimaryColor.withOpacity(0.8) : Colors.transparent,
        side: BorderSide(
          color: kPrimaryColor,
          width: selected ? 0 : 2,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : kPrimaryColor,
        ),
      ),
    );
  }
}
