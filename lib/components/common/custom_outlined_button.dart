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
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: selected
            ? kPrimaryColor.withValues(alpha: 0.8)
            : Colors.transparent,
        side: BorderSide(
          color: kPrimaryColor.withValues(alpha: 0.3),
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
