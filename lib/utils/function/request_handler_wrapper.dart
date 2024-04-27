import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bita_markets/utils/forms/field_exceptions.dart';
import 'package:shelf/shelf.dart';

class EndPointException implements Exception {
  EndPointException({required this.error, required this.code});
  Map<String, dynamic> error;
  int code;
}

final unAuthorizedException = EndPointException(
  error: {'detail': 'Not authenticated'},
  code: HttpStatus.unauthorized,
);
final forbidenException = EndPointException(
  error: {
    'detail': "you don't have permission to do this action",
  },
  code: HttpStatus.forbidden,
);

Future<Response> handleRequestWithPermission(
  Request request, {
  required Future<Response> Function() endpoint,
  required void Function() permission,
}) async {
  try {
    permission();
    return await endpoint();
  } on EndPointException catch (e) {
    return jsonResponse(statusCode: e.code, body: e.error);
  } on FieldValidationException catch (e) {
    return jsonResponse(statusCode: HttpStatus.badRequest, body: e.error);
  } catch (e) {
    return jsonResponse(
      statusCode: HttpStatus.internalServerError,
      body: {'detail': e.toString()},
    );
  }
}

Future<Response> jsonResponse({int statusCode = 200, Object? body}) {
  return Future.value(
    Response(
      statusCode,
      body: jsonEncode(body),
      headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
    ),
  );
}
