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
  String pointsLabel(int count) {
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
  String get signOut => 'Se déconnecter';

  @override
  String get loginToSync => 'Connectez-vous pour synchroniser vos données';

  @override
  String get loginOrRegister => 'Se connecter / S\'inscrire';

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
  String emailVerificationSent(String email) {
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
  String get haveAccountSignIn => 'Vous avez déjà un compte ? Connectez-vous';

  @override
  String get noAccountRegister => 'Pas de compte ? Inscrivez-vous';

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
  String nextAlarmIn(String time) {
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
  String get amLabel => 'a. m.';

  @override
  String get pmLabel => 'p. m.';

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
  String get weekdays => 'Lundi à vendredi';

  @override
  String get noActiveAlarms => 'Aucune alarme active';

  @override
  String get youWon => 'GAGNÉ';

  @override
  String get youLost => 'PERDU';

  @override
  String wordLabel(String word) {
    return 'Mot: $word';
  }

  @override
  String scoreCapsLabel(int count) {
    return 'SCORE: $count PTS';
  }
}
