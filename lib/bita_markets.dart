import 'dart:async';
import 'dart:io';

import 'package:bita_markets/endpoints/users_api.dart';
import 'package:bita_markets/middlewares/authenticaation.dart';
import 'package:bita_markets/utils/function/request_handler_wrapper.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) {
  withHotreload(createServer);
}

Future<HttpServer> createServer() async {
  final app = Router()..mount('/users', UsersApi().router.call);
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(authMiddleWare)
      .addHandler(app.call);
  final server = await serve(handler, 'localhost', 8000);

  server.autoCompress = true;

  return server;
}
