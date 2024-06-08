import 'package:flutter/material.dart';

import '../../screens/search_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.blueAccent),
      // ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // CircleAvatar(
          //   child: Text('PD'),
          // ),
          const Center(
            child: Icon(
              Icons.menu,
              size: 24,
            ),
          ),
          const Text(
            'FilmMate',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
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
