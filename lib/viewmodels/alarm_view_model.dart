import 'package:alarmle/services/core/storage_service.dart';
import 'package:alarmle/models/alarm_model.dart';
import 'package:flutter/material.dart';

class AlarmViewModel extends ChangeNotifier
{
  final StorageService _storage = StorageService();
  List<Alarm> _alarms = [];

  List<Alarm> get alarms => List.unmodifiable(_alarms);

  //llamar al metodo solo una vez al iniciar la app
  Future<void> init() async 
  {
    _alarms = await _storage.loadAlarms();
    notifyListeners();
  }

  Future<void> addAlarm(Alarm alarm) async 
  {
    _alarms.add(alarm);
    //ordenar por hora del dia (de mas temprano a mas tarde)
    _alarms.sort((a, b) 
    {
      final aMinutes = a.hour * 60 + a.minute;
      final bMinutes = b.hour * 60 + b.minute;
      return aMinutes.compareTo(bMinutes);
    });
    await _storage.saveAlarms(_alarms);
    notifyListeners();
  }

  Future<void> toggleAlarm(String id, bool value) async 
  {
    final index = _alarms.indexWhere((a) => a.id == id);
    if (index == -1) return;
    _alarms[index].isEnabled = value;
    await _storage.saveAlarms(_alarms);
    notifyListeners();
  }

  Future<void> deleteAlarm(String id) async 
  {
    _alarms.removeWhere((a) => a.id == id);
    await _storage.saveAlarms(_alarms);
    notifyListeners();
  }

  String get nextAlarmText 
  {
    final enabled = _alarms.where((a) => a.isEnabled).toList();
    if (enabled.isEmpty) return "Sin alarmas activas";

    final now = DateTime.now();

    //busca la proxima alarma que se activara
    DateTime? nextTrigger;

    for (final alarm in enabled) 
    {
      final todayTrigger = DateTime(now.year, now.month, now.day, alarm.hour, alarm.minute);
      
      //si la hora de hoy aun no ha pasado, es candidata
      final candidate = todayTrigger.isAfter(now) ? todayTrigger : todayTrigger.add(const Duration(days: 1));

      if (nextTrigger == null || candidate.isBefore(nextTrigger)) 
      {
        nextTrigger = candidate;
      }
    }

    if (nextTrigger == null) return "Sin alarmas activas";

    final diff = nextTrigger.difference(now);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;

    if (hours >= 24) 
    {
      final days = diff.inDays;
      return "Siguiente alarma en $days día${days > 1 ? 's' : ''}";
    }
    
    if (hours > 0) return "Siguiente alarma en ${hours}h ${minutes}min";
    return "Siguiente alarma en $minutes minuto${minutes != 1 ? 's' : ''}";
  }
}
