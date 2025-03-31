import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class BaseSocket extends http.BaseClient {
  final String socket;
  final HttpClient _inner;

  BaseSocket(this.socket) : _inner = HttpClient() {
    _inner.connectionFactory = ((uri, proxyHost, proxyPort) {
      final host = InternetAddress(socket, type: InternetAddressType.unix);
      return Socket.startConnect(host, 0);
    });
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final HttpClientRequest req =
        await _inner.openUrl(request.method, request.url);
    req.persistentConnection = false;
    req.followRedirects = request.followRedirects;

    request.headers.forEach((name, value) {
      req.headers.add(name, value);
    });
    if (request is http.Request) {
      req.add(request.bodyBytes);
    } else {
      throw UnsupportedError('Bad request');
    }

    final HttpClientResponse resp = await req.close();
    final headers = <String, String>{};
    resp.headers.forEach((name, values) {
      headers[name] = values.join(',');
    });

    final Stream<Uint8List> byteStream =
        resp.map((chunk) => Uint8List.fromList(chunk));
    return http.StreamedResponse(
      byteStream,
      resp.statusCode,
      headers: headers,
      contentLength: resp.contentLength == -1 ? null : resp.contentLength,
      isRedirect: resp.isRedirect,
      persistentConnection: resp.persistentConnection,
      reasonPhrase: resp.reasonPhrase,
    );
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
