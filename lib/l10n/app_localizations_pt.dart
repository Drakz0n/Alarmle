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

  @override
  String get profileTitle => 'Perfil';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Sem conexão';

  @override
  String get noInternet => 'Sem conexão à internet';

  @override
  String get guestName => 'Usuário';

  @override
  String get scoreLabel => 'Pontuação';

  @override
  String pointsLabel(int count) {
    return '$count pontos';
  }

  @override
  String get accumulatedPoints => 'Pontos acumulados';

  @override
  String get accountLabel => 'Conta';

  @override
  String get nameLabel => 'Nome';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get signOut => 'Sair';

  @override
  String get loginToSync => 'Entre para sincronizar seus dados e não perdê-los';

  @override
  String get loginOrRegister => 'Entrar / Registrar';

  @override
  String get noData => 'Sem dados';

  @override
  String get noPlayersYet => 'Ainda não há jogadores no ranking';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get signIn => 'Entrar';

  @override
  String get checkEmail => 'Verifique seu e-mail';

  @override
  String emailVerificationSent(String email) {
    return 'Enviamos um link de verificação para $email';
  }

  @override
  String get backToHome => 'Voltar ao início';

  @override
  String get or => 'ou';

  @override
  String get yourName => 'Seu nome';

  @override
  String get enterEmail => 'Digite seu e-mail';

  @override
  String get password => 'Senha';

  @override
  String get continueWithEmail => 'Continuar com e-mail';

  @override
  String get haveAccountSignIn => 'Já tem conta? Entre';

  @override
  String get noAccountRegister => 'Não tem conta? Registre-se';

  @override
  String get termsNotice =>
      'Ao continuar, você concorda com os Termos de Serviço e Política de Privacidade.';

  @override
  String get continueWithGoogle => 'Continuar com Google';

  @override
  String get fillAllFields => 'Preencha todos os campos';

  @override
  String get newAlarm => 'Novo alarme';

  @override
  String get editAlarm => 'Editar alarme';

  @override
  String get done => 'Concluído';

  @override
  String get selectAtLeastOneDay => 'Selecione pelo menos um dia';

  @override
  String nextAlarmIn(String time) {
    return 'Próximo alarme em $time';
  }

  @override
  String get onceLabel => 'Uma vez';

  @override
  String get customizeLabel => 'Personalizar';

  @override
  String get alarmName => 'Nome do alarme';

  @override
  String get ringtoneSetting => 'Toque';

  @override
  String get defaultAlarmSound => 'Som de alarme padrão';

  @override
  String get vibrateLabel => 'Vibrar';

  @override
  String get amLabel => 'a. m.';

  @override
  String get pmLabel => 'p. m.';

  @override
  String get monShort => 'S';

  @override
  String get tueShort => 'T';

  @override
  String get wedShort => 'Q';

  @override
  String get thuShort => 'Q';

  @override
  String get friShort => 'S';

  @override
  String get satShort => 'S';

  @override
  String get sunShort => 'D';

  @override
  String get monLong => 'Seg';

  @override
  String get tueLong => 'Ter';

  @override
  String get wedLong => 'Qua';

  @override
  String get thuLong => 'Qui';

  @override
  String get friLong => 'Sex';

  @override
  String get satLong => 'Sáb';

  @override
  String get sunLong => 'Dom';

  @override
  String get ringOnce => 'Tocar uma vez';

  @override
  String get everyDay => 'Todos os dias';

  @override
  String get weekdays => 'Segunda a sexta';

  @override
  String get noActiveAlarms => 'Sem alarmes ativos';

  @override
  String get youWon => 'VENCEU';

  @override
  String get youLost => 'PERDEU';

  @override
  String wordLabel(String word) {
    return 'Palavra: $word';
  }

  @override
  String scoreCapsLabel(int count) {
    return 'PONTOS: $count PTS';
  }
}
