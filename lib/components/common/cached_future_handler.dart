import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/colors.dart';

class CachedFutureHandler<T, K> extends HookWidget {
  final String id;
  final Future<T> Function() future;
  final Widget Function(BuildContext, T) builder;
  final double defaultHeight;

  const CachedFutureHandler({
    super.key,
    required this.id,
    required this.future,
    required this.builder,
    this.defaultHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: future,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return SizedBox(
    //         height: defaultHeight,
    //         child: Center(
    //           child: LoadingAnimationWidget.fourRotatingDots(
    //             color: kPrimaryColor,
    //             size: 40,
    //           ),
    //         ),
    //       );
    //     }
    //     if ((snapshot.hasError)) {
    //       if (kDebugMode) {
    //         print(snapshot.data);
    //         print('Something Went Wrong When Getting data from Future');
    //         print(snapshot.error);
    //       }
    //       return SizedBox(
    //         height: defaultHeight,
    //         child: const Center(
    //           child: Text('Something Went Wrong'),
    //         ),
    //       );
    //     }
    //     return builder(context, snapshot);
    //   },
    // );
    final data = useQuery<T, K>([id], future);
    return Builder(
      builder: (context) {
        if (data.isLoading) {
          return Center(
            child: SizedBox(
              height: defaultHeight,
              child: Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: kPrimaryColor,
                  size: 40,
                ),
              ),
            ),
          );
        }

        if (data.isError) {
          if (kDebugMode) {
            print('Something Went Wrong When Getting data from Future');
            print(data.error);
          }
          return SizedBox(
            height: defaultHeight,
            child: const Center(
              child: Text('Something Went Wrong'),
            ),
          );

          // return Center(child: Text(posts.error!.toString()));
        }

        // return ListView.builder(
        //   itemCount: posts.data!.length,
        //   itemBuilder: (context, index) {
        //     final post = posts.data![index];
        //     return ListTile(
        //       title: Text(post.title),
        //     );
        //   },
        // );
        if (data.data == null) throw Exception("Something Went Wrong");
        return builder(context, data.data as T);
      },
    );
  }
}
