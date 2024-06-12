import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/colors.dart';

class FutureHandler extends StatelessWidget {
  final Future future;
  final Widget Function(BuildContext, AsyncSnapshot) builder;
  final double defaultHeight;

  const FutureHandler({
    super.key,
    required this.future,
    required this.builder,
    this.defaultHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: defaultHeight,
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
            print(snapshot.data);
            print('Something Went Wrong When Getting data from Future');
            print(snapshot.error);
          }
          return SizedBox(
            height: defaultHeight,
            child: const Center(
              child: Text('Something Went Wrong'),
            ),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
