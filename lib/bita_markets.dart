import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:bita_markets/endpoints/business_api.dart';
import 'package:bita_markets/endpoints/shopping_api.dart';
import 'package:bita_markets/endpoints/users_api.dart';
import 'package:bita_markets/middlewares/authentication.dart';
import 'package:bita_markets/middlewares/content_type.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:d_orm/d_orm.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

void main(List<String> args) {
  initDb;
  if (args.isEmpty) {
    createServer;
  } else {
    createDevServer;
  }
}

Future<void> get createServer async {
  for (var index = 0; index < Platform.numberOfProcessors; index++) {
    await Isolate.spawn(
      debugName: 'Isolate $index',
      (message) {
        logger.i('Isolate $index spawned');
        initDb;
        serve(
          (Request request) async {
            logger.d('Isolate $index handling the request');
            return application(request);
          },
          'localhost', // 127.0.0.1 -> loop back
          8000,
          shared: true,
        ).then((value) => value..autoCompress = true);
      },
      'Isolate $index',
    );
  }

  final server = await serve(application, 'localhost', 8000, shared: true);
  server.autoCompress = true;
}

void get initDb {
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
    poolSetting: PoolSettings(
      maxConnectionAge: const Duration(milliseconds: 1000),
      maxConnectionCount: 10,
      sslMode:
          env['PG_USE_SSL'] == 'true' ? SslMode.verifyFull : SslMode.disable,
    ),
    logger: logger.f,
  );
}

void get createDevServer => withHotreload(() async {
      final server = await serve(application, '0.0.0.0', 8000, shared: true);

      return server;
    });

Handler get application {
  final app = Router()
    ..mount(
      '/users',
      const Pipeline()
          .addMiddleware(contentTypeMiddleware)
          .addHandler(UsersApi().router.call),
    )
    ..mount(
      '/static',
      createStaticHandler('public', defaultDocument: 'index.html'),
    )
    ..mount(
      '/business',
      const Pipeline()
          .addMiddleware(contentTypeMiddleware)
          .addHandler(BusinessApi().router.call),
    )
    ..mount('/shopping/products', ShoppingProductApi().router.call)
    ..mount('/shopping/bussiness', ShoppingBusinessAPI().router.call);
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(authMiddleWare)
      .addHandler(app.call);

  return handler;
}
