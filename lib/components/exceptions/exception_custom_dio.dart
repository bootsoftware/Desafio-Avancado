import 'package:dio/dio.dart';

class ExceptionCustomDio extends DioError {
  ExceptionCustomDio(
    DioError erro,
  ) : super(
          request: erro.request,
          response: erro.response,
          type: erro.type,
          error: erro.message,
        );

  String check() {
    switch (response.statusCode) {
      case 400:
        return 'Solicitação incorreta';
      case 401:
        return 'Não autorizado';
      case 402:
        return 'Pagamento obrigatório';
      case 403:
        return 'Proibido';
      case 404:
        return 'Página não encontrada';
      case 500:
        return 'Erro interno do servidor';
      case 502:
        return 'Link incorreto';
      case 503:
        return 'Serviço indisponível';
      //conntinuar importando os codigos de erro do HTTP
      default:
        return error.message;
    }
  }
}
