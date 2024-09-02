import 'dart:async';

import 'package:bita_markets/models/schema.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:shelf/shelf.dart';

FutureOr<Response> Function(Request request) authMiddleWare(
  FutureOr<Response> Function(Request request) innerHanler,
) {
  return (request) async {
    final auth = request.headers['authorization'] ?? '';
    final splitted = auth.split(RegExp(r'\s+'));

    if (splitted.length != 2 || splitted.first != 'Bearer') {
      return innerHanler(
        request.change(context: {...request.context, 'user': false}),
      );
    }
    final data = JWTAuth.decodeAndVerify(splitted.last) ?? <String, String>{};
    final userId = data['id'] as int?;
    User? user;
    if (userId != null) {
      user = await UserDb.get(where: (t) => t.id.equals(userId));
    }
    return innerHanler(
      request.change(context: {...request.context, 'user': user ?? false}),
    );
  };
}
