import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bita_markets/utils/utils.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

class EndPointException implements Exception {
  EndPointException({required this.error, required this.code});
  Map<String, dynamic> error;
  int code;
  @override
  String toString() {
    return '$code: $error';
  }
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
  required void Function() permission,
  required Future<Response> Function() endpoint,
}) async {
  try {
    permission();
    return await endpoint();
  } on EndPointException catch (e) {
    logger.e(e.error);
    return jsonResponse(statusCode: e.code, body: e.error);
  } on FieldValidationException catch (e) {
    logger.e(e.error);
    return jsonResponse(statusCode: HttpStatus.badRequest, body: e.error);
  } on ServerException catch (e) {
    logger.e(e, time: DateTime.now());
    // Constraint errors
    //23505 Unique error
    //23514 Chech Violation
    //23502 not_null_violation
    //23001 restrict_violation
    //23503 foreign_key_violation
    //23P01 exclusion_violation
    //23503
    if (e.code == '23503') {
      // print(e);
      // print(e.columnName);
      // print(e.constraintName);
      // print(e.tableName);
      // print(e.detail);
      // print(e.message);
      // print(e.);
      return jsonResponse(
        statusCode: HttpStatus.badRequest,
        body: {'detail': e.detail},
      );
    }
    return jsonResponse(
      statusCode: HttpStatus.badRequest,
      body: {'detail': e.toString()},
    );
  } catch (e) {
    logger.f(e);
    return jsonResponse(
      statusCode: HttpStatus.internalServerError,
      body: {'detail': e.toString()},
    );
  }
}

Response jsonResponse({int statusCode = 200, Object? body}) {
  return Response(
    statusCode,
    body: jsonEncode(body ?? {}),
    headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
  );
}
