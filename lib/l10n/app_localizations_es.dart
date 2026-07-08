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
  String get ringtoneLabel => 'Tono predeterminado';

  @override
  String get snoozeLabel => 'Minutos de posposición';

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
  String selectedCount(Object count) {
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
  String pointsLabel(Object count) {
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
  String get noPlayersYet => 'No hay jugadores en el ranking aún';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get checkEmail => 'Revisa tu correo';

  @override
  String emailVerificationSent(Object email) {
    return 'Enviamos un enlace de verificación a $email';
  }

  @override
  String get backToHome => 'Volver al inicio';

  @override
  String get or => 'o';

  @override
  String get yourName => 'Tu nombre';

  @override
  String get enterEmail => 'Ingresa tu correo';

  @override
  String get password => 'Contraseña';

  @override
  String get continueWithEmail => 'Continuar con correo';

  @override
  String get haveAccountSignIn => '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get noAccountRegister => '¿No tienes una cuenta? Regístrate';

  @override
  String get termsNotice =>
      'Al continuar, aceptas los Términos de Servicio y la Política de Privacidad.';

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
  String nextAlarmIn(Object time) {
    return 'Próxima alarma en $time';
  }

  @override
  String get onceLabel => 'Una vez';

  @override
  String get customizeLabel => 'Personalizar';

  @override
  String get alarmName => 'Nombre de la alarma';

  @override
  String get ringtoneSetting => 'Tono';

  @override
  String get defaultAlarmSound => 'Sonido predeterminado';

  @override
  String get vibrateLabel => 'Vibrar';

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
  String get ringOnce => 'Sonar una vez';

  @override
  String get everyDay => 'Todos los días';

  @override
  String get weekdays => 'Lun a Vie';

  @override
  String get noActiveAlarms => 'Sin alarmas activas';

  @override
  String get youWon => 'GANASTE';

  @override
  String get youLost => 'PERDISTE';

  @override
  String wordLabel(Object word) {
    return 'Palabra: $word';
  }

  @override
  String scoreCapsLabel(Object count) {
    return 'PUNTAJE: $count PTS';
  }

  @override
  String get aboutTitle => 'Acerca de Alarmle';

  @override
  String get aboutDescription =>
      'Alarmle es una aplicación de alarmas con integración de Wordle. Despierta cada mañana resolviendo el puzzle del día y pon a prueba tu mente.';

  @override
  String get featuresTitle => 'Características';

  @override
  String get customAlarms => 'Alarmas personalizadas';

  @override
  String get customAlarmsDesc =>
      'Configura alarmas con repetición y sonidos personalizados';

  @override
  String get wordleGame => 'Minijuego Wordle';

  @override
  String get wordleGameDesc =>
      'Demuestra tu habilidad resolviendo el puzzle para apagar la alarma';

  @override
  String get cloudSync => 'Sincronización en la nube';

  @override
  String get cloudSyncDesc =>
      'Sincroniza tus datos y puntuaciones con Firebase';

  @override
  String get multiLanguage => 'Multilenguaje';

  @override
  String get multiLanguageDesc =>
      'Disponible en español, inglés, francés, portugués y chino';

  @override
  String get technologiesTitle => 'Tecnologías';

  @override
  String get copyright => '© 2024 Alarmle. Todos los derechos reservados.';

  @override
  String get solveWordleToStop => 'Resuelve el Wordle para detener la alarma';

  @override
  String get dismissButton => 'Descartar';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languagePortuguese => 'Portugués';

  @override
  String get languageChinese => 'Mandarín';

  @override
  String get customLanguageLabel => 'Idioma personalizado';

  @override
  String get selectLanguageHint => 'Seleccione un idioma';

  @override
  String nextAlarmDays(Object days) {
    return 'Próxima alarma en $days día';
  }

  @override
  String nextAlarmHours(Object hours, Object mins) {
    return '$hours h $mins min';
  }

  @override
  String nextAlarmMinutes(Object mins) {
    return '$mins min';
  }

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirmTitle => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirmMessage =>
      '¿Estás seguro? Esta acción no se puede deshacer.';

  @override
  String get recentLoginRequired =>
      'Por favor inicia sesión nuevamente para eliminar tu cuenta';

  @override
  String get deleteAccountError =>
      'Error al eliminar la cuenta. Por favor intenta de nuevo.';
}
