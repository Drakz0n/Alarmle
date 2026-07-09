import 'package:alarm/alarm.dart' as alarm_package show Alarm;
import 'package:alarmle/screens/home_screen.dart';
import 'package:alarmle/l10n/app_localizations.dart';
import 'package:alarmle/viewmodels/user_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const _wordleGreen = Color(0xFF57AC57);
const _wordleGray = Color(0xFF939393);
const _wordleDarkBg = Color(0xFF333333);

class WordleAlarmScreen extends StatefulWidget {
  final int alarmId;

  const WordleAlarmScreen({super.key, required this.alarmId});

  @override
  State<WordleAlarmScreen> createState() => _WordleAlarmScreenState();
}

class _WordleAlarmScreenState extends State<WordleAlarmScreen> {
  String _wordleDeHoy = "";
  String _intento = "";
  bool _isLoading = false;
  int _intentoActual = 0;
  bool _juegoTerminado = false;
  bool _animando = false;
  int _puntajeTotal = 0;
  final List<String> _historial = List.filled(5, "");
  final List<List<Color?>> _historialColores =
      List.generate(5, (_) => List.filled(5, null));
  final Map<String, Color> _keyColors = {};
  final Map<String, Color> _pendingKeyColors = {};

  late final List<List<WordleKey>> _keyboardRows = _buildKeyboardRows();

  List<List<GlobalKey<_WordleAlarmCellState>>> _cellKeys = List.generate(
    5,
    (_) => List.generate(5, (_) => GlobalKey<_WordleAlarmCellState>()),
  );

  static List<List<WordleKey>> _buildKeyboardRows() => [
        [
          WordleKey('Q'),
          WordleKey('W'),
          WordleKey('E'),
          WordleKey('R'),
          WordleKey('T'),
          WordleKey('Y'),
          WordleKey('U'),
          WordleKey('I'),
          WordleKey('O'),
          WordleKey('P')
        ],
        const [
          WordleKey('A'),
          WordleKey('S'),
          WordleKey('D'),
          WordleKey('F'),
          WordleKey('G'),
          WordleKey('H'),
          WordleKey('J'),
          WordleKey('K'),
          WordleKey('L')
        ],
        [
          WordleKey('ENTER', true),
          WordleKey('Z'),
          WordleKey('X'),
          WordleKey('C'),
          WordleKey('V'),
          WordleKey('B'),
          WordleKey('N'),
          WordleKey('M'),
          WordleKey('DEL', true)
        ],
      ];

  @override
  void initState() {
    super.initState();
    _obtenerWordle();
  }

