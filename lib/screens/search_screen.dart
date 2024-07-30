import 'dart:async';

import 'package:flutter/material.dart';

import '../components/common/main_layout_header.dart';
import '../components/common/vertical_movie_section.dart';
import '../components/layouts/main_layout.dart';
import '../constants/colors.dart';
import '../dtos/movie_dto.dart';
import '../services/database_service.dart';

class SearchScreen extends StatefulWidget {
  static const kRouteName = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // String movieSearchTerm = '';
  bool fetchingMovies = false;
  bool hasError = false;

  Timer? _debounce;

  List<MovieDto> searchedMovies = [];

  Future<void> handleMovieSearch(String searchTerm) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (searchTerm.length < 3) return;
      try {
        setState(() {
          fetchingMovies = true;
        });
        final movieSectionResponse =
            await DatabaseService().searchMoviesByTitle(searchTerm);

        setState(() {
          searchedMovies = movieSectionResponse.movies;
          fetchingMovies = false;
          hasError = false;
        });
      } catch (e) {
        setState(() {
          hasError = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            MainLayoutHeader(fetching: fetchingMovies, title: 'Search Movies'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                onChanged: handleMovieSearch,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kPrimaryColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: kPrimaryColor),
                  ),
                  hintText: 'Enter Movie Title',
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.9,
              child: hasError
                  ? const Center(
                      child: Text('Something Went Wrong'),
                    )
                  : VerticalMovieSection(
                      movies: searchedMovies,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
