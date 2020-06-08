import 'package:dio/dio.dart';

class DioErro extends DioError {
  // this.request,
  // this.response,
  // this.type = DioErrorType.DEFAULT,
  // this.error,
  DioErro(
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
/*
405 Método não permitido
406 Não aceitável
407 autenticação de proxy necessária
408 Tempo limite da solicitação
409 Conflito
410 Gone
411 Comprimento necessário
Falha na pré-condição 412
413 Carga útil muito grande
414 URI de solicitação muito longo
415 Tipo de mídia não suportado
416 Intervalo solicitado não satisfatório
417 Expectativa falhada
418 eu sou um bule de chá
421 Solicitação mal direcionada
422 Entidade não processável
423 Bloqueado
424 Dependência com falha
426 Atualização necessária
428 Pré-requisito necessário
429 Pedidos demais
431 Campos do cabeçalho da solicitação muito grandes
Conexão 444 fechada sem resposta
451 Indisponível por motivos legais
499 Pedido Fechado do Cliente
Erro de servidor 5 ×✓
Erro interno do servidor 500
501 Não implementado


504 Tempo limite do gateway
Versão HTTP 505 não suportada
Variante 506 também negocia
507 Armazenamento insuficiente
508 Loop Detectado
510 Não estendido
511 Autenticação de rede necessária
Erro de tempo limite da conexão de rede 599
*/
// switch(erro.message){
//   case: Http status error [404]

// }

}
