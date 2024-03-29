import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../common/floating_change_theme_button.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final bool? showBg;

  const MainLayout({
    super.key,
    this.title,
    this.actions,
    this.showBg,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: body),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          title ?? 'FilmMate',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: kPrimaryColor.withOpacity(0.6),
        actions: actions ?? [],
      ),
      floatingActionButton: kReleaseMode
          ? null // Don't show FloatingActionButton in release (production) mode
          : const FloatingChangeThemeButton(),
    );
  }
}
