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

  Future<void> addAlarm(Alarm alarm, {AppLocalizations? l10n}) async 
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
      await AlarmService().schedule(
        alarm, 
        trigger,
        notificationTitle: l10n?.aboutTitle ?? '¡Alarma!',
        notificationBody: l10n?.solveWordleToStop ?? 'Resuelve el Wordle para detener la alarma',
        stopButtonText: l10n?.dismissButton ?? 'Descartar',
      );
    }
    notifyListeners();
  }

  Future<void> toggleAlarm(String id, bool value, {AppLocalizations? l10n}) async
  {
    final index = _alarms.indexWhere((a) => a.id == id);
    if (index == -1) return;
    _alarms[index].isEnabled = value;

    final alarm = _alarms[index];
    final now = DateTime.now();
    final trigger = DateTime(now.year, now.month, now.day, alarm.hour, alarm.minute);

    if (value) {
      await AlarmService().schedule(
        alarm, 
        trigger,
        notificationTitle: l10n?.aboutTitle ?? '¡Alarma!',
        notificationBody: l10n?.solveWordleToStop ?? 'Resuelve el Wordle para detener la alarma',
        stopButtonText: l10n?.dismissButton ?? 'Descartar',
      );
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

  Future<void> editAlarm(Alarm alarm, {AppLocalizations? l10n}) async 
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
      await AlarmService().schedule(
        alarm, 
        trigger,
        notificationTitle: l10n?.aboutTitle ?? '¡Alarma!',
        notificationBody: l10n?.solveWordleToStop ?? 'Resuelve el Wordle para detener la alarma',
        stopButtonText: l10n?.dismissButton ?? 'Descartar',
      );
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

    for (final alarm in enabled) {
      DateTime? trigger;
      final anyDay = alarm.repeatDays.any((d) => d);

      if (!anyDay) {
        final today = DateTime(now.year, now.month, now.day, alarm.hour, alarm.minute);
        trigger = today.isAfter(now)
            ? today
            : today.add(const Duration(days: 1));
      } else {
        for (int offset = 0; offset < 7; offset++) {
          final candidate = DateTime(
            now.year, now.month, now.day, alarm.hour, alarm.minute,
          ).add(Duration(days: offset));
          if (alarm.repeatDays[candidate.weekday - 1] && candidate.isAfter(now)) {
            trigger = candidate;
            break;
          }
        }
      }

      if (trigger != null && (nextTrigger == null || trigger.isBefore(nextTrigger))) {
        nextTrigger = trigger;
      }
    }

    if (nextTrigger == null) return l10n.noActiveAlarms;

    final diff  = nextTrigger.difference(now);
    final days  = diff.inDays;
    final hours = diff.inHours % 24;
    final mins  = diff.inMinutes % 60;

    if (days >= 1) {
      if (hours > 0) return '${l10n.nextAlarmDays(days)} ${l10n.nextAlarmHours(hours, mins)}';
      return '${l10n.nextAlarmDays(days)} y ${l10n.nextAlarmMinutes(mins)}';
    }
    if (hours > 0) return l10n.nextAlarmIn(l10n.nextAlarmHours(hours, mins));
    return l10n.nextAlarmIn(l10n.nextAlarmMinutes(mins));
  }
}
