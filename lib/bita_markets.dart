import 'dart:async';
import 'dart:io';

import 'package:bita_markets/endpoints/business_api.dart';
import 'package:bita_markets/endpoints/users_api.dart';
import 'package:bita_markets/middlewares/authentication.dart';
import 'package:bita_markets/middlewares/content_type.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) {
  withHotreload(createServer);
}

Future<HttpServer> createServer() async {
  final app = Router()
    ..mount(
      '/users',
      const Pipeline()
          .addMiddleware(contentTypeMiddleware)
          .addHandler(UsersApi().router.call),
    )
    ..mount(
      '/business',
      const Pipeline()
          .addMiddleware(contentTypeMiddleware)
          .addHandler(BusinessApi().router.call),
    );
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(authMiddleWare)
      .addHandler(app.call);
  final server = await serve(handler, 'localhost', 8000);

  server.autoCompress = true;

  return server;
}
