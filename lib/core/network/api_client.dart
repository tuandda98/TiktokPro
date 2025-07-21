import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    return await _client.get(uri, headers: headers);
  }

  Future<http.Response> post(String url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final uri = Uri.parse(url);
    return await _client.post(uri, headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> put(String url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final uri = Uri.parse(url);
    return await _client.put(uri, headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> delete(String url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final uri = Uri.parse(url);
    return await _client.delete(uri, headers: headers, body: body, encoding: encoding);
  }

  void dispose() {
    _client.close();
  }
}
