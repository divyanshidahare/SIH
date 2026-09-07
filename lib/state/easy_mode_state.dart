import 'package:flutter/material.dart';

/// Global Accessibility & State Controller for कलाMITRA
/// Handles dynamic "Easy Mode" scaling for low digital literacy and vision-impaired artisans
class EasyModeController extends ChangeNotifier {
  static final EasyModeController _instance = EasyModeController._internal();
  factory EasyModeController() => _instance;
  EasyModeController._internal();

  bool _isEasyMode = false;
  String _selectedLanguage = 'English'; // Default language

  bool get isEasyMode => _isEasyMode;
  String get selectedLanguage => _selectedLanguage;

  // Scaling multipliers when Easy Mode is active
  double get iconScale => _isEasyMode ? 1.45 : 1.0;
  double get textScale => _isEasyMode ? 1.25 : 1.0;
  double get paddingScale => _isEasyMode ? 1.3 : 1.0;
  double get buttonHeight => _isEasyMode ? 64.0 : 52.0;

  void toggleEasyMode() {
    _isEasyMode = !_isEasyMode;
    notifyListeners();
  }

  void setEasyMode(bool value) {
    if (_isEasyMode != value) {
      _isEasyMode = value;
      notifyListeners();
    }
  }

  void setLanguage(String lang) {
    _selectedLanguage = lang;
    notifyListeners();
  }
}

// Global accessor instance
final easyModeController = EasyModeController();
