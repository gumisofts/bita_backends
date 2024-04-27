import 'dart:async';
import 'dart:io';

import 'package:bita_markets/endpoints/users_api.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) {
  final app = Router()..mount('/users', UsersApi().router.call);

  withHotreload(() => createServer(app));
}

Future<HttpServer> createServer(Router app) async {
  final server = await serve(app.call, 'localhost', 9000);

  server.autoCompress = true;

  return server;
}
