import 'package:mysql1/mysql1.dart';

class MysqlError {
  MySqlException error;
  MysqlError(this.error);

  String check() {
    return error.message;
  }
}
