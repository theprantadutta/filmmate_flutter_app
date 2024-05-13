import 'package:flutter/material.dart';

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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // CircleAvatar(
          //   child: Text('PD'),
          // ),
          Center(
            child: Icon(
              Icons.menu,
              size: 24,
            ),
          ),
          Text(
            'FilmMate',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          Center(
            child: Icon(
              Icons.search,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
