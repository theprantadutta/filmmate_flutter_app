import 'package:flutter/material.dart';

import '../../main.dart';

class SidebarThemeMode extends StatefulWidget {
  const SidebarThemeMode({super.key});

  @override
  State<SidebarThemeMode> createState() => _SidebarThemeModeState();
}

class _SidebarThemeModeState extends State<SidebarThemeMode> {
  bool isDarkTheme = false;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(
        () => isDarkTheme = Theme.of(context).brightness == Brightness.dark,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.03,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(
                Icons.contrast_outlined,
                size: 18,
              ),
              SizedBox(width: 10),
              Text(
                'Dark Mode',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch.adaptive(
              value: isDarkTheme,
              onChanged: (value) {
                if (value) {
                  setState(() {
                    isDarkTheme = value;
                    MyApp.of(context).changeTheme(ThemeMode.dark);
                  });
                } else {
                  setState(() {
                    isDarkTheme = value;
                    MyApp.of(context).changeTheme(ThemeMode.light);
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
