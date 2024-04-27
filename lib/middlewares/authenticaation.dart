import 'dart:async';

import 'package:bita_markets/models/schema.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:shelf/shelf.dart';

FutureOr<Response> Function(Request request) authMiddleWare(
  FutureOr<Response> Function(Request request) innerHanler,
) {
  return (request) async {
    var auth = request.headers['auth'] ?? '';
    final splitted = auth.split(RegExp(r'\s+'));

    if (splitted.length != 2) {}
    if (splitted.first != 'Bearer') {}
    auth = splitted.last;
    final data = JWTAuth.decodeAndVerify(auth) ?? <String, String>{};
    final userId = data['id'] as int?;
    User? user;
    if (userId != null) {
      user = await UserDb.get(where: (t) => t.id.equals(userId));
    }
    final rr =
        request.change(context: {...request.context, 'user': user ?? false});

    return innerHanler(rr);
  };
}
