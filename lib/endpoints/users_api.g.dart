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
    service.updateThroughPutAUser,
  );
  router.add(
    'DELETE',
    r'/me',
    service.delAUser,
  );
  router.add(
    'PATCH',
    r'/<id>',
    service.updateUser,
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
    'GET',
    r'/me',
    service.userMe,
  );
  router.add(
    'POST',
    r'/verifyOtp',
    service.verifyOtp,
  );
  return router;
}
