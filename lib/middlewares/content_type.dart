import 'dart:async';
import 'dart:io';

import 'package:bita_markets/utils/function/request_handler_wrapper.dart';
import 'package:shelf/shelf.dart';

FutureOr<Response> Function(Request request) contentTypeMiddleware(
  FutureOr<Response> Function(Request request) innerHanler, {
  List<String> contentTypes = const [
    'application/json',
    'multipart/form-data',
    'application/x-www-form-urlencoded',
  ],
}) {
  return (request) {
    final contentType =
        request.headers[HttpHeaders.contentTypeHeader]?.split(';').first;
    if (!contentTypes.contains(contentType) &&
        ['PATCH', 'PUT', 'POST'].contains(request.method)) {
      return jsonResponse(
        statusCode: HttpStatus.unsupportedMediaType,
        body: {'detail': 'unsupported media type'},
      );
    }

    return innerHanler(request);
  };
}
