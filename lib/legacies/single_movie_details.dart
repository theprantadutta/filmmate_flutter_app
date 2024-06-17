// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import '../components/common/future_handler.dart';
// import '../components/movie_detail/movie_detail_sections/single_movie_section_buttons.dart';
// import '../entities/movie.dart';
// import '../services/database_service.dart';

// class SingleMovieDetails extends StatelessWidget {
//   const SingleMovieDetails({
//     super.key,
//     required this.movie,
//   });

//   final Movie movie;

//   @override
//   Widget build(BuildContext context) {
//     return FutureHandler(
//       future: DatabaseService().getMovieDetailFromDatabase(
//         movie.id,
//       ),
//       builder: (context, snapshot) {
//         final movieDetail = snapshot.data!;
//         return SingleMovieSectionButtons(
//           movieDetail: movieDetail,
//         );
//       },
//     );
//   }
// }
