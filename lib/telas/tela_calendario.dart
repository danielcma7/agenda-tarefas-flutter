import 'package:flutter/material.dart';
import '../cores.dart';
import '../dados/memoria.dart';
import '../widgets/cabecalho_usuario.dart';
import 'tela_login.dart';
import 'tela_tarefas.dart';

class TelaCalendario extends StatefulWidget {
  const TelaCalendario({super.key});

  @override
  State<TelaCalendario> createState() => _TelaCalendarioState();
}

class _TelaCalendarioState extends State<TelaCalendario> {
  DateTime diaEscolhido = DateTime.now();

  void sair() {
    usuarioLogado = null;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const TelaLogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CabecalhoUsuario(
              botao: IconButton(
                icon: const Icon(Icons.logout, color: roxoEscuro),
                tooltip: 'Sair',
                onPressed: sair,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: roxo,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: CalendarDatePicker(
                          initialDate: diaEscolhido,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2035),
                          onDateChanged: (d) {
                            setState(() => diaEscolhido = d);
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Selecionado: ${formatarData(diaEscolhido)}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TelaTarefas(dia: diaEscolhido)),
                          );
                        },
                        child: const Text('Selecionar o dia'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
