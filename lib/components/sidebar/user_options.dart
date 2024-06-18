import 'package:flutter/material.dart';

import 'sidebar_show_notifications.dart';
import 'sidebar_theme_mode.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.2,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SidebarThemeMode(),
          SidebarShowNotifications(),
        ],
      ),
    );
  }
}
