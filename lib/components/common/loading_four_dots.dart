import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/colors.dart';

class LoadingFourDots extends StatelessWidget {
  const LoadingFourDots({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: kPrimaryColor,
        size: 40,
      ),
    );
  }
}
