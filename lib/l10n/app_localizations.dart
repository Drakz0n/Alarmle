import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @profileTab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// No description provided for @leaderboardTab.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboardTab;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @ringtoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Default ringtone'**
  String get ringtoneLabel;

  /// No description provided for @snoozeLabel.
  ///
  /// In en, this message translates to:
  /// **'Snooze minutes'**
  String get snoozeLabel;

  /// No description provided for @volumeLabel.
  ///
  /// In en, this message translates to:
  /// **'App volume'**
  String get volumeLabel;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @profileLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileLabel;

  /// No description provided for @alarmsLabel.
  ///
  /// In en, this message translates to:
  /// **'Alarms'**
  String get alarmsLabel;

  /// No description provided for @rankingLabel.
  ///
  /// In en, this message translates to:
  /// **'Ranking'**
  String get rankingLabel;

  /// No description provided for @settingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsLabel;

  /// No description provided for @aboutLabel.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutLabel;

  /// No description provided for @noAlarms.
  ///
  /// In en, this message translates to:
  /// **'No alarms'**
  String get noAlarms;

  /// No description provided for @addAlarmHint.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add one'**
  String get addAlarmHint;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// No description provided for @deselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect all'**
  String get deselectAll;

  /// No description provided for @selectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedCount(Object count);

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternet;

  /// No description provided for @guestName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get guestName;

  /// No description provided for @scoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get scoreLabel;

  /// No description provided for @pointsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} points'**
  String pointsLabel(Object count);

  /// No description provided for @accumulatedPoints.
  ///
  /// In en, this message translates to:
  /// **'Accumulated points'**
  String get accumulatedPoints;

  /// No description provided for @accountLabel.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountLabel;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @loginToSync.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync your data and not lose it'**
  String get loginToSync;

  /// No description provided for @loginOrRegister.
  ///
  /// In en, this message translates to:
  /// **'Sign in / Register'**
  String get loginOrRegister;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @noPlayersYet.
  ///
  /// In en, this message translates to:
  /// **'No players in the ranking yet'**
  String get noPlayersYet;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @checkEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkEmail;

  /// No description provided for @emailVerificationSent.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification link to {email}'**
  String emailVerificationSent(Object email);

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @continueWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue with email'**
  String get continueWithEmail;

  /// No description provided for @haveAccountSignIn.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get haveAccountSignIn;

  /// No description provided for @noAccountRegister.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Register'**
  String get noAccountRegister;

  /// No description provided for @termsNotice.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to the Terms of Service and Privacy Policy.'**
  String get termsNotice;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Fill in all fields'**
  String get fillAllFields;

  /// No description provided for @newAlarm.
  ///
  /// In en, this message translates to:
  /// **'New alarm'**
  String get newAlarm;

  /// No description provided for @editAlarm.
  ///
  /// In en, this message translates to:
  /// **'Edit alarm'**
  String get editAlarm;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @selectAtLeastOneDay.
  ///
  /// In en, this message translates to:
  /// **'Select at least one day'**
  String get selectAtLeastOneDay;

  /// No description provided for @nextAlarmIn.
  ///
  /// In en, this message translates to:
  /// **'Next alarm in {time}'**
  String nextAlarmIn(Object time);

  /// No description provided for @onceLabel.
  ///
  /// In en, this message translates to:
  /// **'Once'**
  String get onceLabel;

  /// No description provided for @customizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Customize'**
  String get customizeLabel;

  /// No description provided for @alarmName.
  ///
  /// In en, this message translates to:
  /// **'Alarm name'**
  String get alarmName;

  /// No description provided for @ringtoneSetting.
  ///
  /// In en, this message translates to:
  /// **'Ringtone'**
  String get ringtoneSetting;

  /// No description provided for @defaultAlarmSound.
  ///
  /// In en, this message translates to:
  /// **'Default alarm sound'**
  String get defaultAlarmSound;

  /// No description provided for @vibrateLabel.
  ///
  /// In en, this message translates to:
  /// **'Vibrate'**
  String get vibrateLabel;

  /// No description provided for @amLabel.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get amLabel;

  /// No description provided for @pmLabel.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pmLabel;

  /// No description provided for @monShort.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get monShort;

  /// No description provided for @tueShort.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get tueShort;

  /// No description provided for @wedShort.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get wedShort;

  /// No description provided for @thuShort.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get thuShort;

  /// No description provided for @friShort.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get friShort;

  /// No description provided for @satShort.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get satShort;

  /// No description provided for @sunShort.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get sunShort;

  /// No description provided for @monLong.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get monLong;

  /// No description provided for @tueLong.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tueLong;

  /// No description provided for @wedLong.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wedLong;

  /// No description provided for @thuLong.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thuLong;

  /// No description provided for @friLong.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get friLong;

  /// No description provided for @satLong.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get satLong;

  /// No description provided for @sunLong.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunLong;

  /// No description provided for @ringOnce.
  ///
  /// In en, this message translates to:
  /// **'Ring once'**
  String get ringOnce;

  /// No description provided for @everyDay.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get everyDay;

  /// No description provided for @weekdays.
  ///
  /// In en, this message translates to:
  /// **'Mon to Fri'**
  String get weekdays;

  /// No description provided for @noActiveAlarms.
  ///
  /// In en, this message translates to:
  /// **'No active alarms'**
  String get noActiveAlarms;

  /// No description provided for @youWon.
  ///
  /// In en, this message translates to:
  /// **'YOU WON'**
  String get youWon;

  /// No description provided for @youLost.
  ///
  /// In en, this message translates to:
  /// **'YOU LOST'**
  String get youLost;

  /// No description provided for @wordLabel.
  ///
  /// In en, this message translates to:
  /// **'Word: {word}'**
  String wordLabel(Object word);

  /// No description provided for @scoreCapsLabel.
  ///
  /// In en, this message translates to:
  /// **'SCORE: {count} PTS'**
  String scoreCapsLabel(Object count);

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Alarmle'**
  String get aboutTitle;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Alarmle is an alarm app with Wordle integration. Wake up every morning solving the daily puzzle and test your mind.'**
  String get aboutDescription;

  /// No description provided for @featuresTitle.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get featuresTitle;

  /// No description provided for @customAlarms.
  ///
  /// In en, this message translates to:
  /// **'Custom alarms'**
  String get customAlarms;

  /// No description provided for @customAlarmsDesc.
  ///
  /// In en, this message translates to:
  /// **'Set alarms with repetition and custom sounds'**
  String get customAlarmsDesc;

  /// No description provided for @wordleGame.
  ///
  /// In en, this message translates to:
  /// **'Wordle minigame'**
  String get wordleGame;

  /// No description provided for @wordleGameDesc.
  ///
  /// In en, this message translates to:
  /// **'Show your skills solving the puzzle to turn off the alarm'**
  String get wordleGameDesc;

  /// No description provided for @cloudSync.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync'**
  String get cloudSync;

  /// No description provided for @cloudSyncDesc.
  ///
  /// In en, this message translates to:
  /// **'Sync your data and scores with Firebase'**
  String get cloudSyncDesc;

  /// No description provided for @multiLanguage.
  ///
  /// In en, this message translates to:
  /// **'Multilingual'**
  String get multiLanguage;

  /// No description provided for @multiLanguageDesc.
  ///
  /// In en, this message translates to:
  /// **'Available in Spanish, English, French, Portuguese and Chinese'**
  String get multiLanguageDesc;

  /// No description provided for @technologiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Technologies'**
  String get technologiesTitle;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2024 Alarmle. All rights reserved.'**
  String get copyright;

  /// No description provided for @solveWordleToStop.
  ///
  /// In en, this message translates to:
  /// **'Solve the Wordle to stop the alarm'**
  String get solveWordleToStop;

  /// No description provided for @dismissButton.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismissButton;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languagePortuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get languagePortuguese;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get languageChinese;

  /// No description provided for @customLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom language'**
  String get customLanguageLabel;

  /// No description provided for @selectLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Select a language'**
  String get selectLanguageHint;

  /// No description provided for @nextAlarmDays.
  ///
  /// In en, this message translates to:
  /// **'Next alarm in {days} day'**
  String nextAlarmDays(Object days);

  /// No description provided for @nextAlarmHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {mins}min'**
  String nextAlarmHours(Object hours, Object mins);

  /// No description provided for @nextAlarmMinutes.
  ///
  /// In en, this message translates to:
  /// **'{mins} min'**
  String nextAlarmMinutes(Object mins);

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccountConfirmTitle;

  /// No description provided for @deleteAccountConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? This action cannot be undone.'**
  String get deleteAccountConfirmMessage;

  /// No description provided for @recentLoginRequired.
  ///
  /// In en, this message translates to:
  /// **'Please log in again to delete your account'**
  String get recentLoginRequired;

  /// No description provided for @deleteAccountError.
  ///
  /// In en, this message translates to:
  /// **'Error deleting account. Please try again.'**
  String get deleteAccountError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'pt', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
