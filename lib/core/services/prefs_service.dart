import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  PrefsService._();

  static PrefsService? _instance;
  static late SharedPreferences _prefs;

  static PrefsService get instance => _instance!;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _instance = PrefsService._();
  }

  static const String _onboardingCompletedKey = 'onboarding_completed';

  bool get isOnboardingCompleted =>
      _prefs.getBool(_onboardingCompletedKey) ?? false;

  Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(_onboardingCompletedKey, true);
  }
}
