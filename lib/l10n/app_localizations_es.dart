// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get homeTitle => 'Inicio';

  @override
  String get profileTab => 'Perfil';

  @override
  String get leaderboardTab => 'Clasificación';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get ringtoneLabel => 'Tono por defecto';

  @override
  String get snoozeLabel => 'Minutos de posponer';

  @override
  String get volumeLabel => 'Volumen de la app';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get profileLabel => 'Perfil';

  @override
  String get alarmsLabel => 'Alarmas';

  @override
  String get rankingLabel => 'Ranking';

  @override
  String get settingsLabel => 'Configuración';

  @override
  String get aboutLabel => 'Acerca de';

  @override
  String get noAlarms => 'Sin alarmas';

  @override
  String get addAlarmHint => 'Toca + para agregar una';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get deselectAll => 'Deseleccionar todo';

  @override
  String selectedCount(int count) {
    return '$count seleccionados';
  }

  @override
  String get version => 'Versión 1.0.0';
}
