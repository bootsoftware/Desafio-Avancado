import 'dart:convert';

class Estado {
  int id;
  String descricao;
  String sigla;

  Estado({
    this.id,
    this.descricao,
    this.sigla,
  }) {
    id = id ?? 0;
    descricao = descricao ?? '';
    sigla = sigla ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'sigla': sigla,
    };
  }

  static Estado fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Estado(
      id: map['id'] ?? 0,
      descricao: map['nome'] ?? '',
      sigla: map['sigla'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  static Estado fromJson(String source) => fromMap(json.decode(source));
}
