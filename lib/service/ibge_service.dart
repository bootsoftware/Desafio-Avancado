import 'package:desafio_dart_avancado/components/exceptions/exception_custom_dio.dart';
import 'package:desafio_dart_avancado/model/cidade_model.dart';
import 'package:desafio_dart_avancado/model/estado_model.dart';
import 'package:desafio_dart_avancado/repository/ibge_Repository.dart';
import 'package:desafio_dart_avancado/service/mysql_service.dart';
import 'package:dio/dio.dart';

class IbgeService {
  final _ibgeRepository = IbgeRepository();
  final _mysqlService = MysqlService();

  Future<List<Estado>> getStates() async {
    try {
      print('API ---- Buscando Estados Brasileiros');
      var response = await _ibgeRepository.getState();
      List<dynamic> ufs = await response.data;
      var list = ufs.map<Estado>((uf) {
        return Estado.fromMap(uf);
      }).toList();
//----------------- acho q aqui ficou um pouco misturado, esta correto essa chamada aqui?
      await _mysqlService.saveState(list);
      return list;
    } on DioError catch (e) {
      var err = ExceptionCustomDio(e).check(); // ver se tem como melhorar essa chamada
      print('API ---- ERRO ---- $err ---- ERRO ---- ');
      return null;
    } catch (e) {
      print('API ---- ERRO ---- ${e.toString()} ---- ERRO ---- ');
      return null;
    }
  }

  Future<List<Cidade>> _getCities() async {
    var estados = await getStates();
    var lista = await Future.wait(estados.map((estado) async {
      //nao esta respentando o loop ele printa primeiro  todos
      print('API ---- Buscando os Municípios do Estado: ${estado.descricao}');
      var response = await _ibgeRepository.getCity(estado.id);
      var cidades = response.data;
      var listCidades = await _converterCidades(cidades);
      await _mysqlService.saveCity(listCidades, estado.id);
      return listCidades;
    }));
    return lista.expand((cidade) => cidade).toList();
  }

  Future<List<Cidade>> _converterCidades(List<dynamic> cidades) async {
    var listCidades = cidades.map<Cidade>((city) {
      var cidadesModel = Cidade.fromMap(city);
      print('API -------- IBGE: ${cidadesModel.id} CIDADE: ${cidadesModel.descricao}');
      return cidadesModel;
    }).toList();

    return listCidades;
  }

  Future<void> getCities() async {
    try {
      await _getCities();
    } on DioError catch (e, s) {
      var errr = ExceptionCustomDio(e).check(); // ver se tem como melhorar essa chamada
      print('API ---- ERRO ---- $errr ---- ERRO ---- ');
      print(s);
      return null;
    } catch (e, s) {
      print('API ---- ERRO ---- ${e.toString()} ---- ERRO ---- ');
      print(s);
    }
  }  
  
}
