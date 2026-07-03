// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeTitle => 'Home';

  @override
  String get profileTab => 'Profile';

  @override
  String get leaderboardTab => 'Leaderboard';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get ringtoneLabel => 'Default ringtone';

  @override
  String get snoozeLabel => 'Snooze minutes';

  @override
  String get volumeLabel => 'App volume';

  @override
  String get languageLabel => 'Language';

  @override
  String get profileLabel => 'Profile';

  @override
  String get alarmsLabel => 'Alarms';

  @override
  String get rankingLabel => 'Ranking';

  @override
  String get settingsLabel => 'Settings';

  @override
  String get aboutLabel => 'About';

  @override
  String get noAlarms => 'No alarms';

  @override
  String get addAlarmHint => 'Tap + to add one';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get selectAll => 'Select all';

  @override
  String get deselectAll => 'Deselect all';

  @override
  String selectedCount(int count) {
    return '$count selected';
  }

  @override
  String get version => 'Version 1.0.0';
}
