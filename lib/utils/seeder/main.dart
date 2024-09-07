import 'package:bita_markets/utils/seeder/catagories.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:pg_dorm/pg_dorm.dart';

void main(List<String> args) {
  initDb;
  addCatagories();
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
      maxConnectionAge: const Duration(days: 100),
      connectTimeout: const Duration(seconds: 10),
      maxConnectionCount: 10,
      sslMode: env['PG_USE_SSL'] == 'true' ? SslMode.require : SslMode.disable,
    ),
    logger: logger.f,
  );
}
