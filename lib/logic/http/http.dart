import 'package:http/http.dart';

class Https {
  static Future<Response> getMethod({
    required String url,
  }) async {
    final response = await get(Uri.parse(url));
    return response;
  }
}
