import 'dart:convert';

import 'package:meta/meta.dart';


class Cidade {
  int id;
  String descricao;
//  Estado estado;
  Cidade({
    @required this.id,
    @required this.descricao,
   // @required this.estado,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
  //    'estado': estado?.toMap(),
    };
  }

  static Cidade fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Cidade(
      id: map['id'] ?? 0,
      descricao: map['nome'] ?? '',
 //     estado: Estado.fromMap(map['microrregiao']['mesorregiao']['UF']) ?? Estado(id: 0, descricao: '', sigla: ''),
    );
  }

  String toJson() => json.encode(toMap());

  static Cidade fromJson(String source) => fromMap(json.decode(source));
}
