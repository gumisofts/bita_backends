import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:bita_markets/endpoints/auth.dart';
import 'package:bita_markets/endpoints/business_api.dart';
import 'package:bita_markets/endpoints/platform_api.dart';
import 'package:bita_markets/endpoints/shopping_api.dart';
import 'package:bita_markets/endpoints/users.dart';
import 'package:bita_markets/middlewares/authentication.dart';
import 'package:bita_markets/middlewares/content_type.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

void main(List<String> args) {
  initDb;
  final port = int.parse(env.getOrElse('PORT', () => '8000'));
  if (args.isEmpty) {
    createServer(port);
  } else {
    createDevServer(port);
  }
  logger.i('Started serving on $port');
}

Future<void> createServer(int port) async {
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
          port,
          shared: true,
        ).then((value) => value..autoCompress = true);
      },
      'Isolate $index',
    );
  }

  final server = await serve(
    application,
    'localhost',
    port,
    shared: true,
  );
  server.autoCompress = true;
}

void createDevServer(int port) => withHotreload(() async {
      final server = await serve(application, '0.0.0.0', port, shared: true);

      return server;
    });

Handler get application {
  final app = Router()
    ..mount(
      '/users',
      UsersApi().router.call,
    )
    ..mount(
      '/auth',
      AuthApi().router.call,
    )
    ..mount(
      mediaUrl,
      createStaticHandler(
        '/var/bita_market_build/public',
        defaultDocument: 'index.html',
      ),
    )
    ..mount(
      '/business',
      BusinessApi().router.call,
    )
    ..mount(
      '/platform',
      PlatformApi().router.call,
    )
    ..mount('/shopping/products', ShoppingProductApi().router.call)
    ..mount('/shopping/bussiness', ShoppingBusinessAPI().router.call);
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(authMiddleWare)
      .addMiddleware(contentTypeMiddleware)
      .addHandler(app.call);

  return handler;
}
