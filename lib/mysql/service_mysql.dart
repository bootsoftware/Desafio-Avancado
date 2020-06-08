import 'package:desafio_dart_avancado/exceptions/exception_custom_mysql.dart';
import 'package:desafio_dart_avancado/model/cidade_model.dart';
import 'package:desafio_dart_avancado/model/estado_model.dart';
import 'package:mysql1/mysql1.dart';

import 'repository_mysql.dart';

class ServiceMysql {
  final RepositoryMysql _repositoryMysql = RepositoryMysql();

  Future<void> saveState(List<Estado> estados) async {
    if (estados != null) {
      estados.forEach((estado) async {
        var id = estado.id;
        var descricao = estado.descricao;
        var sigla = estado.sigla;
        try {
          print(
            await _repositoryMysql.saveState(
              id.toString(),
              descricao,
              sigla,
            ),
          );
        } on MySqlException catch (e) {
          var errr = MysqlError(e).check(); // ver se tem como melhorar essa chamada
          print('SQL ---- ERRO ---- $errr ---- ERRO ---- ');
        } catch (e) {
          print('SQL ---- ERRO ---- $e ---- ERRO ---- ');
        }
      });
    } else {
      print('SQL ---- ERRO ---- Não foi encontrado nem um Estado para salvar! ---- ERRO ---- ');
    }
  }

  Future<void> saveCity(List<Cidade> cidades) async {
    if (cidades != null) {
      cidades.forEach((cidade) async {
        var id = cidade.id;
        var descricao = cidade.descricao;
        var uf = cidade.estado.id;
        try {
          print(
            await _repositoryMysql.saveCity(
              id.toString(),
              descricao,
              uf.toString(),
            ),
          );
          // print(
          //   await _repositoryMysql.saveCityState(
          //     id.toString(),
          //     uf.toString(),
          //   ),
          // );
        } on MySqlException catch (e) {
          var errr = MysqlError(e).check(); // ver se tem como melhorar essa chamada
          print('SQL ---- ERRO ---- $errr ---- ERRO ---- ');
        } catch (e) {
          print('SQL ---- ERRO ---- $e ---- ERRO ---- ');
        }
      });
    } else {
      print('SQL ---- ERRO ---- Não foi encontrado nem um Cidade para salvar! ---- ERRO ---- ');
    }
  }
}
