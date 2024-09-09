// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_api.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PlatformApiRouter(PlatformApi service) {
  final router = Router();
  router.add(
    'POST',
    r'/interests',
    service.userInterest,
  );
  router.add(
    'POST',
    r'/upload',
    service.testFile,
  );
  return router;
}
