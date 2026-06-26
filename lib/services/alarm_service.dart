import 'package:alarm/alarm.dart' as alarm_pkg;
import 'package:alarmle/models/alarm_model.dart';

class AlarmService {
  static final AlarmService _instance = AlarmService._internal();
  factory AlarmService() => _instance;
  AlarmService._internal();

  static Future<void> init() async {
    await alarm_pkg.Alarm.init();
  }

  Future<void> schedule(Alarm alarmModel, DateTime triggerTime) async {
    final now = DateTime.now();
    if (triggerTime.isBefore(now)) {
      triggerTime = triggerTime.add(const Duration(days: 1));
    }

    final settings = alarm_pkg.AlarmSettings(
      id: alarmModel.id.hashCode,
      dateTime: triggerTime,
      assetAudioPath: 'assets/sounds/alarm_tone.mp3',
      loopAudio: true,
      vibrate: alarmModel.vibrate,
      volume: 1.0,
      fadeDuration: 0.0,
      androidFullScreenIntent: true,
      // --- NUEVA SINTAXIS PARA LA NOTIFICACIÓN ---
      notificationSettings: const alarm_pkg.NotificationSettings(
        title: '¡Alarma!',
        body: 'Resuelve el Wordle para detener la alarma',
        stopButton: 'Descartar', // Requerido en las nuevas versiones
      ),
    );
    
    await alarm_pkg.Alarm.set(alarmSettings: settings);
  }

  Future<void> cancel(int id) async {
    await alarm_pkg.Alarm.stop(id);
  }

  Future<void> cancelAll() async {
    await alarm_pkg.Alarm.stopAll();
  }
}