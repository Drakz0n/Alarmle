import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle POC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const PocScreen(),
    );
  }
}

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
                  final textColor = (key.label == 'ENTER' || key.label == 'BORRAR')
                      ? Colors.black87
                      : _textColorForBg(bg);
                  final button = Expanded(
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
                  return button;
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

class PocScreen extends StatefulWidget {
  const PocScreen({super.key});

  @override
  State<PocScreen> createState() => _PocScreenState();
}

class _PocScreenState extends State<PocScreen> {
  String _wordleDeHoy = "";
  String _intento = "";
  bool _isLoading = false;
  int _intentoActual = 0;
  bool _juegoTerminado = false;

  final List<String> _historial = List.filled(5, "");
  final List<List<Color?>> _historialColores = List.generate(5, (_) => List.filled(5, null));
  final Map<String, Color> _keyColors = {};

  late final List<List<WordleKey>> _keyboardRows = _buildKeyboardRows();

  static List<List<WordleKey>> _buildKeyboardRows() => [
    [WordleKey('Q'), WordleKey('W'), WordleKey('E'), WordleKey('R'), WordleKey('T'), WordleKey('Y'), WordleKey('U'), WordleKey('I'), WordleKey('O'), WordleKey('P')],
    const [WordleKey('A'), WordleKey('S'), WordleKey('D'), WordleKey('F'), WordleKey('G'), WordleKey('H'), WordleKey('J'), WordleKey('K'), WordleKey('L')],
    [WordleKey('ENTER', true), WordleKey('Z'), WordleKey('X'), WordleKey('C'), WordleKey('V'), WordleKey('B'), WordleKey('N'), WordleKey('M'), WordleKey('BORRAR', true)],
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
      for (int i = 0; i < 5; i++) {
        _historial[i] = "";
        for (int j = 0; j < 5; j++) _historialColores[i][j] = null;
      }
      _keyColors.clear();
    });

    final fechaHoy = DateTime.now().toString().split(' ')[0];
    final url = Uri.parse('https://www.nytimes.com/svc/wordle/v2/$fechaHoy.json');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _wordleDeHoy = (data['solution'] ?? "").toString().toUpperCase();
        });
      } else {
        setState(() => _wordleDeHoy = "");
      }
    } catch (e) {
      setState(() => _wordleDeHoy = "");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _evaluarIntento() {
    final intento = _intento.toUpperCase().trim();

    if (intento.isEmpty || intento.length != _wordleDeHoy.length) {
      return;
    }

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
        if ((keyColors[letter] ?? const Color(0xFFD3D3D3)) != const Color(0xFF6AAA64)) {
          keyColors[letter] = const Color(0xFFC9B458);
        }
      } else {
        colors[i] = const Color(0xFF787C7E);
        keyColors[letter] = const Color(0xFF787C7E);
      }
    }

    setState(() {
      _historial[_intentoActual] = intento;
      _historialColores[_intentoActual] = colors;
      _keyColors
        ..clear()
        ..addAll(keyColors);
    });

    final allGreen = colors.every((c) => c == const Color(0xFF6AAA64));

    if (allGreen || _intentoActual >= 4) {
      setState(() {
        _juegoTerminado = true;
      });
    } else {
      setState(() {
        _intentoActual = _intentoActual + 1;
        _intento = "";
      });
    }
  }

  void _onKeyPressed(WordleKey key) {
    if (_juegoTerminado) return;

    final label = key.label;
    if (label == 'BORRAR') {
      setState(() {
        if (_intento.isNotEmpty) {
          _intento = _intento.substring(0, _intento.length - 1);
        }
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
      }
    });
  }

  void _reiniciar() {
    _obtenerWordle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxH = constraints.maxHeight;
            final maxW = constraints.maxWidth;
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: maxH,
                  maxHeight: maxH,
                  maxWidth: maxW,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_isLoading)
                                  const CircularProgressIndicator(color: Colors.teal)
                                else if (_wordleDeHoy.isNotEmpty) ...[
                                  Column(
                                    children: List.generate(5, (rowIndex) {
                                      final letras = rowIndex <= _intentoActual && _historial[rowIndex].isNotEmpty
                                          ? _historial[rowIndex].split('')
                                          : (rowIndex == _intentoActual ? _intento.split('') : List.filled(5, ''));
                                      final cols = rowIndex < _historialColores.length ? _historialColores[rowIndex] : List.filled(5, null);
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: List.generate(5, (colIndex) {
                                          final letra = colIndex < letras.length ? letras[colIndex] : '';
                                          final bg = cols[colIndex];
                                          final textColor = bg != null ? Colors.white : Colors.black87;
                                          return Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: bg,
                                                    border: bg == null ? Border.all(color: Colors.teal, width: 2) : null,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      letra,
                                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 12),
                                  if (_juegoTerminado) ...[
                                    Text(
                                      _historialColores[_intentoActual].every((c) => c == const Color(0xFF6AAA64)) && _wordleDeHoy.isNotEmpty
                                          ? "GANASTE"
                                          : "PERDISTE",
                                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    if (_wordleDeHoy.isNotEmpty)
                                      Text(
                                        "Palabra: $_wordleDeHoy",
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                    const SizedBox(height: 12),
                                    ElevatedButton(
                                      onPressed: _reiniciar,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                      ),
                                      child: const Text('Reiniciar Juego', style: TextStyle(fontSize: 16)),
                                    ),
                                  ],
                                ] else
                                  const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (_wordleDeHoy.isNotEmpty && !_isLoading)
                        WordleKeyboard(rows: _keyboardRows, onKeyPressed: _onKeyPressed, keyColors: _keyColors, enabled: !_juegoTerminado),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}