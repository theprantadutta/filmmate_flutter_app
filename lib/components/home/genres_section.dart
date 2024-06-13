import 'package:flutter/material.dart';

import '../../entities/genre.dart';
import '../../screen_arguments/genre_screen_arguments.dart';
import '../../screens/genre_screen.dart';
import '../common/custom_outlined_button.dart';

// class GenresSection extends StatelessWidget {
//   final Genre? selectedGenre;
//   final bool goWhenClicked;

//   final List<Genre> genres;
//   final void Function(Genre currentGenre)? onPressed;

//   const GenresSection({
//     super.key,
//     required this.genres,
//     this.selectedGenre,
//     this.goWhenClicked = true,
//     this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     genres.sort((a, b) => a.name.compareTo(b.name));
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.075,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: genres.length,
//               itemBuilder: (context, index) {
//                 final genre = genres[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: CustomOutlinedButton(
//                     title: genre.name,
//                     selected: selectedGenre?.id == genre.id,
//                     onPressed: () {
//                       if (goWhenClicked) {
//                         Navigator.pushNamed(
//                           context,
//                           GenreScreen.kRouteName,
//                           arguments: GenreScreenArguments(
//                             genre: genre,
//                           ),
//                         );
//                       } else {
//                         onPressed?.call(genre);
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class GenresSection extends StatelessWidget {
  final Genre? selectedGenre;
  final bool goWhenClicked;
  final List<Genre> genres;
  final void Function(Genre currentGenre)? onPressed;

  const GenresSection({
    super.key,
    required this.genres,
    this.selectedGenre,
    this.goWhenClicked = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    genres.sort((a, b) => a.name.compareTo(b.name));

    List<Widget> genreWidgets = genres.map((genre) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: CustomOutlinedButton(
          title: genre.name,
          selected: selectedGenre?.id == genre.id,
          onPressed: () {
            if (goWhenClicked) {
              Navigator.pushNamed(
                context,
                GenreScreen.kRouteName,
                arguments: GenreScreenArguments(
                  genre: genre,
                ),
              );
            } else {
              onPressed?.call(genre);
            }
          },
        ),
      );
    }).toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.075,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: genreWidgets,
        ),
      ),
    );
  }
}
