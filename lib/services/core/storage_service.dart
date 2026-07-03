import 'package:shared_preferences/shared_preferences.dart';
import 'package:alarmle/models/alarm_model.dart';
import 'dart:convert';

class StorageService 
{
  static const _key = 'alarms';

  // Claves de configuración
  static const _keyRingtone = 'settings_ringtone';
  static const _keySnooze = 'settings_snooze';
  static const _keyVolume = 'settings_volume';

  Future<void> saveAlarms(List<Alarm> alarms) async 
  {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(alarms.map((a) => a.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  Future<List<Alarm>> loadAlarms() async 
  {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];

    final List<dynamic> decoded = jsonDecode(raw);
    return decoded.map((e) => Alarm.fromJson(e)).toList();
  }

  // ─── Settings ───

  Future<Map<String, dynamic>> loadSettings() async 
  {
    final prefs = await SharedPreferences.getInstance();
    return 
    {
      'defaultRingtone': prefs.getString(_keyRingtone) ?? 'Default',
      'defaultSnoozeMinutes': prefs.getInt(_keySnooze) ?? 5,
      'appVolume': prefs.getDouble(_keyVolume) ?? 0.8,
    };
  }

  Future<void> saveRingtone(String value) async 
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyRingtone, value);
  }

  Future<void> saveSnoozeMinutes(int value) async 
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keySnooze, value);
  }

  Future<void> saveVolume(double value) async 
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyVolume, value);
  }
}
