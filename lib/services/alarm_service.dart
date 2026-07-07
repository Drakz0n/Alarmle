import 'package:alarm/alarm.dart' as alarm_pkg;
import 'package:alarmle/models/alarm_model.dart';

class AlarmService {
  static final AlarmService _instance = AlarmService._internal();
  factory AlarmService() => _instance;
  AlarmService._internal();

  static Future<void> init() async {
    await alarm_pkg.Alarm.init();
  }

  Future<void> schedule(
    Alarm alarmModel,
    DateTime triggerTime, {
    String? notificationTitle,
    String? notificationBody,
    String? stopButtonText,
  }) async {
    final now = DateTime.now();
    if (triggerTime.isBefore(now)) {
      triggerTime = triggerTime.add(const Duration(days: 1));
    }

    // Resolver la ruta del audio: si es ruta absoluta (custom), usar directo;
    // si no, prefijar con assets/sounds/ (ringtones embebidos).
    final ringtone = alarmModel.ringtone.isEmpty || alarmModel.ringtone == 'default'
        ? 'alarm_tone.wav'
        : alarmModel.ringtone;
    final assetPath = ringtone.startsWith('/')
        ? ringtone
        : 'assets/sounds/$ringtone';

    final settings = alarm_pkg.AlarmSettings(
      id: alarmModel.id.hashCode,
      dateTime: triggerTime,
      assetAudioPath: assetPath,
      loopAudio: true,
      vibrate: alarmModel.vibrate,
      volume: 1.0,
      fadeDuration: 0.0,
      androidFullScreenIntent: true,
      // --- NUEVA SINTAXIS PARA LA NOTIFICACIÓN ---
      notificationSettings: alarm_pkg.NotificationSettings(
        title: notificationTitle ?? '¡Alarma!',
        body: notificationBody ?? 'Resuelve el Wordle para detener la alarma',
        stopButton: stopButtonText ?? 'Descartar', // Requerido en las nuevas versiones
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