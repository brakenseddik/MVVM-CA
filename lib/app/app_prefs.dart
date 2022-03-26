import 'package:mvvm/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREFS_KEY_LANG = 'PREFS_KEY_LANG';
const PREFS_KEY_ONBOARDING_SCREEN = 'PREFS_KEY_ONBOARDING_SCREEN';
const PREFS_KEY_USER_LOGIN = 'PREFS_KEY_USER_LOGIN';

class AppPreferences {
  SharedPreferences _sharedPreferences;
  AppPreferences(
    this._sharedPreferences,
  );

  Future<String> getAppLanguage() async {
    String? _language = await _sharedPreferences.getString(PREFS_KEY_LANG);
    if (_language != null && _language.isNotEmpty) {
      return _language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return await _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ??
        false;
  }

  Future<bool> isUserLoggedIn() async {
    return await _sharedPreferences.getBool(PREFS_KEY_USER_LOGIN) ?? false;
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_USER_LOGIN, true);
  }
}
