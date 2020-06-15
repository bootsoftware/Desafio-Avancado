import 'package:desafio_dart_avancado/service/ibge_service.dart';

class Controller {
  final _ibgeService = IbgeService();

  Future<void> getCities() async {
    await _ibgeService.getCities();
  }
}
