import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CheckMarkColors {
  final Color content;
  final Color background;

  const CheckMarkColors({
    required this.content,
    required this.background,
  });
}

class CheckMarkStyle {
  final CheckMarkColors loading;
  final CheckMarkColors completed;

  const CheckMarkStyle({
    required this.loading,
    required this.completed,
  });
}

class CheckMarkIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final int notificationDepth;

  const CheckMarkIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.notificationDepth = 0,
  });

  @override
  State<CheckMarkIndicator> createState() => _CheckMarkIndicatorState();
}

class _CheckMarkIndicatorState extends State<CheckMarkIndicator>
    with SingleTickerProviderStateMixin {
  /// Whether to render check mark instead of spinner
  bool _renderCompleteState = false;

  ScrollDirection prevScrollDirection = ScrollDirection.idle;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final defaultStyle = CheckMarkStyle(
      loading: CheckMarkColors(
        content: isDarkTheme ? Colors.black : Colors.white,
        background: isDarkTheme ? Colors.white : Colors.black,
      ),
      completed: CheckMarkColors(
        content: isDarkTheme ? Colors.black : Colors.white,
        background: Colors.greenAccent,
      ),
    );
    return CustomMaterialIndicator(
      onRefresh: widget.onRefresh,
      durations: const RefreshIndicatorDurations(
        completeDuration: Duration(seconds: 2),
      ),
      notificationPredicate: (notification) =>
          notification.depth == widget.notificationDepth,
      onStateChanged: (change) {
        /// set [_renderCompleteState] to true when controller.state become completed
        if (change.didChange(to: IndicatorState.complete)) {
          _renderCompleteState = true;

          /// set [_renderCompleteState] to false when controller.state become idle
        } else if (change.didChange(to: IndicatorState.idle)) {
          _renderCompleteState = false;
        }
      },
      indicatorBuilder: (
        BuildContext context,
        IndicatorController controller,
      ) {
        final style = _renderCompleteState
            ? defaultStyle.completed
            : defaultStyle.loading;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: style.background,
            shape: BoxShape.circle,
          ),
          child: _renderCompleteState
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: style.content,
                    value: controller.isDragging || controller.isArmed
                        ? controller.value.clamp(0.0, 1.0)
                        : null,
                  ),
                ),
        );
      },
      child: widget.child,
    );
  }
}
