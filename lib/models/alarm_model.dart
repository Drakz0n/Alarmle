import 'dart:convert';

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

  String get period => hour >= 12 ? 'p. m.' : 'a. m.';

  //helper para mostrar los dias que se repite la alarma
  String get repeatLabel
  {
    const names = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    final active = <String>[];
    for (int i = 0; i < 7; i++) 
    {
      if (repeatDays[i]) active.add(names[i]);
    }
    if (active.isEmpty) return "Timbrar una vez";
    if (active.length == 7) return "Todos los días";
    if (active.length == 5 && !repeatDays[5] && !repeatDays[6]) return "Lunes a viernes";
    return active.join(' ');
  }
}