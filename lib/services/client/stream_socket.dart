import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:pocker/services/exception/api_exception.dart';

import 'base_socket.dart';

class StreamSocket {
  StreamSocket({
    required String socket,
  }) : client = BaseSocket(socket);

  final BaseSocket client;

  String _getHost(bool compat) {
    return compat ? 'localhost' : 'd';
  }

  String _formatPath(bool compat, String path) {
    return compat ? path : '/v5.0.0/libpod$path';
  }

  Future<void> get({
    required String path,
    Map<String, dynamic>? queryParams,
    bool compat = false,
    Function(List<int>)? onData,
    Function()? onFinished,
  }) async {
    final url = Uri.http(
      _getHost(compat),
      _formatPath(compat, path),
      queryParams,
    );
    final req = http.Request('GET', url);
    final resp = await client.send(req);
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        await resp.stream.bytesToString(),
      );
    }
    //
    resp.stream.listen((event) {
      if (onData != null) {
        onData(event);
      }
    }, onDone: () {
      if (onFinished != null) {
        onFinished();
      }
    }, onError: (e) {
      throw ApiException(
        resp.statusCode,
        e.toString(),
      );
    }, cancelOnError: true);
  }

  Future<void> post({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    List<int>? body,
    bool compat = false,
    Function(String)? onData,
    Function()? onFinished,
  }) async {
    final url = Uri.http(
      _getHost(compat),
      _formatPath(compat, path),
      queryParams,
    );
    final req = http.Request('POST', url);
    if (headers != null) {
      req.headers.addAll(headers);
    }
    if (body != null) {
      req.bodyBytes = body;
    }
    final resp = await client.send(req);
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        await resp.stream.bytesToString(),
      );
    }
    //
    resp.stream.transform(utf8.decoder).listen((event) {
      if (onData != null) {
        onData(event);
      }
    }, onDone: () {
      if (onFinished != null) {
        onFinished();
      }
    }, onError: (e) {
      throw ApiException(
        resp.statusCode,
        e.toString(),
      );
    });
  }
}
