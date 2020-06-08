import 'package:desafio_dart_avancado/api_ibge/repository_service_ibge.dart';
import 'package:desafio_dart_avancado/exceptions/exception_custom_dio.dart';
import 'package:desafio_dart_avancado/model/cidade_model.dart';
import 'package:desafio_dart_avancado/model/estado_model.dart';
import 'package:desafio_dart_avancado/mysql/service_mysql.dart';
import 'package:dio/dio.dart';

class ServiceIbge {
  final repositoryIbge = RepositoryServiceIbge();
  final serviceMysql = ServiceMysql();

  Future<List<Estado>> getEstado() async {
    try {
      print('API ---- Buscando Estados Brasileiros');
      var response = await repositoryIbge.getState();
      List<dynamic> ufs = await response.data;

      var list = ufs.map<Estado>((uf) {
        var estado = Estado();
        estado.id = uf['id'];
        estado.descricao = uf['nome'];
        estado.sigla = uf['sigla'];
        //     print('API ---- IBGE: ${estado.id} DESCRIÇÃO: ${estado.descricao} UF: ${estado.sigla}');
        return estado;
      }).toList();
      return list;
    } on DioError catch (e) {
      var errr = DioErro(e).check(); // ver se tem como melhorar essa chamada
      print('API ---- ERRO ---- $errr ---- ERRO ---- ');
      return null;
    } catch (e) {
      print('API ---- ERRO ---- ${e.toString()} ---- ERRO ---- ');
      return null;
    }
  }

  Future<List<Cidade>> _getCities() async {
    var estados = await getEstado();
    var lista = await Future.wait(estados.map((estado) async {
      var response = await repositoryIbge.getCity(estado.id);
      List<dynamic> cidades = await response.data;
      print('API ---- Buscando os Municípios do Estado: ${estado.descricao}');
      var cidadesEncontradas = cidades.map<Cidade>((city) {
        var cidade = Cidade();
        cidade.id = city['id'];
        cidade.descricao = city['nome'];
        cidade.estado.id = estado.id;
        cidade.estado.descricao = estado.descricao;
        cidade.estado.sigla = estado.sigla;
        // print('API -------- IBGE: ${cidade.id} CIDADE: ${cidade.descricao} - ${cidade.estado.sigla}');
        return cidade;
      }).toList();
      return cidadesEncontradas;
    }).toList());

    return lista.expand((cidade) => cidade).toList();
  }

  Future<List<Cidade>> getCities({int uf}) async {
    try {
      if (uf == null) {
        return await _getCities();
      } else {
        var response;
        response = await repositoryIbge.getState(uf);
        var estado = await response.data;
        response = await repositoryIbge.getCity(uf);
        print('API ---- Buscando os Municípios do Estado Selecionado');
        List<dynamic> cidades = await response.data;
        var cidadesEncontradas = cidades.map<Cidade>((city) {
          var cidade = Cidade();
          cidade.id = city['id'];
          cidade.descricao = city['nome'];
          cidade.estado.id = estado['id'];
          cidade.estado.descricao = estado['nome'];
          cidade.estado.sigla = estado['sigla'];
          // print('API -------- IBGE: ${cidade.id} CIDADE: ${cidade.descricao} - ${cidade.estado.sigla}');
          return cidade;
        }).toList();
        return cidadesEncontradas;
      }
    } on DioError catch (e, s) {
      var errr = DioErro(e).check(); // ver se tem como melhorar essa chamada
      print('API ---- ERRO ---- $errr ---- ERRO ---- ');
      print(s);
      return null;
    } catch (e, s) {
      print('API ---- ERRO ---- ${e.toString()} ---- ERRO ---- ');
      print(s);
      return null;
    }
  }
}
