import 'api_ibge/service_ibge.dart';
import 'mysql/service_mysql.dart';

Future<void> run() async {
  final serviceMysql = ServiceMysql();
  final serviceIbge = ServiceIbge();

  // var estados = await serviceIbge.getEstado();
  //   await serviceMysql.saveState(estados);

  var cidades = await serviceIbge.getCities();
  await serviceMysql.saveCity(cidades);
}
