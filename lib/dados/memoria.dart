import '../models/tarefa.dart';
import '../models/usuario.dart';

// sem firebase, os dados ficam so na memoria enquanto o app estiver aberto
List<Usuario> usuarios = [];
Usuario? usuarioLogado;

// chave = email do usuario + data, assim cada um tem sua lista
Map<String, List<Tarefa>> tarefas = {};

String chaveDoDia(DateTime dia) {
  return '${usuarioLogado!.email}_${dia.year}-${dia.month}-${dia.day}';
}

List<Tarefa> tarefasDoDia(DateTime dia) {
  return tarefas.putIfAbsent(chaveDoDia(dia), () => []);
}

String formatarData(DateTime d) {
  String dia = d.day.toString().padLeft(2, '0');
  String mes = d.month.toString().padLeft(2, '0');
  return '$dia/$mes/${d.year}';
}
