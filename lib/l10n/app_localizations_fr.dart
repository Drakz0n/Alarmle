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
  String get snoozeLabel => 'Minutes de répétition';

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
  String selectedCount(Object count) {
    return '$count sélectionnés';
  }

  @override
  String get version => 'Version 1.0.0';

  @override
  String get profileTitle => 'Profil';

  @override
  String get online => 'En ligne';

  @override
  String get offline => 'Hors ligne';

  @override
  String get noInternet => 'Pas de connexion internet';

  @override
  String get guestName => 'Utilisateur';

  @override
  String get scoreLabel => 'Score';

  @override
  String pointsLabel(Object count) {
    return '$count points';
  }

  @override
  String get accumulatedPoints => 'Points accumulés';

  @override
  String get accountLabel => 'Compte';

  @override
  String get nameLabel => 'Nom';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get signOut => 'Déconnexion';

  @override
  String get loginToSync =>
      'Connectez-vous pour synchroniser vos données et ne pas les perdre';

  @override
  String get loginOrRegister => 'Connexion / Inscription';

  @override
  String get noData => 'Aucune donnée';

  @override
  String get noPlayersYet => 'Aucun joueur dans le classement';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get signIn => 'Se connecter';

  @override
  String get checkEmail => 'Vérifiez votre e-mail';

  @override
  String emailVerificationSent(Object email) {
    return 'Nous avons envoyé un lien de vérification à $email';
  }

  @override
  String get backToHome => 'Retour à l\'accueil';

  @override
  String get or => 'ou';

  @override
  String get yourName => 'Votre nom';

  @override
  String get enterEmail => 'Entrez votre e-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get continueWithEmail => 'Continuer avec e-mail';

  @override
  String get haveAccountSignIn => 'Vous avez déjà un compte? Connectez-vous';

  @override
  String get noAccountRegister => 'Vous n\'avez pas de compte? Inscrivez-vous';

  @override
  String get termsNotice =>
      'En continuant, vous acceptez les Conditions d\'utilisation et la Politique de confidentialité.';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get fillAllFields => 'Remplissez tous les champs';

  @override
  String get newAlarm => 'Nouvelle alarme';

  @override
  String get editAlarm => 'Modifier l\'alarme';

  @override
  String get done => 'Terminé';

  @override
  String get selectAtLeastOneDay => 'Sélectionnez au moins un jour';

  @override
  String nextAlarmIn(Object time) {
    return 'Prochaine alarme dans $time';
  }

  @override
  String get onceLabel => 'Une fois';

  @override
  String get customizeLabel => 'Personnaliser';

  @override
  String get alarmName => 'Nom de l\'alarme';

  @override
  String get ringtoneSetting => 'Sonnerie';

  @override
  String get defaultAlarmSound => 'Son d\'alarme par défaut';

  @override
  String get vibrateLabel => 'Vibrer';

  @override
  String get amLabel => 'AM';

  @override
  String get pmLabel => 'PM';

  @override
  String get monShort => 'L';

  @override
  String get tueShort => 'M';

  @override
  String get wedShort => 'M';

  @override
  String get thuShort => 'J';

  @override
  String get friShort => 'V';

  @override
  String get satShort => 'S';

  @override
  String get sunShort => 'D';

  @override
  String get monLong => 'Lun';

  @override
  String get tueLong => 'Mar';

  @override
  String get wedLong => 'Mer';

  @override
  String get thuLong => 'Jeu';

  @override
  String get friLong => 'Ven';

  @override
  String get satLong => 'Sam';

  @override
  String get sunLong => 'Dim';

  @override
  String get ringOnce => 'Sonner une fois';

  @override
  String get everyDay => 'Tous les jours';

  @override
  String get weekdays => 'Lun au Ven';

  @override
  String get noActiveAlarms => 'Aucune alarme active';

  @override
  String get youWon => 'GAGNÉ';

  @override
  String get youLost => 'PERDU';

  @override
  String wordLabel(Object word) {
    return 'Mot: $word';
  }

  @override
  String scoreCapsLabel(Object count) {
    return 'SCORE: $count PTS';
  }

  @override
  String get aboutTitle => 'À propos d\'Alarmle';

  @override
  String get aboutDescription =>
      'Alarmle est une application d\'alarme avec intégration Wordle. Réveillez-vous chaque matin en résolvant le puzzle quotidien et testez votre esprit.';

  @override
  String get featuresTitle => 'Fonctionnalités';

  @override
  String get customAlarms => 'Alarmes personnalisées';

  @override
  String get customAlarmsDesc =>
      'Configurez des alarmes avec répétition et sons personnalisés';

  @override
  String get wordleGame => 'Mini-jeu Wordle';

  @override
  String get wordleGameDesc =>
      'Montrez vos compétences en résolvant le puzzle pour éteindre l\'alarme';

  @override
  String get cloudSync => 'Synchronisation cloud';

  @override
  String get cloudSyncDesc =>
      'Synchronisez vos données et scores avec Firebase';

  @override
  String get multiLanguage => 'Multilingue';

  @override
  String get multiLanguageDesc =>
      'Disponible en espagnol, anglais, français, portugais et chinois';

  @override
  String get technologiesTitle => 'Technologies';

  @override
  String get copyright => '© 2024 Alarmle. Tous droits réservés.';

  @override
  String get solveWordleToStop => 'Résolvez le Wordle pour arrêter l\'alarme';

  @override
  String get dismissButton => 'Rejeter';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageFrench => 'Français';

  @override
  String get languagePortuguese => 'Portugais';

  @override
  String get languageChinese => 'Chinois';

  @override
  String get customLanguageLabel => 'Langue personnalisée';

  @override
  String get selectLanguageHint => 'Sélectionnez une langue';

  @override
  String nextAlarmDays(Object days) {
    return 'Prochaine alarme dans $days jour';
  }

  @override
  String nextAlarmHours(Object hours, Object mins) {
    return '$hours h $mins min';
  }

  @override
  String nextAlarmMinutes(Object mins) {
    return '$mins min';
  }
}
