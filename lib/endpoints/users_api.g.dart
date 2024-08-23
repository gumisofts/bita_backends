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
    r'/get_started_with_email',
    service.getStartedEmail,
  );
  router.add(
    'POST',
    r'/get_started_with_phone',
    service.getStartedPhone,
  );
  router.add(
    'GET',
    r'/me',
    service.userMe,
  );
  router.add(
    'POST',
    r'/verify_otp',
    service.verifyOtp,
  );
  router.add(
    'POST',
    r'/changeEmail',
    service.changeEmail,
  );
  router.add(
    'POST',
    r'/changePhone',
    service.changePhone,
  );
  return router;
}
