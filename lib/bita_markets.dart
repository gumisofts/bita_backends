import 'dart:async';
import 'dart:io';

import 'package:bita_markets/endpoints/business_api.dart';
import 'package:bita_markets/endpoints/users_api.dart';
import 'package:bita_markets/middlewares/authentication.dart';
import 'package:bita_markets/middlewares/content_type.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:d_orm/d_orm.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) {
  Database.init(
    endpoints: [
      Endpoint(
        host: env.getOrElse('PG_HOST', () => 'localhost'),
        database: env.getOrElse('POSTGRES_DB', () => ''),
        username: env['POSTGRES_USER'],
        password: env['POSTGRES_PASSWORD'],
        port: int.parse(
          env.getOrElse('PG_PORT', () => '5432'),
        ),
      ),
    ],
    poolSetting: const PoolSettings(
      maxConnectionAge: Duration(milliseconds: 1000),
      maxConnectionCount: 90,
      sslMode: SslMode.disable,
    ),
    logger: logger.f,
  );
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
