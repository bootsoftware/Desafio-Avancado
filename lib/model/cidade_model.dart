import 'package:desafio_dart_avancado/model/estado_model.dart';

class Cidade {
  int id;
  String descricao;
  Estado estado;

  Cidade({this.id, this.descricao}) {
    id = id ?? 0;
    descricao = descricao ?? '';
    estado = estado ?? Estado();
  }
}
