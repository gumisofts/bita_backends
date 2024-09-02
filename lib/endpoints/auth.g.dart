// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AuthApiRouter(AuthApi service) {
  final router = Router();
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
    r'/login',
    service.loginWithPassword,
  );
  router.add(
    'POST',
    r'/validate_password',
    service.validatePassword,
  );
  router.add(
    'POST',
    r'/set_password',
    service.setPassword,
  );
  router.add(
    'POST',
    r'/change_password',
    service.changePassword,
  );
  router.add(
    'POST',
    r'/change_phone',
    service.changePhone,
  );
  router.add(
    'POST',
    r'/change_email',
    service.changeEmail,
  );
  router.add(
    'GET',
    r'/verify_change_phone/<requestId>/<token>',
    service.verifyChangePhone,
  );
  router.add(
    'GET',
    r'/verify_change_email/<requestId>/<token>',
    service.verifyChangeEmail,
  );
  return router;
}
