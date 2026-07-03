// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get homeTitle => 'Início';

  @override
  String get profileTab => 'Perfil';

  @override
  String get leaderboardTab => 'Classificação';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get ringtoneLabel => 'Toque padrão';

  @override
  String get snoozeLabel => 'Minutos de adiar';

  @override
  String get volumeLabel => 'Volume do app';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get profileLabel => 'Perfil';

  @override
  String get alarmsLabel => 'Alarmes';

  @override
  String get rankingLabel => 'Ranking';

  @override
  String get settingsLabel => 'Configurações';

  @override
  String get aboutLabel => 'Sobre';

  @override
  String get noAlarms => 'Sem alarmes';

  @override
  String get addAlarmHint => 'Toque + para adicionar um';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get selectAll => 'Selecionar tudo';

  @override
  String get deselectAll => 'Desselecionar tudo';

  @override
  String selectedCount(int count) {
    return '$count selecionados';
  }

  @override
  String get version => 'Versão 1.0.0';
}
