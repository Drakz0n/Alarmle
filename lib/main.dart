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

  const WordleKeyboard({
    super.key,
    required this.rows,
    required this.onKeyPressed,
    required this.keyColors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        children: rows.map((row) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: row.map((key) {
                final isWide = key.isSpecial;
                final bg = keyColors[key.label] ?? const Color(0xFFD3D3D3);
                final textColor = (key.label == 'ENTER' || key.label == 'BORRAR')
                    ? Colors.black87
                    : _textColorForBg(bg);
                final button = Expanded(
                  flex: isWide ? 15 : 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Material(
                      color: bg,
                      borderRadius: BorderRadius.circular(6.0),
                      child: InkWell(
                        onTap: () => onKeyPressed(key),
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          height: 48.0,
                          alignment: Alignment.center,
                          child: Text(
                            key.label,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                            overflow: TextOverflow.ellipsis,
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
  List<Color?> _boxColors = List.filled(5, null);
  final Map<String, Color> _keyColors = {};

  late final List<List<WordleKey>> _keyboardRows = _buildKeyboardRows();

  static List<List<WordleKey>> _buildKeyboardRows() => [
    [WordleKey('Q'), WordleKey('W'), WordleKey('E'), WordleKey('R'), WordleKey('T'), WordleKey('Y'), WordleKey('U'), WordleKey('I'), WordleKey('O'), WordleKey('P')],
    const [WordleKey('A'), WordleKey('S'), WordleKey('D'), WordleKey('F'), WordleKey('G'), WordleKey('H'), WordleKey('J'), WordleKey('K'), WordleKey('L')],
    [WordleKey('ENTER', true), WordleKey('Z'), WordleKey('X'), WordleKey('C'), WordleKey('V'), WordleKey('B'), WordleKey('N'), WordleKey('M'), WordleKey('BORRAR', true)],
  ];

  Future<void> _obtenerWordle() async {
    setState(() {
      _isLoading = true;
      _wordleDeHoy = "";
      _intento = "";
      _boxColors = List.filled(5, null);
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

  void _validarIntento() {
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

    final allGreen = colors.every((c) => c == const Color(0xFF6AAA64));

    setState(() {
      _boxColors = colors;
      _keyColors
        ..clear()
        ..addAll(keyColors);
    });
  }

  void _onKeyPressed(WordleKey key) {
    final label = key.label;
    if (label == 'BORRAR') {
      setState(() {
        if (_intento.isNotEmpty) {
          _intento = _intento.substring(0, _intento.length - 1);
        }
        if (_intento.length < 5) {
          _boxColors = List.filled(5, null);
        }
      });
      return;
    }
    if (label == 'ENTER') {
      _validarIntento();
      return;
    }
    setState(() {
      if (_intento.length < 5) {
        _intento += label;
      }
      if (_intento.length < 5) {
        _boxColors = List.filled(5, null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle POC'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isLoading)
                      const CircularProgressIndicator(color: Colors.teal)
                    else if (_wordleDeHoy.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final letra = index < _intento.length ? _intento[index] : '';
                          final bg = index < _boxColors.length ? _boxColors[index] : null;
                          final textColor = bg != null ? Colors.white : Colors.black87;
                          return Container(
                            width: 56,
                            height: 56,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: bg,
                              border: bg == null ? Border.all(color: Colors.teal, width: 2) : null,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                letra,
                                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 30),
                      if (_boxColors.isNotEmpty && _boxColors.every((c) => c == const Color(0xFF6AAA64)))
                        const Text(
                          "GANASTE",
                          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                    ] else
                      ElevatedButton(
                        onPressed: _obtenerWordle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                        ),
                        child: const Text('Obtener palabra del día', style: TextStyle(fontSize: 18)),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (_wordleDeHoy.isNotEmpty && !_isLoading)
            WordleKeyboard(rows: _keyboardRows, onKeyPressed: _onKeyPressed, keyColors: _keyColors),
        ],
      ),
    );
  }
}