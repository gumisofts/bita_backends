// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_api.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$ShoppingProductApiRouter(ShoppingProductApi service) {
  final router = Router();
  router.add(
    'GET',
    r'/',
    service.searchProducts,
  );
  router.add(
    'GET',
    r'/popular',
    service.popularProducts,
  );
  router.add(
    'GET',
    r'/suggested',
    service.suggestedProducts,
  );
  router.add(
    'GET',
    r'/rate/<id>',
    service.getProductRate,
  );
  router.add(
    'POST',
    r'/rate/<id>',
    service.createProductRate,
  );
  router.add(
    'POST',
    r'/report/<id>',
    service.reportProduct,
  );
  return router;
}

Router _$ShoppingBusinessAPIRouter(ShoppingBusinessAPI service) {
  final router = Router();
  router.add(
    'GET',
    r'/',
    service.searchBusiness,
  );
  router.add(
    'GET',
    r'/popular',
    service.popularBusiness,
  );
  router.add(
    'GET',
    r'/suggested',
    service.suggestedBusiness,
  );
  router.add(
    'GET',
    r'/rate/<id>',
    service.getBusinessRate,
  );
  router.add(
    'POST',
    r'/rate/<id>',
    service.createBusinessRate,
  );
  router.add(
    'POST',
    r'/report/<id>',
    service.reportProduct,
  );
  return router;
}