  Future<void> _obtenerWordle() async {
    setState(() {
      _isLoading = true;
      _wordleDeHoy = "";
      _intento = "";
      _intentoActual = 0;
      _juegoTerminado = false;
      _animando = false;
      for (int i = 0; i < 5; i++) {
        _historial[i] = "";
        for (int j = 0; j < 5; j++)
          _historialColores[i][j] = null;
      }
      _keyColors.clear();
      _pendingKeyColors.clear();
      _puntajeTotal = 0;
    });
    _cellKeys = List.generate(
      5,
      (_) => List.generate(5, (_) => GlobalKey<_WordleAlarmCellState>()),
    );

    final fechaHoy = DateTime.now().toString().split(' ')[0];
    final url =
        Uri.parse('https://www.nytimes.com/svc/wordle/v2/$fechaHoy.json');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() => _wordleDeHoy =
            (data['solution'] ?? "").toString().toUpperCase());
      } else {
        setState(() => _wordleDeHoy = "FLAME");
      }
    } catch (e) {
      setState(() => _wordleDeHoy = "FLAME");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _evaluarIntento() {
    final intento = _intento.toUpperCase().trim();
    if (intento.isEmpty || intento.length != _wordleDeHoy.length) return;

    final colors = List<Color?>.filled(5, null);
    final keyColors = Map<String, Color>.from(_keyColors);
    final solutionChars = _wordleDeHoy.split('');
    final guessChars = intento.split('');
    final used = List<bool>.filled(5, false);

    for (int i = 0; i < 5; i++) {
      if (guessChars[i] == solutionChars[i]) {
        colors[i] = const Color(0xFF6AAA64);
        used[i] = true;
        keyColors[guessChars[i]] = const Color(0xFF6AAA64);
      }
    }

    for (int i = 0; i < 5; i++) {
      if (colors[i] != null) continue;
      final letter = guessChars[i];
      bool found = false;
      for (int j = 0; j < 5; j++) {
        if (!used[j] && solutionChars[j] == letter) {
          used[j] = true;
          found = true;
          break;
        }
      }
      if (found) {
        colors[i] = const Color(0xFFC9B458);
        if ((keyColors[letter] ?? const Color(0xFFD3D3D3)) !=
            const Color(0xFF6AAA64)) {
          keyColors[letter] = const Color(0xFFC9B458);
        }
      } else {
        colors[i] = const Color(0xFF787C7E);
        keyColors[letter] = const Color(0xFF787C7E);
      }
    }

    final greenCount = colors.where((c) => c == const Color(0xFF6AAA64)).length;
    final yellowCount =
        colors.where((c) => c == const Color(0xFFC9B458)).length;
    const greenPoints = [50, 40, 30, 20, 10];
    const yellowPoints = [10, 8, 6, 4, 2];
    final rowScore = greenCount * greenPoints[_intentoActual] +
        yellowCount * yellowPoints[_intentoActual];
    final allGreen = colors.every((c) => c == const Color(0xFF6AAA64));

    _pendingKeyColors
      ..clear()
      ..addAll(keyColors);

    setState(() {
      _historial[_intentoActual] = intento;
      _animando = true;
      _puntajeTotal += rowScore;
    });

    _revelarFilas(colors, allGreen, rowScore);
  }

  Future<void> _revelarFilas(List<Color?> colors, bool allGreen,
      int rowScore) async {
    for (int i = 0; i < 5; i++) {
      final cellState = _cellKeys[_intentoActual][i].currentState;
      if (cellState != null) {
        await cellState.triggerFlip(colors[i] ?? const Color(0xFF787C7E));
      }
      if (i < 4) await Future.delayed(const Duration(milliseconds: 100));
    }

    setState(() {
      _historialColores[_intentoActual] = colors;
      _keyColors
        ..clear()
        ..addAll(_pendingKeyColors);
    });

    if (allGreen) {
      // VICTORY — stop sound and navigate back
      try {
        // 1. Matar el alarm específico
        await alarm_package.Alarm.stop(widget.alarmId);
        print("Successfully stopped specific alarm.");
      } catch (e) {
        print("Error stopping specific alarm: $e");
      }

      // 2. IMPORTANTE: Esperar a que el canal nativo de Android procese el stop
      // En Android 15/16, los servicios en segundo plano tardan más en liberar recursos.
      await Future.delayed(const Duration(milliseconds: 1500));

      if (mounted) {
        setState(() {
          _juegoTerminado = true;
          _animando = false;
        });

        // 3. Sincronizar puntuación con Firestore a través del ViewModel
        try {
          context.read<UserViewModel>().addScore(_puntajeTotal);
        } catch (_) {
          //no bloquear la navegación si falla la sincronización
        }

        // 4. Cerrar la actividad de forma segura
        SystemNavigator.pop();
      }
  } else if (_intentoActual >= 4) {
      // LOSS — restart game with new word, sound continues
      _obtenerWordle();
    } else {
      setState(() {
        _intentoActual = _intentoActual + 1;
        _intento = "";
        _animando = false;
      });
    }
  }

  void _onKeyPressed(WordleKey key) {
    if (_juegoTerminado || _animando) return;

    final label = key.label;
    if (label == 'DEL') {
      setState(() {
        if (_intento.isNotEmpty)
          _intento = _intento.substring(0, _intento.length - 1);
      });
      return;
    }
    if (label == 'ENTER') {
      _evaluarIntento();
      return;
    }
    setState(() {
      if (_intento.length < 5) {
        _intento += label;
        final idx = _intento.length - 1;
        _cellKeys[_intentoActual][idx].currentState?.triggerPop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: _wordleDarkBg,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxH = constraints.maxHeight;
              final maxW = constraints.maxWidth;
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: maxH, maxHeight: maxH, maxWidth: maxW),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_isLoading)
                                    const CircularProgressIndicator(
                                        color: _wordleGreen)
                                  else if (_wordleDeHoy.isNotEmpty) ...[
                                    Column(
                                      children:
                                          List.generate(5, (rowIndex) {
                                        final isCurrentRow =
                                            rowIndex == _intentoActual;
                                        final isPastRow =
                                            rowIndex < _intentoActual;
                                        final showIntento =
                                            isCurrentRow && !_animando;
                                        final letras =
                                            _historial[rowIndex].isNotEmpty
                                                ? _historial[rowIndex]
                                                    .split('')
                                                : (showIntento
                                                    ? _intento.split('')
                                                    : List.filled(5, ''));
                                        final cols = isPastRow
                                            ? (_historialColores[rowIndex])
                                            : (isCurrentRow
                                                ? List.filled(5, null)
                                                : List.filled(5, null));
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children:
                                              List.generate(5, (colIndex) {
                                            final letra = colIndex <
                                                    letras.length
                                                ? letras[colIndex]
                                                : '';
                                            final bg = cols[colIndex];
                                            final isRevealed = isPastRow;
                                            return Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3,
                                                        vertical: 3),
                                                child: AspectRatio(
                                                  aspectRatio: 1,
                                                  child: isRevealed
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: bg,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              letra,
                                                              style: const TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        )
                                                      : WordleCell(
                                                          key: _cellKeys[
                                                                  rowIndex]
                                                              [colIndex],
                                                          letter: letra,
                                                          backgroundColor:
                                                              null,
                                                        ),
                                                ),
                                              ),
                                            );
                                          }),
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 8),
                                    if (_juegoTerminado) ...[
                                      Text(
                                        _historialColores[_intentoActual]
                                                    .every((c) =>
                                                        c ==
                                                        const Color(
                                                            0xFF6AAA64)) &&
                                                _wordleDeHoy.isNotEmpty
                                            ? l10n.youWon
                                            : l10n.youLost,
                                        style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 6),
                                      if (!(_historialColores[_intentoActual]
                                              .every((c) =>
                                                  c ==
                                                  const Color(0xFF6AAA64))) &&
                                          _wordleDeHoy.isNotEmpty)
                                        Text(
                                            l10n.wordLabel(_wordleDeHoy),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white70)),
                                    ],
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF0F0F0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        l10n.scoreCapsLabel(_puntajeTotal),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ] else
                                    const SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (_wordleDeHoy.isNotEmpty && !_isLoading)
                          _KeyWrapper(
                            rows: _keyboardRows,
                            onKeyPressed: _onKeyPressed,
                            keyColors: _keyColors,
                            enabled: !_juegoTerminado && !_animando,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ── Minimal keyboard wrapper (inline, avoids importing main.dart classes) ──

class WordleKey {
  final String label;
  final bool isSpecial;
  const WordleKey(this.label, [this.isSpecial = false]);
}

class _KeyWrapper extends StatelessWidget {
  final List<List<WordleKey>> rows;
  final void Function(WordleKey) onKeyPressed;
  final Map<String, Color> keyColors;
  final bool enabled;

  const _KeyWrapper({
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
                  final bg =
                      keyColors[key.label] ?? const Color(0xFFD3D3D3);
                  final textColor = (key.label == 'ENTER' ||
                          key.label == 'DEL')
                      ? Colors.black87
                      : _textColorForBg(bg);
                  return Expanded(
                    flex: isWide ? 2 : 1,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Container(
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius:
                              BorderRadius.circular(6.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => onKeyPressed(key),
                            borderRadius:
                                BorderRadius.circular(6.0),
                            child: Center(
                              child: Text(
                                key.label,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                                overflow:
                                    TextOverflow.ellipsis,
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
    if (bg == const Color(0xFF6AAA64) ||
        bg == const Color(0xFFC9B458) ||
        bg == const Color(0xFF787C7E)) {
      return Colors.white;
    }
    return Colors.black87;
  }
}

// ── WordleCell for alarm screen (self-contained) ──

class WordleCell extends StatefulWidget {
  final String letter;
  final Color? backgroundColor;

  const WordleCell({
    super.key,
    this.letter = '',
    this.backgroundColor,
  });

  @override
  State<WordleCell> createState() => _WordleAlarmCellState();
}

class _WordleAlarmCellState extends State<WordleCell>
    with SingleTickerProviderStateMixin {
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
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
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
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.1), weight: 40),
      TweenSequenceItem(
          tween: Tween(begin: 1.1, end: 1.0), weight: 60),
    ]).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
    final double scaleY =
        isFliping ? (1 - flipValue).abs() * 2 - 1 : 1.0;

    Widget cell = Container(
      decoration: BoxDecoration(
        color: _displayColor,
        border: _showBorder
            ? Border.all(color: _wordleGray, width: 1.5)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Opacity(
          opacity: isFliping &&
                  flipValue > 0.15 &&
                  flipValue < 0.85
              ? 0.0
              : 1.0,
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
        transform: Matrix4.identity()
          ..setEntry(2, 2, 0.001)
          ..scale(1.0, scaleY < 0 ? scaleY.abs() : scaleY),
        child: cell,
      );
    }

    if (scale != 1.0) {
      cell = Transform.scale(scale: scale, child: cell);
    }

    return cell;
  }
}