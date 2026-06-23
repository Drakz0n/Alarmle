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
      title: 'Wordle Alarm POC',
      theme: ThemeData(
        primarySwatch: Colors.teal,
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
  String _wordleDeHoy = "Presiona el botón para cargar";
  bool _isLoading = false;

Future<void> _obtenerWordle() async {
  setState(() {
    _isLoading = true;
    _wordleDeHoy = "Cargando palabra...";
  });

  final url = Uri.parse('https://wordle-today.p.rapidapi.com/today');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-rapidapi-host': 'wordle-today.p.rapidapi.com',
        'x-rapidapi-key': '35a8af7d2amshce5550427219eeap11c16ejsn0d5df3222fa4', 
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      setState(() {
        _wordleDeHoy = (data['today'] ?? "No se encontró el campo en el JSON").toString().toUpperCase();
      });
    } else {
      setState(() {
        _wordleDeHoy = "Error de API: ${response.statusCode}";
      });
    }
  } catch (e) {
    setState(() {
      _wordleDeHoy = "Error de red: $e";
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POC: API Rest Wordle'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _wordleDeHoy,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: _isLoading ? Colors.grey : Colors.teal.shade700,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),        
              const SizedBox(height: 40),
              
              // Boton para cargar la palabra del dia
              ElevatedButton(
                onPressed: _isLoading ? null : _obtenerWordle,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: _isLoading 
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Obtener Wordle de Hoy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}