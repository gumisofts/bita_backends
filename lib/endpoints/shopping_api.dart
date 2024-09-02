import 'package:bita_markets/utils/function/request_handler_wrapper.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
part 'shopping_api.g.dart';

class ShoppingProductApi {
  Router get router => _$ShoppingProductApiRouter(this);
  @Route.get('/')
  Future<Response> searchProducts(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          final query = request.url.queryParameters['query'];
          if (query == null) return jsonResponse();
          return jsonResponse();
        },
      );
  @Route.get('/popular')
  Future<Response> popularProducts(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );

  @Route.get('/suggested')
  Future<Response> suggestedProducts(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );

  @Route.get('/rate/<id>')
  Future<Response> getProductRate(Request request, String id) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );
  @Route.post('/rate/<id>')
  Future<Response> createProductRate(Request request, String id) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );
  @Route.post('/report/<id>')
  Future<Response> reportProduct(Request request, String id) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );
}

class ShoppingBusinessAPI {
  Router get router => _$ShoppingBusinessAPIRouter(this);
  @Route.get('/')
  Future<Response> searchBusiness(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );
  @Route.get('/popular')
  Future<Response> popularBusiness(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );
  @Route.get('/suggested')
  Future<Response> suggestedBusiness(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );

  @Route.get('/rate/<id>')
  Future<Response> getBusinessRate(Request request, String id) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );
  @Route.post('/rate/<id>')
  Future<Response> createBusinessRate(Request request, String id) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );
  @Route.post('/report/<id>')
  Future<Response> reportProduct(Request request, String id) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );
}
