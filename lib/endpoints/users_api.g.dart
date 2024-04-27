// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_api.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UsersApiRouter(UsersApi service) {
  final router = Router();
  router.add(
    'PUT',
    r'/<id>',
    service.getAUser,
  );
  router.add(
    'DELETE',
    r'/<id>',
    service.delAUser,
  );
  router.add(
    'POST',
    r'/getStartedWithEmail',
    service.getStartedEmail,
  );
  router.add(
    'POST',
    r'/getStartedWithPhone',
    service.getStartedPhone,
  );
  router.add(
    'POST',
    r'/verifyOtp',
    service.verifyOtp,
  );
  return router;
}
