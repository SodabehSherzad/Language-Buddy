import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferences? _prefs;

  static const String _selectedLanguageKey = 'selected_language';
  static const String _isRandomKey = 'is_random';
  static const String _isTtsEnabledKey = 'is_tts_enabled';
  static const String _isExpansionEnabledKey = 'is_expansion_enabled';
  static const String _isDarkModeEnabledKey = 'is_dark_mode_enabled';

  // Initialize SharedPreferences
  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    // Check if the keys don't exist before setting defaults
    if (!_prefs!.containsKey(_isRandomKey)) {
      _prefs!.setBool(_isRandomKey, false);
    }

    if (!_prefs!.containsKey(_isTtsEnabledKey)) {
      _prefs!.setBool(_isTtsEnabledKey, true);
    }

    if (!_prefs!.containsKey(_isExpansionEnabledKey)) {
      _prefs!.setBool(_isExpansionEnabledKey, false);
    }

    if (!_prefs!.containsKey(_isDarkModeEnabledKey)) {
      _prefs!.setBool(_isDarkModeEnabledKey, false);
    }
  }



  // Get the selected language with a default value of 'en'
  static String getSelectedLanguage() {
    return _prefs!.getString(_selectedLanguageKey) ?? 'en';
  }

  // Set the selected language
  static Future<void> setSelectedLanguage(String language) {
    return _prefs!.setString(_selectedLanguageKey, language);
  }

  // Get the isRandom value with a default value of false
  static bool getIsRandom() {
    return _prefs!.getBool(_isRandomKey) ?? false;
  }

  // Set the isRandom value
  static Future<void> setIsRandom(bool isRandom) {
    return _prefs!.setBool(_isRandomKey, isRandom);
  }

  // Get the isTtsEnabled value with a default value of false
  static bool getIsTtsEnabled() {
    return _prefs!.getBool(_isTtsEnabledKey) ?? true;
  }

  // Set the isTtsEnabled value
  static Future<void> setIsTtsEnabled(bool isTtsEnabled) {
    return _prefs!.setBool(_isTtsEnabledKey, isTtsEnabled);
  }

  // Get the isExpansionEnabled value with a default value of false
  static bool getIsExpansionEnabled() {
    return _prefs!.getBool(_isExpansionEnabledKey) ?? false;
  }

  // Set the isExpansionEnabled value
  static Future<void> setIsExpansionEnabled(bool isExpansionEnabled) {
    return _prefs!.setBool(_isExpansionEnabledKey, isExpansionEnabled);
  }


  // Get the isDarkModeEnabled value with a default value of false
  static bool getIsDarkModeEnabled() {
    return _prefs!.getBool(_isDarkModeEnabledKey) ?? false;
  }

  // Set the isDarkModeEnabled value
  static Future<void> setIsDarkModeEnabled(bool isDarkModeEnabled) {
    return _prefs!.setBool(_isDarkModeEnabledKey, isDarkModeEnabled);
  }
}