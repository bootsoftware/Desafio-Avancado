import 'package:mysql1/mysql1.dart';

class RepositoryMysql {
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
    var result;
    var conn = await _getConnection();
    try {
      await conn.query('INSERT  states (id_states, description, initials) VALUES (?, ?, ?)', [id, description, initials]).then((value) {
        result = '---- INCLUSÃO ESTADO - ID: ${value.insertId} - DESCRIÇÃO: ${description}';
      });

      return result;
    } catch (e) {
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<String> saveCity(String id, String description, String uf) async {
    // var conn = await _getConnection();
    // var banco = conn.query('INSERT cities (id_city, description)VALUES (?,?)', [id, description]);
    // print('---- Repository Mysql ' + await banco.then((value) => value.insertId.toString()));
    // await conn.close();

    var result;

    var conn = await _getConnection();
    try {
      await conn.query('INSERT cities (id_city, description)VALUES (?,?)', [id, description]).then((value) async {
        result = 'SQL ---- INCLUSÃO CIDADE - ID: ${value.insertId} - DESCRIÇÃO: ${description} ----';
      });
      return result;
    } catch (e) {
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<String> saveCityState(String id, String uf) async {
    //   var result;
    //   var conn = await _getConnection();
    //   try {
    //     await conn.query('INSERT city_state(id_city,id_state)VALUES (?,?)', [id, uf]).then((value) {
    //       result = ('SQL ---- INCLUSÃO ESTADO CIDADE - ID: ${value.insertId} - DESCRIÇÃO: ${uf} ----');
    //     });
    //     return result;
    //   } catch (e) {
    //     rethrow;
    //   } finally {
    //     await conn.close();
    //   }
    return ' -- Repository';
  }
}
