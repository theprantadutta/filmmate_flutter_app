import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/floating_change_theme_button.dart';
import '../sidebar/sidebar_drawer.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final bool shouldSafeAreaTopBeFalse;

  const MainLayout({
    super.key,
    required this.body,
    this.shouldSafeAreaTopBeFalse = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final theDarkness = isDarkTheme ? Brightness.light : Brightness.dark;
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarBrightness: theDarkness,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: theDarkness,
        ),
        child: SafeArea(
          top: shouldSafeAreaTopBeFalse,
          child: body,
        ),
      ),
      drawer: const SidebarDrawer(),
      drawerEdgeDragWidth: 100,
      floatingActionButton: kReleaseMode
          ? null // Don't show FloatingActionButton in release (production) mode
          : const FloatingChangeThemeButton(),
    );
  }
}
