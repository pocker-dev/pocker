import 'dart:convert';
import 'dart:typed_data';

import 'package:pocker/services/exception/api_exception.dart';

import 'base_socket.dart';

class HttpSocket {
  HttpSocket({
    required String socket,
  }) : client = BaseSocket(socket);

  final BaseSocket client;
  final _defaultHeaderMap = <String, String>{};

  String _getHost(bool compat) {
    return compat ? 'localhost' : 'd';
  }

  String _formatPath(bool compat, String path) {
    return compat ? path : '/v5.0.0/libpod$path';
  }

  Future<Uint8List> getRaw({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    bool compat = false,
  }) async {
    // TODO auth
    if (headers != null && _defaultHeaderMap.isNotEmpty) {
      headers.addAll(_defaultHeaderMap);
    }
    final url = Uri.http(
      _getHost(compat),
      _formatPath(compat, path),
      queryParams,
    );
    final resp = await client.get(url, headers: headers);
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    return resp.bodyBytes;
  }

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParams,
    bool compat = false,
  }) async {
    final respBytes = await getRaw(
      path: path,
      queryParams: queryParams,
      headers: {
        'Content-Type': 'application/json',
      },
      compat: compat,
    );
    final respBody = utf8.decode(respBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }

  Future<Uint8List> postRaw({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    Object? body,
    bool compat = false,
  }) async {
    // TODO auth
    if (headers != null && _defaultHeaderMap.isNotEmpty) {
      headers.addAll(_defaultHeaderMap);
    }
    final url = Uri.http(
      _getHost(compat),
      _formatPath(compat, path),
      queryParams,
    );
    final resp = await client.post(url, headers: headers, body: body);
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    return resp.bodyBytes;
  }

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? queryParams,
    Object body = const {},
    bool compat = false,
  }) async {
    final respBytes = await postRaw(
      path: path,
      queryParams: queryParams,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
      compat: compat,
    );
    final respBody = utf8.decode(respBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? queryParams,
    Object body = const {},
    bool compat = false,
  }) async {
    // TODO auth
    Map<String, String> headers = {};
    headers.addAll(_defaultHeaderMap);
    headers['Content-Type'] = 'application/json';

    final url = Uri.http(
      _getHost(compat),
      _formatPath(compat, path),
      queryParams,
    );
    final resp =
        await client.put(url, headers: headers, body: json.encode(body));
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    final respBody = utf8.decode(resp.bodyBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }

  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? queryParams,
    Object body = const {},
    bool compat = false,
  }) async {
    // TODO auth
    Map<String, String> headers = {};
    headers.addAll(_defaultHeaderMap);
    headers['Content-Type'] = 'application/json';

    final url = Uri.http(
      _getHost(compat),
      _formatPath(compat, path),
      queryParams,
    );
    final resp =
        await client.patch(url, headers: headers, body: json.encode(body));
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    final respBody = utf8.decode(resp.bodyBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }

  Future<dynamic> head({
    required String path,
    Map<String, dynamic>? queryParams,
    bool compat = false,
  }) async {
    // TODO auth
    Map<String, String> headers = {};
    headers.addAll(_defaultHeaderMap);
    headers['Content-Type'] = 'application/json';

    final url = Uri.http(
      _getHost(compat),
      _formatPath(compat, path),
      queryParams,
    );
    final resp = await client.head(url, headers: headers);
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    final respBody = utf8.decode(resp.bodyBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }

  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? queryParams,
    Object body = const {},
    bool compat = false,
  }) async {
    // TODO auth
    Map<String, String> headers = {};
    headers.addAll(_defaultHeaderMap);
    headers['Content-Type'] = 'application/json';

    final url = Uri.http(
      _getHost(compat),
      _formatPath(compat, path),
      queryParams,
    );
    final resp =
        await client.delete(url, headers: headers, body: json.encode(body));
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    final respBody = utf8.decode(resp.bodyBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }
}
