import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantapp/core/constants/app_theme.dart';
import 'package:plantapp/core/router/app_router.dart';
import 'package:plantapp/core/services/prefs_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefsService.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(PlantApp(isOnboardingCompleted: PrefsService.instance.isOnboardingCompleted));
}

class PlantApp extends StatefulWidget {
  final bool isOnboardingCompleted;

  const PlantApp({super.key, required this.isOnboardingCompleted});

  @override
  State<PlantApp> createState() => _PlantAppState();
}

class _PlantAppState extends State<PlantApp> {
  late final AppRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter();
    if (widget.isOnboardingCompleted) {
      _router.replaceAll([const HomeRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PlantApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: _router.config(),
    );
  }
}
