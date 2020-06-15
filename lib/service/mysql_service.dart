import 'package:desafio_dart_avancado/components/exceptions/exception_custom_mysql.dart';
import 'package:desafio_dart_avancado/model/cidade_model.dart';
import 'package:desafio_dart_avancado/model/estado_model.dart';
import 'package:desafio_dart_avancado/repository/mysql_repository.dart';
import 'package:mysql1/mysql1.dart';

class MysqlService {
  final _mysqlRepository = MysqlRepository();

  Future<void> saveState(List<Estado> estados) async {
    if (estados != null) {
      //////NUNCA USAR ASSIM     estados.forEach((estado) async { //////NUNCA USAR ASSIM
      await Future.forEach(estados, (estado) async {
        var id = estado.id;
        var descricao = estado.descricao;
        var sigla = estado.sigla;
        try {
          print(
            await _mysqlRepository.saveState(
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

  Future<void> saveCity(List<Cidade> cidades, int estadoId) async {
    if (cidades != null) {
      //////NUNCA USAR ASSIM // cidades.forEach((cidade) async { //////NUNCA USAR ASSIM
      await Future.forEach(cidades, (cidade) async {
        var id = cidade.id;
        var descricao = cidade.descricao;
        var uf = estadoId;
        try {
          print(
            await _mysqlRepository.saveCity(
              id.toString(),
              descricao,
              uf.toString(),
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
      print('SQL ---- ERRO ---- Não foi encontrado nem um Cidade para salvar! ---- ERRO ---- ');
    }
  }
}
