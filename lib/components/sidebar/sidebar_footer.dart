import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class SidebarFooter extends StatelessWidget {
  const SidebarFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Developed & Maintained By',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          'Pranta Dutta',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
