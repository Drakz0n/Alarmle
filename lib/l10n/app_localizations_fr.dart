// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get homeTitle => 'Accueil';

  @override
  String get profileTab => 'Profil';

  @override
  String get leaderboardTab => 'Classement';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get ringtoneLabel => 'Sonnerie par défaut';

  @override
  String get snoozeLabel => 'Minutes de report';

  @override
  String get volumeLabel => 'Volume de l\'application';

  @override
  String get languageLabel => 'Langue';

  @override
  String get profileLabel => 'Profil';

  @override
  String get alarmsLabel => 'Alarmes';

  @override
  String get rankingLabel => 'Classement';

  @override
  String get settingsLabel => 'Paramètres';

  @override
  String get aboutLabel => 'À propos';

  @override
  String get noAlarms => 'Aucune alarme';

  @override
  String get addAlarmHint => 'Appuyez sur + pour en ajouter une';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get selectAll => 'Tout sélectionner';

  @override
  String get deselectAll => 'Tout désélectionner';

  @override
  String selectedCount(int count) {
    return '$count sélectionnés';
  }

  @override
  String get version => 'Version 1.0.0';
}
