import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/colors.dart';

class FutureHandler extends StatelessWidget {
  final Future future;
  final Widget Function(BuildContext, AsyncSnapshot) builder;

  const FutureHandler({super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 100,
            child: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: kPrimaryColor,
                size: 40,
              ),
            ),
          );
        }
        if ((snapshot.hasError)) {
          if (kDebugMode) {
            print(snapshot.error);
          }
          return const SizedBox(
            height: 100,
            child: Center(
              child: Text('Something Went Wrong'),
            ),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
