import 'dart:io';
import 'dart:math';

import 'package:bita_markets/utils/forms/parsers/form_data.dart';
import 'package:dotenv/dotenv.dart';
import 'package:logger/logger.dart';
import 'package:pg_dorm/pg_dorm.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

export 'email/email.dart';
export 'extensions.dart';
export 'forms/field_exceptions.dart';
export 'forms/form_validators.dart';
export 'jwt.dart';
export 'sms/sms.dart';

const mediaRoot = 'public';
const mediaUrl = '/medias';
int generateSecureRandom({int length = 6}) {
  final max = (pow(10, length) - 1).toInt(); //999,999
  final min = pow(10, length - 1).toInt();
  return Random.secure().nextInt(max - min) + min; //s
}

final logger = Logger(
  printer: PrettyPrinter(
    // methodCount: 5, // Number of method calls to be displayed
    // errorMethodCount: 8, // Number of method calls if stacktrace is provided
    // lineLength: 120, // Width of the output
    // colors: true, // Colorful log messages
    // printEmojis: true, // Print an emoji for each log message
    dateTimeFormat: (datetime) =>
        datetime.toIso8601String(), // Should each log print contain a timestamp
  ),
);
final env = DotEnv(includePlatformEnvironment: true, quiet: true)..load();

Future<File> writeFileTo({
  required UploadedFile file,
  String to = '',
}) async {
  final ext = file.name.split('.').last;
  final fileName = '${uniqueId()}.$ext'.replaceAll('-', '');

  final f = await File('$mediaRoot$to/$fileName')
      .create(recursive: true, exclusive: true);

  final content = await file.readAsBytes();

  await f.writeAsBytes(content);

  // .listen(
  //   content.addAll,
  //   onDone: () {
  //     f.writeAsBytesSync(content);
  //   },
  // );

  return f;
}

String uniqueId({bool secure = false}) => secure
    ? const Uuid().v4()
    : const Uuid().v4(
        config: V4Options(
          null,
          CryptoRNG(),
        ),
      );

void get initDb {
  Database.init(
    endpoints: [
      Endpoint(
        host: env.getOrElse('PG_HOST', () => 'localhost'),
        database: env.getOrElse('PG_DB_NAME', () => ''),
        username: env['PG_USER'],
        password: env['PG_PASSWORD'],
        port: int.parse(
          env.getOrElse('PG_PORT', () => '5432'),
        ),
      ),
    ],
    poolSetting: PoolSettings(
      maxConnectionAge: const Duration(days: 100),
      connectTimeout: const Duration(seconds: 10),
      maxConnectionCount: 10,
      sslMode: env['PG_USE_SSL'] == 'true' ? SslMode.require : SslMode.disable,
    ),
    logger: logger.f,
  );
}

void get initTestDb {
  Database.init(
    endpoints: [
      Endpoint(
        host: env.getOrElse('PG_HOST', () => 'localhost'),
        database: env.getOrElse('PG_DB_NAME', () => ''),
        username: env['PG_USER'],
        password: env['PG_PASSWORD'],
        port: int.parse(
          env.getOrElse('PG_PORT', () => '5432'),
        ),
      ),
    ],
    poolSetting: PoolSettings(
      maxConnectionAge: const Duration(days: 100),
      connectTimeout: const Duration(seconds: 10),
      maxConnectionCount: 10,
      sslMode: env['PG_USE_SSL'] == 'true' ? SslMode.require : SslMode.disable,
    ),
    logger: logger.f,
  );
}
