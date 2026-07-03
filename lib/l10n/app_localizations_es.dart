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

  @override
  String get profileTitle => 'Perfil';

  @override
  String get online => 'En línea';

  @override
  String get offline => 'Sin conexión';

  @override
  String get noInternet => 'Sin conexión a internet';

  @override
  String get guestName => 'Usuario';

  @override
  String get scoreLabel => 'Puntuación';

  @override
  String pointsLabel(int count) {
    return '$count puntos';
  }

  @override
  String get accumulatedPoints => 'Puntos acumulados';

  @override
  String get accountLabel => 'Cuenta';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get emailLabel => 'Correo';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get loginToSync =>
      'Inicia sesión para sincronizar tus datos y no perderlos';

  @override
  String get loginOrRegister => 'Iniciar sesión / Registrarse';

  @override
  String get noData => 'Sin datos';

  @override
  String get noPlayersYet => 'Aún no hay jugadores en el ranking';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get checkEmail => 'Revisa tu correo';

  @override
  String emailVerificationSent(String email) {
    return 'Enviamos un enlace de verificación a $email';
  }

  @override
  String get backToHome => 'Volver al inicio';

  @override
  String get or => 'o';

  @override
  String get yourName => 'Tu nombre';

  @override
  String get enterEmail => 'Ingresa tu correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get continueWithEmail => 'Continuar con correo electrónico';

  @override
  String get haveAccountSignIn => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get noAccountRegister => '¿No tienes cuenta? Regístrate';

  @override
  String get termsNotice =>
      'Al continuar, aceptas los Términos de servicio y la Política de privacidad.';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get fillAllFields => 'Completa todos los campos';

  @override
  String get newAlarm => 'Nueva alarma';

  @override
  String get editAlarm => 'Editar alarma';

  @override
  String get done => 'Hecho';

  @override
  String get selectAtLeastOneDay => 'Selecciona al menos un día';

  @override
  String nextAlarmIn(String time) {
    return 'Siguiente alarma en $time';
  }

  @override
  String get onceLabel => 'Una vez';

  @override
  String get customizeLabel => 'Personalizar';

  @override
  String get alarmName => 'Nombre de la alarma';

  @override
  String get ringtoneSetting => 'Tono de llamadas';

  @override
  String get defaultAlarmSound => 'Sonido de alarma predeterminado';

  @override
  String get vibrateLabel => 'Vibrar';

  @override
  String get amLabel => 'a. m.';

  @override
  String get pmLabel => 'p. m.';

  @override
  String get monShort => 'L';

  @override
  String get tueShort => 'M';

  @override
  String get wedShort => 'X';

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
  String get wedLong => 'Mié';

  @override
  String get thuLong => 'Jue';

  @override
  String get friLong => 'Vie';

  @override
  String get satLong => 'Sáb';

  @override
  String get sunLong => 'Dom';

  @override
  String get ringOnce => 'Timbrar una vez';

  @override
  String get everyDay => 'Todos los días';

  @override
  String get weekdays => 'Lunes a viernes';

  @override
  String get noActiveAlarms => 'Sin alarmas activas';

  @override
  String get youWon => 'GANASTE';

  @override
  String get youLost => 'PERDISTE';

  @override
  String wordLabel(String word) {
    return 'Palabra: $word';
  }

  @override
  String scoreCapsLabel(int count) {
    return 'PUNTAJE: $count PTS';
  }
}
