import 'package:alarmle/l10n/app_localizations.dart';

class Alarm 
{
  final String id;
  final String title;
  final int hour;
  final int minute;
  final List<bool> repeatDays; //[lun, mar, mié, jue, vie, sáb, dom]
  final bool vibrate;
  final int snoozeMinutes;
  final int snoozeCount;
  final String ringtone;
  bool isEnabled;
 
  Alarm
  ({
    required this.id,
    required this.title,
    required this.hour,
    required this.minute,
    required this.repeatDays,
    this.vibrate = true,
    this.snoozeMinutes = 5,
    this.snoozeCount = 3,
    this.ringtone = 'default',
    this.isEnabled = true,
  });

  Map<String, dynamic> toJson() => 
  {
    'id': id,
    'title': title,
    'hour': hour,
    'minute': minute,
    'repeatDays': repeatDays,
    'vibrate': vibrate,
    'snoozeMinutes': snoozeMinutes,
    'snoozeCount': snoozeCount,
    'ringtone': ringtone,
    'isEnabled': isEnabled,
  };

  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm
  (
    id: json['id'],
    title: json['title'],
    hour: json['hour'],
    minute: json['minute'],
    repeatDays: List<bool>.from(json['repeatDays']),
    vibrate: json['vibrate'],
    snoozeMinutes: json['snoozeMinutes'],
    snoozeCount: json['snoozeCount'],
    ringtone: json['ringtone'],
    isEnabled: json['isEnabled'],
  );

  //helper para poder mostrar la hora formateada en la UI
  String get formattedTime 
  {
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final m = minute.toString().padLeft(2, '0');
    return "$h:$m";
  }

  String period(AppLocalizations l10n) => hour >= 12 ? l10n.pmLabel : l10n.amLabel;

  //helper para mostrar los dias que se repite la alarma
  String repeatLabel(AppLocalizations l10n)
  {
    final names = [
      l10n.monLong, l10n.tueLong, l10n.wedLong, l10n.thuLong,
      l10n.friLong, l10n.satLong, l10n.sunLong,
    ];
    final active = <String>[];
    for (int i = 0; i < 7; i++) 
    {
      if (repeatDays[i]) active.add(names[i]);
    }
    if (active.isEmpty) return l10n.ringOnce;
    if (active.length == 7) return l10n.everyDay;
    if (active.length == 5 && !repeatDays[5] && !repeatDays[6]) return l10n.weekdays;
    return active.join(' ');
  }
}