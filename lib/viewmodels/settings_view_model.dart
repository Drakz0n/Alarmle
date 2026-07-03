import 'package:alarmle/services/core/storage_service.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier 
{
  final StorageService _storage = StorageService();

  String _defaultRingtone = 'Default';
  int _defaultSnoozeMinutes = 5;
  double _appVolume = 0.8;
  bool _isLoading = false;

  String get defaultRingtone => _defaultRingtone;
  int get defaultSnoozeMinutes => _defaultSnoozeMinutes;
  double get appVolume => _appVolume;
  bool get isLoading => _isLoading;

  Future<void> init() async 
  {
    _isLoading = true;
    notifyListeners();

    final settings = await _storage.loadSettings();
    _defaultRingtone = settings['defaultRingtone'] as String;
    _defaultSnoozeMinutes = settings['defaultSnoozeMinutes'] as int;
    _appVolume = settings['appVolume'] as double;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateRingtone(String value) async 
  {
    _defaultRingtone = value;
    await _storage.saveRingtone(value);
    notifyListeners();
  }

  Future<void> updateSnoozeMinutes(int value) async 
  {
    _defaultSnoozeMinutes = value;
    await _storage.saveSnoozeMinutes(value);
    notifyListeners();
  }

  Future<void> updateVolume(double value) async 
  {
    _appVolume = value;
    await _storage.saveVolume(value);
    notifyListeners();
  }
}