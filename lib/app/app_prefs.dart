import 'package:mvvm/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREFS_KEY_LANG = 'PREFS_KEY_LANG';

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
}
