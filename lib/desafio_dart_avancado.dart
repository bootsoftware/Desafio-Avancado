import 'package:desafio_dart_avancado/controller/dsesafio_dart_avancado_controller.dart';

Future<void> run() async {
  final _controller = Controller();

  await _controller.getCities();
}
