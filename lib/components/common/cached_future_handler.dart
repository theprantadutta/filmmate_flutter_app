import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';

import 'check_mark_indicator.dart';
import 'loading_four_dots.dart';
import 'something_went_wrong.dart';

class CachedFutureHandler<T, K> extends HookWidget {
  final String id;
  final Future<T> Function() future;
  final Widget Function(BuildContext, T) builder;
  final double defaultHeight;
  final int notificationDepth;
  final Widget? loadingWidget;

  const CachedFutureHandler({
    super.key,
    required this.id,
    required this.future,
    required this.builder,
    this.defaultHeight = 100,
    this.notificationDepth = 0,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final data = useQuery<T, K>([id], future);
    return CheckMarkIndicator(
      onRefresh: data.refetch,
      notificationDepth: notificationDepth,
      child: Builder(
        builder: (context) {
          if (data.isLoading) {
            return loadingWidget ??
                Center(
                  child: SizedBox(
                    height: defaultHeight,
                    child: const LoadingFourDots(),
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
              child: SomethingWentWrong(
                onPressed: data.refetch,
              ),
            );
          }

          if (data.data == null) throw Exception("Something Went Wrong");
          return builder(context, data.data as T);
        },
      ),
    );
  }
}
