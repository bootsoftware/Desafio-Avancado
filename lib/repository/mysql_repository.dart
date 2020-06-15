import 'package:mysql1/mysql1.dart';

class MysqlRepository {
  Future<MySqlConnection> _getConnection({
    String host = 'localhost', //'127.0.0.1', 'localhost'
    int port = 3306,
    String user = 'root',
    String password = 'root',
    String db = 'curso',
  }) async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }

  Future<String> saveState(String id, String description, String initials) async {
    var conn = await _getConnection();
    String estadoId;
    try {
      await conn.query('INSERT  states (id_states, description, initials) VALUES (?, ?, ?)', [id, description, initials]).then((value) {
        //  return '---- INCLUSÃO ESTADO - ID: ${value.insertId} - DESCRIÇÃO: ${description}';
        estadoId = value.insertId.toString();
      });
    } catch (e) {
      rethrow;
    } finally {
      await conn.close();
      return 'SQL ---- INCLUSÃO ESTADO - ID: ${estadoId} - DESCRIÇÃO: ${description}';
    }
  }

  Future<String> saveCity(String id, String description, String uf) async {
    String cityId;
    String cityStateId;

    var conn = await _getConnection();
    try {
      await conn.query('INSERT cities (ibge, description)VALUES (?,?)', [id, description]).then((value) async {
        // return 'SQL ---- INCLUSÃO CIDADE - ID: ${value.insertId} - DESCRIÇÃO: ${description} ----';
        await conn.query('INSERT cities_states(id_cities,id_states)VALUES (?,?)', [value.insertId, uf]).then((value) {
          cityStateId = value.insertId.toString();
          cityId = value.insertId.toString();
        });
      });
    } catch (e) {
      rethrow;
    } finally {
      await conn.close();

      return '''SQL ---- INCLUSÃO CIDADE - ID: ${cityId} - DESCRIÇÃO: ${description} 
SQL ---- INCLUSÃO ESTADO_CIDADE - ID: $cityStateId - DESCRIÇÃO: ${uf} ''';
    }
  }

  Future<String> saveCityState(String id, String uf) async {
    String cityStateId;
    var conn = await _getConnection();
    try {
      print('-----------------------------------------');
      await conn.query('INSERT cities_states(id_cities,id_states)VALUES (?,?)', [id, uf]).then((value) {
        cityStateId = value.insertId.toString();
      });
    } catch (e) {
      rethrow;
    } finally {
      await conn.close();
      return 'SQL ---- INCLUSÃO ESTADO_CIDADE - ID: $cityStateId - DESCRIÇÃO: ${uf}';
    }
  }
}
