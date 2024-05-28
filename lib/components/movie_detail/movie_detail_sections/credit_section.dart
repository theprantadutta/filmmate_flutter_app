import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../constants/colors.dart';

class CreditSection extends StatelessWidget {
  final String title;
  final List<String> names;

  const CreditSection({
    super.key,
    required this.names,
    required this.title,
  });

  String getNamesFromArray(List<String> names) {
    if (names.isEmpty) {
      return 'N/A';
    }

    String str = '';
    for (var i = 0; i < names.length; i++) {
      if (i == 0) {
        str += names[i];
        continue;
      }
      str += ', ${names[i]}';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          height: names.length > 2 ? 80 : 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: '$title : ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: getNamesFromArray(
                          names,
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
