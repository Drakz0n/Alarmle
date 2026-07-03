import 'dart:async';
import 'package:alarm/alarm.dart' as alarm_package show Alarm;
import 'package:alarmle/services/alarm_service.dart';
import 'package:alarmle/viewmodels/alarm_view_model.dart';
import 'package:alarmle/viewmodels/settings_view_model.dart';
import 'package:alarmle/viewmodels/user_view_model.dart';
import 'package:alarmle/screens/home_screen.dart';
import 'package:alarmle/screens/wordle_alarm_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

// Paleta Wordle unificada
const wordleGreen = Color(0xFF57AC57);
const wordleYellow = Color(0xFFC8B652);
const wordleGray = Color(0xFF939393);
const wordleDarkBg = Color(0xFF333333);
const wordleSurface = Color(0xFF1C1C1E);
const wordleSurfaceLight = Color(0xFF2C2C2E);
const wordleBorder = Color(0xFF3A3A3C);
const wordleTextSecondary = Color(0xFF8E8E93);

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AlarmService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlarmViewModel()..init()),
        ChangeNotifierProvider(create: (_) => UserViewModel()..init()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()..init()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  StreamSubscription? _alarmSub;

  Future<void> _requestPermissions() async {
    await Permission.notification.request();
    final alarmStatus = await Permission.scheduleExactAlarm.status;
    if (alarmStatus.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _requestPermissions();
      await _checkActiveAlarms();
    });

    _alarmSub = alarm_package.Alarm.ringStream.stream.listen((alarmSettings) {
      _navegarAlMinijuego(alarmSettings.id);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _alarmSub?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkActiveAlarms();
    }
  }

  Future<void> _checkActiveAlarms() async {
    final alarms = await alarm_package.Alarm.getAlarms();
    for (final a in alarms) {
      if (await alarm_package.Alarm.isRinging(a.id)) {
        _navegarAlMinijuego(a.id);
        break;
      }
    }
  }

  void _navegarAlMinijuego(int id) {
    bool isAlreadyWordle = false;

    globalNavigatorKey.currentState?.popUntil((route) {
      if (route.settings.name == '/wordle') {
        isAlreadyWordle = true;
      }
      return true;
    });

    if (!isAlreadyWordle) {
      globalNavigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(
          settings: const RouteSettings(name: '/wordle'),
          builder: (_) => WordleAlarmScreen(alarmId: id),
          fullscreenDialog: true,
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => null,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.homeTitle,
      title: 'Alarmle',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('pt'),
        Locale('fr'),
        Locale('zh'),
      ],
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: wordleDarkBg,
        colorScheme: const ColorScheme.dark(
          primary: wordleGreen,
          secondary: wordleYellow,
          surface: wordleDarkBg,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
          displayMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
          displaySmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
          headlineLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
          titleSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300),
          labelLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
          labelMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
          labelSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: wordleGreen,
          foregroundColor: Colors.white,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(Colors.white),
          trackColor: WidgetStateProperty.all(wordleBorder),
        ),
      ),
      home: const HomeScreen(),
      navigatorKey: globalNavigatorKey,
    );
  }
}

// ─────────────────────────────────────────────
// Wordle classes (preserved from wordleScreen)
// ─────────────────────────────────────────────

class WordleKey {
  final String label;
  final bool isSpecial;
  const WordleKey(this.label, [this.isSpecial = false]);
}

class WordleKeyboard extends StatelessWidget {
  final List<List<WordleKey>> rows;
  final void Function(WordleKey) onKeyPressed;
  final Map<String, Color> keyColors;
  final bool enabled;

  const WordleKeyboard({
    super.key,
    required this.rows,
    required this.onKeyPressed,
    required this.keyColors,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enabled,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: rows.map((row) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map((key) {
                  final isWide = key.isSpecial;
                  final bg = keyColors[key.label] ?? const Color(0xFFD3D3D3);
                  final textColor = (key.label == 'ENTER' || key.label == 'DEL')
                      ? Colors.black87
                      : _textColorForBg(bg);
                  return Expanded(
                    flex: isWide ? 2 : 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Container(
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => onKeyPressed(key),
                            borderRadius: BorderRadius.circular(6.0),
                            child: Center(
                              child: Text(
                                key.label,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  static Color _textColorForBg(Color bg) {
    if (bg == const Color(0xFF6AAA64) || bg == const Color(0xFFC9B458) || bg == const Color(0xFF787C7E)) {
      return Colors.white;
    }
    return Colors.black87;
  }
}

class _WordleCellState extends State<WordleCell> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _scaleAnim;
  Animation<double>? _flipAnim;

  Color _displayColor = const Color(0x00000000);
  String _displayLetter = '';
  bool _showBorder = true;
  bool _hasFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _controller.addListener(() => setState(() {}));
    _displayColor = widget.backgroundColor ?? Colors.transparent;
    _displayLetter = widget.letter;
    _showBorder = widget.backgroundColor == null;
  }

  @override
  void didUpdateWidget(covariant WordleCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_hasFlipped) {
      _displayColor = widget.backgroundColor ?? Colors.transparent;
      _displayLetter = widget.letter;
      _showBorder = widget.backgroundColor == null;
    }
  }

  void triggerPop() {
    _controller.duration = const Duration(milliseconds: 80);
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 60),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward(from: 0);
  }

  Future<void> triggerFlip(Color targetColor) async {
    _controller.duration = const Duration(milliseconds: 200);
    _flipAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    await _controller.forward(from: 0);
    _displayColor = targetColor;
    _showBorder = false;
    _hasFlipped = true;
    setState(() {});
  }

  void reset() {
    _controller.reset();
    _hasFlipped = false;
    _displayColor = widget.backgroundColor ?? Colors.transparent;
    _displayLetter = widget.letter;
    _showBorder = widget.backgroundColor == null;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double scale = _scaleAnim?.value ?? 1.0;
    final double flipValue = _flipAnim?.value ?? 0.0;
    final bool isFliping = _flipAnim != null && _controller.isAnimating;
    final double scaleY = isFliping ? (1 - flipValue).abs() * 2 - 1 : 1.0;

    Widget cell = Container(
      decoration: BoxDecoration(
        color: _displayColor,
        border: _showBorder
            ? Border.all(color: wordleGray, width: 1.5)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Opacity(
          opacity: isFliping && flipValue > 0.15 && flipValue < 0.85 ? 0.0 : 1.0,
          child: Text(
            _displayLetter,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    if (isFliping) {
      cell = Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..setEntry(2, 2, 0.001)..scale(1.0, scaleY < 0 ? scaleY.abs() : scaleY),
        child: cell,
      );
    }

    if (scale != 1.0) {
      cell = Transform.scale(scale: scale, child: cell);
    }

    return cell;
  }
}

class WordleCell extends StatefulWidget {
  final String letter;
  final Color? backgroundColor;

  const WordleCell({super.key, this.letter = '', this.backgroundColor});

  @override
  State<WordleCell> createState() => _WordleCellState();
}