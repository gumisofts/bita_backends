import 'package:bita_markets/models/schema.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  final client = APIClient(baseUrl: 'http://localhost:8000');
  initTestDb;
  test('CREATE SHOP', () async {
    final user = await UserDb.create(firstName: 'Hello');
    client.login(user);
  });

  test('calculate', () {
    expect(400, 400);
  });
}

class APIClient {
  APIClient({required this.baseUrl}) {
    headers = {'authorization': _token};
  }
  String _token = '';
  String baseUrl;
  late Map<String, String> headers;
  String login(User user) {
    return _token = JWTAuth.authenticate(user);
  }

  void logout() {
    _token = '';
  }

  Future<Response> post({required String path, required Object data}) async {
    final res = await http.post(
      Uri.parse(baseUrl + path),
      headers: headers,
      body: data,
    );

    return res;
  }

  Future<Response> patch({required String path, required Object data}) async {
    final res = await http.patch(
      Uri.parse(baseUrl + path),
      headers: headers,
      body: data,
    );

    return res;
  }

  Future<Response> get({required String path}) async {
    final res = await http.get(
      Uri.parse(baseUrl + path),
      headers: headers,
    );

    return res;
  }

  Future<Response> delete({required String path}) async {
    final res = await http.delete(
      Uri.parse(baseUrl + path),
      headers: headers,
    );

    return res;
  }
}
