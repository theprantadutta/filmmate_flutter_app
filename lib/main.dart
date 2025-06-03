import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fquery/fquery.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/shared_preference_keys.dart';
import 'screens/genre_screen.dart';
import 'screens/home_screen.dart';
import 'screens/movie_detail_screen.dart';
import 'screens/movie_section_screen.dart';
import 'screens/search_screen.dart';

final queryClient = QueryClient(
  defaultQueryOptions: DefaultQueryOptions(
    retryCount: 1,
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(
    QueryClientProvider(
      queryClient: queryClient,
      child: const MyApp(),
    ),
  );
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
  SharedPreferences? _sharedPreferences;

  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
      _sharedPreferences?.setBool(kIsDarkModeKey, themeMode == ThemeMode.dark);
    });
  }

  void initializeSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final isDarkMode = _sharedPreferences?.getBool(kIsDarkModeKey);
    if (isDarkMode != null) {
      setState(() {
        _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      });
    }
  }

  Future<void> setOptimalDisplayMode() async {
    final List<DisplayMode> supported = await FlutterDisplayMode.supported;
    final DisplayMode active = await FlutterDisplayMode.active;

    final List<DisplayMode> sameResolution = supported
        .where((DisplayMode m) =>
            m.width == active.width && m.height == active.height)
        .toList()
      ..sort((DisplayMode a, DisplayMode b) =>
          b.refreshRate.compareTo(a.refreshRate));

    final DisplayMode mostOptimalMode =
        sameResolution.isNotEmpty ? sameResolution.first : active;

    await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
  }

  @override
  void initState() {
    super.initState();
    setOptimalDisplayMode();
    initializeSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
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
        SearchScreen.kRouteName: (context) => const SearchScreen(),
      },
    );
  }
}
