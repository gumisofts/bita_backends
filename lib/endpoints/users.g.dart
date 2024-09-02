// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

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
  return router;
}
