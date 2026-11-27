import 'package:flutter/material.dart';
import '../cores.dart';

// parte de cima das telas de login e cadastro
class CabecalhoIcone extends StatelessWidget {
  const CabecalhoIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      color: lilas,
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: roxoEscuro, width: 2),
        ),
        child: const Icon(Icons.checklist, size: 48, color: roxo),
      ),
    );
  }
}
