import 'package:dio/dio.dart';

class RepositoryServiceIbge {
  Future<Response> getState([int uf = 0]) async {
    var url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
    var dio = Dio();
    if (uf != 0) {
      url = '$url/${uf.toString()}';
    }
    return await dio.get(url);
  }

  Future<Response> getCity(int uf) async {
    var url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
    var dio = Dio();

    url = '$url/${uf.toString()}/municipios';
    return await dio.get(url);
  }
}
