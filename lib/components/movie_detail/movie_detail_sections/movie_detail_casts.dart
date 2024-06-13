import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../entities/cast.dart';

// class MovieDetailCasts extends StatelessWidget {
//   const MovieDetailCasts({
//     super.key,
//     required this.casts,
//   });

//   final List<Cast> casts;

//   // 'https://image.tmdb.org/t/p/w500/${cast.profilePath!}'
//   List<Widget> _generateCastView(BuildContext context) {
//     List<Widget> allCasts = [];
//     casts.sort(
//       (a, b) => a.order - b.order,
//     );
//     for (var cast in casts) {
//       allCasts.add(
//         Container(
//           height: 210,
//           decoration: BoxDecoration(
//             color: kPrimaryColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           width: MediaQuery.of(context).size.width * 0.3,
//           margin: const EdgeInsets.symmetric(vertical: 5),
//           child: Column(
//             children: [
//               cast.profilePath != null
//                   ? Image.network(
//                       'https://image.tmdb.org/t/p/w500/${cast.profilePath!}',
//                       height: 100,
//                       fit: BoxFit.cover,
//                     )
//                   : Image.asset(
//                       'assets/images/not_found.jpg',
//                       height: 100,
//                       fit: BoxFit.fitHeight,
//                     ),
//               Text(
//                 cast.name,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Text(
//                 cast.character,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w200,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//     return allCasts;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       padding: const EdgeInsets.only(
//         top: 10,
//         left: 0,
//         right: 0,
//         bottom: 10,
//       ),
//       childAspectRatio: 0.7,
//       crossAxisCount: 3,
//       mainAxisSpacing: 4,
//       crossAxisSpacing: 8,
//       children: _generateCastView(context),
//     );
//   }
// }

const double kSingleCastHeight = 210;

class MovieDetailCasts extends StatelessWidget {
  const MovieDetailCasts({
    super.key,
    required this.casts,
  });

  final List<Cast> casts;

  List<Widget> _generateCastView(BuildContext context) {
    List<Widget> allCasts = [];
    casts.sort((a, b) => a.order - b.order);

    for (var cast in casts) {
      allCasts.add(
        Container(
          height: kSingleCastHeight,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          width: MediaQuery.of(context).size.width * 0.3,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              cast.profilePath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500/${cast.profilePath!}',
                      // height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/not_found.jpg',
                      // height: 100,
                      fit: BoxFit.fitHeight,
                    ),
              Text(
                cast.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                cast.character,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return allCasts;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> castWidgets = _generateCastView(context);
    List<Row> rows = [];
    int itemsPerRow = 3;

    for (int i = 0; i < castWidgets.length; i += itemsPerRow) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: castWidgets.sublist(
            i,
            (i + itemsPerRow) > castWidgets.length
                ? castWidgets.length
                : (i + itemsPerRow),
          ),
        ),
      );
    }

    return SizedBox(
      height: kSingleCastHeight * casts.length + 10,
      child: SingleChildScrollView(
        child: Column(
          children: rows,
        ),
      ),
    );
  }
}
