import 'package:shared_preferences/shared_preferences.dart';
import 'package:alarmle/models/alarm_model.dart';
import 'dart:convert';

class StorageService 
{
  static const _key = 'alarms';

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
}