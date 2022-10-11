import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  final statusCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;
  return 'Request faild\nStatus Code: $statusCode\nReason: $reasonPhrase';
}
