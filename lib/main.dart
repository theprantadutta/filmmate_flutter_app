import 'package:flutter/material.dart';

import 'screens/genre_screen.dart';
import 'screens/home_screen.dart';
import 'screens/movie_detail_screen.dart';
import 'screens/movie_section_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  //https://gist.github.com/ben-xx/10000ed3bf44e0143cf0fe7ac5648254
  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // darkTheme: ThemeData.dark(
      //   useMaterial3: true,
      // ), // standard dark theme
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark, // <-- the only line added
          seedColor: Colors.teal,
        ),
      ),
      themeMode: _themeMode,
      initialRoute: HomeScreen.kRouteName,
      routes: {
        HomeScreen.kRouteName: (context) => const HomeScreen(),
        MovieDetailScreen.kRouteName: (context) => const MovieDetailScreen(),
        GenreScreen.kRouteName: (context) => const GenreScreen(),
        MovieSectionScreen.kRouteName: (context) => const MovieSectionScreen(),
      },
    );
  }
}
