import 'package:flutter/material.dart';

import '../../screens/search_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: const Center(
              child: Icon(
                Icons.menu,
                size: 24,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Film',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                TextSpan(
                  text: 'Mate',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 2,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
              SearchScreen.kRouteName,
            ),
            child: const Center(
              child: Icon(
                Icons.search,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
