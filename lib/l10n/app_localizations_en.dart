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
  String selectedCount(Object count) {
    return '$count selected';
  }

  @override
  String get version => 'Version 1.0.0';

  @override
  String get profileTitle => 'Profile';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get noInternet => 'No internet connection';

  @override
  String get guestName => 'User';

  @override
  String get scoreLabel => 'Score';

  @override
  String pointsLabel(Object count) {
    return '$count points';
  }

  @override
  String get accumulatedPoints => 'Accumulated points';

  @override
  String get accountLabel => 'Account';

  @override
  String get nameLabel => 'Name';

  @override
  String get emailLabel => 'Email';

  @override
  String get signOut => 'Sign out';

  @override
  String get loginToSync => 'Sign in to sync your data and not lose it';

  @override
  String get loginOrRegister => 'Sign in / Register';

  @override
  String get noData => 'No data';

  @override
  String get noPlayersYet => 'No players in the ranking yet';

  @override
  String get createAccount => 'Create account';

  @override
  String get signIn => 'Sign in';

  @override
  String get checkEmail => 'Check your email';

  @override
  String emailVerificationSent(Object email) {
    return 'We sent a verification link to $email';
  }

  @override
  String get backToHome => 'Back to home';

  @override
  String get or => 'or';

  @override
  String get yourName => 'Your name';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get continueWithEmail => 'Continue with email';

  @override
  String get haveAccountSignIn => 'Already have an account? Sign in';

  @override
  String get noAccountRegister => 'Don\'t have an account? Register';

  @override
  String get termsNotice =>
      'By continuing, you agree to the Terms of Service and Privacy Policy.';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get fillAllFields => 'Fill in all fields';

  @override
  String get newAlarm => 'New alarm';

  @override
  String get editAlarm => 'Edit alarm';

  @override
  String get done => 'Done';

  @override
  String get selectAtLeastOneDay => 'Select at least one day';

  @override
  String nextAlarmIn(Object time) {
    return 'Next alarm in $time';
  }

  @override
  String get onceLabel => 'Once';

  @override
  String get customizeLabel => 'Customize';

  @override
  String get alarmName => 'Alarm name';

  @override
  String get ringtoneSetting => 'Ringtone';

  @override
  String get defaultAlarmSound => 'Default alarm sound';

  @override
  String get vibrateLabel => 'Vibrate';

  @override
  String get amLabel => 'AM';

  @override
  String get pmLabel => 'PM';

  @override
  String get monShort => 'M';

  @override
  String get tueShort => 'T';

  @override
  String get wedShort => 'W';

  @override
  String get thuShort => 'T';

  @override
  String get friShort => 'F';

  @override
  String get satShort => 'S';

  @override
  String get sunShort => 'S';

  @override
  String get monLong => 'Mon';

  @override
  String get tueLong => 'Tue';

  @override
  String get wedLong => 'Wed';

  @override
  String get thuLong => 'Thu';

  @override
  String get friLong => 'Fri';

  @override
  String get satLong => 'Sat';

  @override
  String get sunLong => 'Sun';

  @override
  String get ringOnce => 'Ring once';

  @override
  String get everyDay => 'Every day';

  @override
  String get weekdays => 'Mon to Fri';

  @override
  String get noActiveAlarms => 'No active alarms';

  @override
  String get youWon => 'YOU WON';

  @override
  String get youLost => 'YOU LOST';

  @override
  String wordLabel(Object word) {
    return 'Word: $word';
  }

  @override
  String scoreCapsLabel(Object count) {
    return 'SCORE: $count PTS';
  }

  @override
  String get aboutTitle => 'About Alarmle';

  @override
  String get aboutDescription =>
      'Alarmle is an alarm app with Wordle integration. Wake up every morning solving the daily puzzle and test your mind.';

  @override
  String get featuresTitle => 'Features';

  @override
  String get customAlarms => 'Custom alarms';

  @override
  String get customAlarmsDesc => 'Set alarms with repetition and custom sounds';

  @override
  String get wordleGame => 'Wordle minigame';

  @override
  String get wordleGameDesc =>
      'Show your skills solving the puzzle to turn off the alarm';

  @override
  String get cloudSync => 'Cloud sync';

  @override
  String get cloudSyncDesc => 'Sync your data and scores with Firebase';

  @override
  String get multiLanguage => 'Multilingual';

  @override
  String get multiLanguageDesc =>
      'Available in Spanish, English, French, Portuguese and Chinese';

  @override
  String get technologiesTitle => 'Technologies';

  @override
  String get copyright => '© 2024 Alarmle. All rights reserved.';

  @override
  String get solveWordleToStop => 'Solve the Wordle to stop the alarm';

  @override
  String get dismissButton => 'Dismiss';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageFrench => 'French';

  @override
  String get languagePortuguese => 'Portuguese';

  @override
  String get languageChinese => 'Chinese';

  @override
  String get customLanguageLabel => 'Custom language';

  @override
  String get selectLanguageHint => 'Select a language';

  @override
  String nextAlarmDays(Object days) {
    return 'Next alarm in $days day';
  }

  @override
  String nextAlarmHours(Object hours, Object mins) {
    return '${hours}h ${mins}min';
  }

  @override
  String nextAlarmMinutes(Object mins) {
    return '$mins min';
  }

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountConfirmTitle => 'Delete account';

  @override
  String get deleteAccountConfirmMessage =>
      'Are you sure? This action cannot be undone.';

  @override
  String get recentLoginRequired =>
      'Please log in again to delete your account';

  @override
  String get deleteAccountError => 'Error deleting account. Please try again.';
}
