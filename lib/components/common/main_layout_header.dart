import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/colors.dart';

class MainLayoutHeader extends StatelessWidget {
  final bool fetching;
  final String title;

  const MainLayoutHeader({
    super.key,
    required this.fetching,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            padding: const EdgeInsets.all(0),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(width: 10),
          if (fetching)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: kPrimaryColor,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
