import 'dart:io';

import 'package:bita_markets/models/schema.dart';
import 'package:bita_markets/utils/function/request_handler_wrapper.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
part 'business_api.g.dart';

class BusinessApi {
  Router get router => _$BusinessApiRouter(this);
  @Route.post('/')
  Future<Response> createShop(Request request) => handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          final data = await form(
            request,
            fields: [
              FieldValidator<String>(
                name: 'name',
                isRequired: true,
              ),
              FieldValidator<int>(
                name: 'catagoryId',
                isRequired: true,
              ),
              FieldValidator<Map<String, dynamic>>(
                name: 'address',
                isRequired: true,
              ),
            ],
          );

          final address = await AddressDb.create(
            lat: data['address']!['lat'] as double?,
            lng: data['address']!['lng'] as double?,
            plusCode: data['address']!['plusCode'] as String?,
            sublocality: data['address']!['sublocality'] as String?,
            locality: data['address']!['locality'] as String?,
            admin1: data['address']!['admin1'] as String?,
            admin2: data['address']!['admin2'] as String?,
            country: data['address']!['country'] as String?,
          );

          final bb = await BusinessDb.create(
            name: data['name'] as String,
            ownerId: request.contextUser!.id!,
            addressId: address.id!,
          );
          return jsonResponse(body: bb.toJson());
        },
      );
  @Route.get('/mine')
  Future<Response> getCurrentUserBusiness(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          final bizs = await BusinessDb.filter(
            where: (where) =>
                where.ownerId.equals(request.contextUser?.id ?? 0),
          );
          return jsonResponse(body: bizs.map((e) => e.toJson()).toList());
        },
      );
  @Route('PATCH', '/<id>')
  Future<Response> updateBiz(Request request, String id) =>
      handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          final biz = await BusinessDb.get(
            where: (where) => where.id.equals(int.parse(id)),
          );
          final data = await form(
            request,
            fields: [
              FieldValidator<String>(name: 'name'),
              FieldValidator<int>(name: 'catagoryId'),
            ],
          );

          if (biz == null) {
            return jsonResponse(statusCode: HttpStatus.notFound);
          }
          if (data.containsKey('name')) {
            biz.name = data['name'] as String;
          }
          if (data.containsKey('catagoryId')) {
            biz.catagoryId = data['catagoryId'] as int;
          }
          await biz.save();
          return jsonResponse(body: biz.toJson());
        },
      );
// TODO(nuradic): update address.
  @Route.post('/products')
  Future<Response> createProducts(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
          // exists
        },
        endpoint: () async {
          final data = await form(
            request,
            fields: [
              FieldValidator<String>(name: 'name', isRequired: true),
              FieldValidator<double>(name: 'costPrice', isRequired: true),
              FieldValidator<double>(name: 'sellingPrice', isRequired: true),
              FieldValidator<double>(name: 'quantity', isRequired: true),
              FieldValidator<int>(name: 'bizId', isRequired: true),
              FieldValidator<int>(name: 'brandId'),
              FieldValidator<int>(name: 'unitId'),
              FieldValidator<String>(name: 'expireDate'),
              FieldValidator<String>(name: 'manDate'),
              FieldValidator<String>(name: 'desc'),
            ],
          );

          final product = await ProductDb.create(
            name: data['name'] as String,
            costPrice: data['costPrice'] as double,
            sellingPrice: data['costPrice'] as double,
            quantity: data['costPrice'] as double,
            businessId: data['bizId'] as int,
            catagoryId: data['catagoryId'] as int?,
            brandId: data['brandId'] as int?,
            unitId: data['unitId'] as int?,
            expireDate: data['expireDate'] as DateTime?,
            manDate: data['manDate'] as DateTime?,
            desc: data['desc'] as String?,
          );
          return jsonResponse(body: product.toJson());
        },
      );

  @Route.get('/products/<bizId>')
  Future<Response> getShopProducts(Request request, String bizId) =>
      handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          final offset = request.url.queryParameters['offset'] == null
              ? 0
              : int.parse(request.url.queryParameters['offset']!);
          final limit = request.url.queryParameters['limit'] == null
              ? null
              : int.parse(request.url.queryParameters['limit']!);
          final products = await ProductDb.filter(
            where: (where) =>
                where.businessId.equals(int.parse(bizId)) &
                where.business.ownerId.equals(request.contextUser?.id ?? 0),
            offset: offset,
            limit: limit,
          );
          return jsonResponse(body: products.map((e) => e.toJson()).toList());
        },
      );
  @Route.delete('/products/<bizId>/<productId>')
  Future<Response> deleteShopProduct(
    Request request,
    String bizId,
    String productId,
  ) =>
      handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          final product = await ProductDb.get(
            where: (where) =>
                where.businessId.equals(
                  int.parse(bizId),
                ) &
                // Add more filters for permission
                where.id.equals(
                  int.parse(productId),
                ),
          );

          if (product == null) {
            return jsonResponse(statusCode: HttpStatus.notFound);
          }

          // delete products

          // await product.delete();

          return jsonResponse(body: product.toJson());
        },
      );
  @Route('PATCH', '/products/<bizId>/<productId>')
  Future<Response> updateBizProduct(
    Request request,
    String bizId,
    String productId,
  ) =>
      handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          final product = await ProductDb.get(
            where: (where) =>
                where.businessId.equals(
                  int.parse(bizId),
                ) &
                // Add more filters for permission
                where.id.equals(
                  int.parse(productId),
                ),
          );

          if (product == null) {
            return jsonResponse(statusCode: HttpStatus.notFound);
          }

          final data = await form(
            request,
            fields: [
              FieldValidator<String>(name: 'name'),
              FieldValidator<double>(name: 'costPrice'),
              FieldValidator<double>(name: 'sellingPrice'),
              FieldValidator<double>(name: 'quantity'),
              FieldValidator<int>(name: 'bizId'),
              FieldValidator<int>(name: 'brandId'),
              FieldValidator<int>(name: 'unitId'),
              FieldValidator<String>(name: 'expireDate'),
              FieldValidator<String>(name: 'manDate'),
              FieldValidator<String>(name: 'desc'),
            ],
          );

          if (data.containsKey('name')) {
            product.name = data['name'] as String;
          }
          if (data.containsKey('costPrice')) {
            product.costPrice = data['costPrice'] as double;
          }
          if (data.containsKey('sellingPrice')) {
            product.sellingPrice = data['sellingPrice'] as double;
          }
          if (data.containsKey('quantity')) {
            product.quantity = data['quantity'] as double;
          }
          if (data.containsKey('brandId')) {
            product.brandId = data['brandId'] as int?;
          }
          if (data.containsKey('unitId')) {
            product.unitId = data['unitId'] as int?;
          }
          if (data.containsKey('desc')) {
            product.desc = data['desc'] as String?;
          }
          if (data.containsKey('expireDate')) {
            product.expireDate = data['expireDate'] as DateTime;
          }
          if (data.containsKey('manDate')) {
            product.manDate = data['manDate'] as DateTime;
          }

          await product.save();

          return jsonResponse(body: product.toJson());
        },
      );
}
