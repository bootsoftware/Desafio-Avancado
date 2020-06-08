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
}
