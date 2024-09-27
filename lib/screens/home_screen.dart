import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/layouts/main_layout.dart';
import '../../services/database_service.dart';
import '../components/common/cached_future_handler.dart';
import '../components/home/home_header.dart';
import '../components/home/home_screen_movie_list.dart';
import '../models/home_screen_response.dart';

class HomeScreen extends StatelessWidget {
  static const kRouteName = '/';

  const HomeScreen({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    // Exit the app
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final defaultHeight = MediaQuery.sizeOf(context).height * 0.87;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _onWillPop(context);
      },
      child: MainLayout(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const HomeHeader(),
                SizedBox(
                  height: defaultHeight,
                  child: CachedFutureHandler<HomeScreenResponse, Exception>(
                    id: 'home-screen-movies',
                    defaultHeight: defaultHeight,
                    future: DatabaseService().getAllHomeScreenData,
                    loadingWidget: const Skeletonizer(
                      child: HomeScreenMovieListSkeletor(),
                    ),
                    builder: (context, data) => HomeScreenMovieList(
                      data: data,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
