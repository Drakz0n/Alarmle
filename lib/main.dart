import 'package:alarmle/viewmodels/alarm_view_model.dart';
import 'package:alarmle/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp
  (
    ChangeNotifierProvider
    (
      create: (_) => AlarmViewModel()..init(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarmle',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}