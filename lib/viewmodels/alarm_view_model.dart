import 'package:alarmle/services/core/storage_service.dart';
import 'package:alarmle/services/alarm_service.dart';
import 'package:alarmle/models/alarm_model.dart';
import 'package:alarmle/l10n/app_localizations.dart';
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
    if (alarm.isEnabled) {
      final now = DateTime.now();
      final trigger = DateTime(now.year, now.month, now.day, alarm.hour, alarm.minute);
      await AlarmService().schedule(alarm, trigger);
    }
    notifyListeners();
  }

  Future<void> toggleAlarm(String id, bool value) async
  {
    final index = _alarms.indexWhere((a) => a.id == id);
    if (index == -1) return;
    _alarms[index].isEnabled = value;

    final alarm = _alarms[index];
    final now = DateTime.now();
    final trigger = DateTime(now.year, now.month, now.day, alarm.hour, alarm.minute);

    if (value) {
      await AlarmService().schedule(alarm, trigger);
    } else {
      await AlarmService().cancel(alarm.id.hashCode);
    }

    await _storage.saveAlarms(_alarms);
    notifyListeners();
  }

  Future<void> deleteAlarm(String id) async 
  {
    _alarms.removeWhere((a) => a.id == id);
    await AlarmService().cancel(id.hashCode);
    await _storage.saveAlarms(_alarms);
    notifyListeners();
  }

  Future<void> editAlarm(Alarm alarm) async 
  {
    final index = _alarms.indexWhere((a) => a.id == alarm.id);
    if (index == -1) return;
    _alarms[index] = alarm;
    _alarms.sort((a, b) => (a.hour * 60 + a.minute).compareTo(b.hour * 60 + b.minute));
    await _storage.saveAlarms(_alarms);
    await AlarmService().cancel(alarm.id.hashCode);
    if (alarm.isEnabled) {
      final now = DateTime.now();
      final trigger = DateTime(now.year, now.month, now.day, alarm.hour, alarm.minute);
      await AlarmService().schedule(alarm, trigger);
    }
    notifyListeners();
  }

  String nextAlarmText(AppLocalizations l10n)
  {
    final enabled = _alarms.where((a) => a.isEnabled).toList();
    if (enabled.isEmpty) return l10n.noActiveAlarms;

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

    if (nextTrigger == null) return l10n.noActiveAlarms;

    final diff = nextTrigger.difference(now);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;

    if (hours >= 24) 
    {
      final days = diff.inDays;
      return l10n.nextAlarmIn("$days d");
    }
    
    if (hours > 0) return l10n.nextAlarmIn("${hours}h ${minutes}min");
    return l10n.nextAlarmIn("$minutes min");
  }
}
