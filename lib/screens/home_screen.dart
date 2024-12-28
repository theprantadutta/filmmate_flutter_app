import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/layouts/main_layout.dart';
import '../../services/database_service.dart';
import '../components/common/cached_future_handler.dart';
import '../components/home/home_header.dart';
import '../components/home/home_screen_movie_list.dart';
import '../models/home_screen_response.dart';
import '../services/app_info_service.dart';
import '../services/app_service.dart';
import '../util/functions.dart';

class HomeScreen extends StatefulWidget {
  static const kRouteName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => checkForMaintenanceAndAppUpdate());
  }

  Future<void> checkForMaintenanceAndAppUpdate() async {
    debugPrint('Running checkForMaintenanceAndAppUpdate...');
    try {
      final appUpdateInfo = await AppInfoService().getAppUpdateInfo();
      // Check Maintenance
      final maintenanceBreak = appUpdateInfo.maintenanceBreak;
      debugPrint('Maintenance Break: $maintenanceBreak');
      if (maintenanceBreak) {
        debugPrint('Maintenance Break, returning...');
        if (!mounted) return;
        await AppService.showMaintenanceDialog(context);
        return;
      }
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentAppVersion = packageInfo.version;
      final currentVersion = appUpdateInfo.currentVersion;
      debugPrint('Current App Version: $currentAppVersion');
      if (!mounted) return;
      if (compareVersion(currentVersion, currentAppVersion) == 1) {
        AppService.showUpdateDialog(context, currentVersion);
      }
    } catch (e) {
      debugPrint('Something went wrong while checking for app update');
      debugPrint(e.toString());
      // showErrorToast(
      //   context: context,
      //   title: 'Something Went Wrong',
      //   description: 'Failed to check App Update,',
      // );
    }
  }

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
