import 'package:flutter/material.dart';

class PosterBackButton extends StatelessWidget {
  const PosterBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25,
      left: 10,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
