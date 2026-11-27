import 'package:flutter/material.dart';
import '../cores.dart';
import '../dados/memoria.dart';

class CabecalhoUsuario extends StatelessWidget {
  final Widget botao;

  const CabecalhoUsuario({super.key, this.botao = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 20, 8, 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem vindo, ${usuarioLogado?.nome ?? ''}!',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: roxoEscuro),
                ),
                const SizedBox(height: 4),
                Text(
                  'RA: ${usuarioLogado?.ra ?? ''}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          botao,
        ],
      ),
    );
  }
}
