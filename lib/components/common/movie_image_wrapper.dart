import 'package:flutter/material.dart';

class MovieImageWrapper extends StatelessWidget {
  final Widget? child;
  final Decoration? decoration;
  const MovieImageWrapper({super.key, this.child, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.25,
      margin: const EdgeInsets.only(right: 10),
      decoration: decoration,
      child: child,
    );
  }
}
