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
  String get snoozeLabel => 'Minutos de soneca';

  @override
  String get volumeLabel => 'Volume do aplicativo';

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
  String get addAlarmHint => 'Toque + para adicionar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get selectAll => 'Selecionar tudo';

  @override
  String get deselectAll => 'Desmarcar tudo';

  @override
  String selectedCount(Object count) {
    return '$count selecionados';
  }

  @override
  String get version => 'Versão 1.0.0';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get noInternet => 'Sem conexão com a internet';

  @override
  String get guestName => 'Usuário';

  @override
  String get scoreLabel => 'Pontuação';

  @override
  String pointsLabel(Object count) {
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
  String get loginToSync =>
      'Faça login para sincronizar seus dados e não perdê-los';

  @override
  String get loginOrRegister => 'Entrar / Cadastrar';

  @override
  String get noData => 'Sem dados';

  @override
  String get noPlayersYet => 'Nenhum jogador no ranking ainda';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get signIn => 'Entrar';

  @override
  String get checkEmail => 'Verifique seu e-mail';

  @override
  String emailVerificationSent(Object email) {
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
  String get haveAccountSignIn => 'Já tem uma conta? Entre';

  @override
  String get noAccountRegister => 'Não tem uma conta? Cadastre-se';

  @override
  String get termsNotice =>
      'Ao continuar, você concorda com os Termos de Serviço e a Política de Privacidade.';

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
  String nextAlarmIn(Object time) {
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
  String get amLabel => 'AM';

  @override
  String get pmLabel => 'PM';

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
  String get weekdays => 'Seg a Sex';

  @override
  String get noActiveAlarms => 'Sem alarmes ativos';

  @override
  String get youWon => 'VOCÊ GANHOU';

  @override
  String get youLost => 'VOCÊ PERDEU';

  @override
  String wordLabel(Object word) {
    return 'Palavra: $word';
  }

  @override
  String scoreCapsLabel(Object count) {
    return 'PONTOS: $count PTS';
  }

  @override
  String get aboutTitle => 'Sobre o Alarmle';

  @override
  String get aboutDescription =>
      'Alarmle é um aplicativo de alarme com integração Wordle. Acorde todas as manhãs resolvendo o puzzle diário e teste sua mente.';

  @override
  String get featuresTitle => 'Recursos';

  @override
  String get customAlarms => 'Alarmes personalizados';

  @override
  String get customAlarmsDesc =>
      'Configure alarmes com repetição e sons personalizados';

  @override
  String get wordleGame => 'Minijogo Wordle';

  @override
  String get wordleGameDesc =>
      'Mostre suas habilidades resolvendo o puzzle para desligar o alarme';

  @override
  String get cloudSync => 'Sincronização em nuvem';

  @override
  String get cloudSyncDesc =>
      'Sincronize seus dados e pontuações com o Firebase';

  @override
  String get multiLanguage => 'Multilíngue';

  @override
  String get multiLanguageDesc =>
      'Disponível em espanhol, inglês, francês, português e chinês';

  @override
  String get technologiesTitle => 'Tecnologias';

  @override
  String get copyright => '© 2024 Alarmle. Todos os direitos reservados.';

  @override
  String get solveWordleToStop => 'Resolva o Wordle para parar o alarme';

  @override
  String get dismissButton => 'Descartar';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languageFrench => 'Francês';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get languageChinese => 'Chinês';

  @override
  String get customLanguageLabel => 'Idioma personalizado';

  @override
  String get selectLanguageHint => 'Selecione um idioma';

  @override
  String nextAlarmDays(Object days) {
    return 'Próximo alarme em $days dia';
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
