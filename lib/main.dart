import 'package:flutter/material.dart';
import 'cores.dart';
import 'telas/tela_login.dart';

void main() {
  runApp(const AgendaApp());
}

class AgendaApp extends StatelessWidget {
  const AgendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: roxo),
        scaffoldBackgroundColor: fundo,
        // tudo quadrado, sem borda arredondada
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.zero),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: roxoEscuro, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: roxoEscuro,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(),
            minimumSize: const Size(double.infinity, 46),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        datePickerTheme: const DatePickerThemeData(
          dayShape: WidgetStatePropertyAll(RoundedRectangleBorder()),
        ),
      ),
      home: const TelaLogin(),
    );
  }
}
