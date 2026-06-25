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

class PocScreen extends StatefulWidget {
  const PocScreen({super.key});

  @override
  State<PocScreen> createState() => _PocScreenState();
}

class _PocScreenState extends State<PocScreen> {
  String _wordleDeHoy = "";
  String _intento = "";
  String _resultado = "";
  bool _isLoading = false;

  Future<void> _obtenerWordle() async {
    setState(() {
      _isLoading = true;
      _wordleDeHoy = "";
      _resultado = "";
      _intento = "";
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
        setState(() => _resultado = "Error API");
      }
    } catch (e) {
      setState(() => _resultado = "Error red");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _validarIntento() {
    final intento = _intento.toUpperCase().trim();

    if (intento.isEmpty || intento.length != _wordleDeHoy.length) {
      setState(() => _resultado = "");
      return;
    }

    setState(() {
      _resultado = intento == _wordleDeHoy ? "GANASTE" : "PERDISTE";
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator(color: Colors.teal)
              else if (_wordleDeHoy.isNotEmpty) ...[
                TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 28, letterSpacing: 2),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingresa la palabra',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  ),
                  maxLength: 5,
                  onChanged: (v) => _intento = v,
                  onSubmitted: (_) => _validarIntento(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _validarIntento,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Validar'),
                ),
                const SizedBox(height: 40),
                if (_resultado.isNotEmpty)
                  Text(
                    _resultado,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
              ] else
                ElevatedButton(
                  onPressed: _isLoading ? null : _obtenerWordle,
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
    );
  }
}