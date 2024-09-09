import 'dart:io';

import 'package:bita_markets/models/schema.dart';
import 'package:bita_markets/utils/forms/parsers/form_data.dart';
import 'package:bita_markets/utils/function/request_handler_wrapper.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:pg_dorm/database/database.dart';
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
              FieldValidator<int?>(
                name: 'logoId',
              ),
              FieldValidator<int>(name: 'logoId'),
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

          // final logo = data['image'] as UploadedFile?;

          // String? logoUrl;

          // if (logo != null) {
          //   logoUrl = await uploadFileTo(file: logo);
          // }

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
            logoId: data['logoId'] as int?,
          );
          final add = await AddressDb.get(
            where: (where) => where.id.equals(bb.addressId),
          );
          return jsonResponse(
            body: {
              ...bb.toJson(),
              ...{'address': add?.toJson()},
            },
          );
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
          final data = <Map<String, dynamic>>[];

          for (final item in bizs) {
            final address = (await item.address)?.toJson() ?? {};
            data.add({...item.toJson(), 'address': address});
          }
          // TODO(db): Fix with include
          return jsonResponse(body: data);
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
  @Route('PATCH', '/address')
  Future<Response> updateAddress(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          return jsonResponse();
        },
      );
// TODO(nurads): Business Preferences

// TODO(nurads): Employee Role and Permissions
// TODO(nurads): Business Activities(Imuttable log)

// TODO(nurads): Transefer Business ownership
// TODO(nurads): Delete Businnes
// TODO(nurads): Business Rate and Feedback
// TODO(nurads): Rate Products
  @Route.post('/employeeThroughPhone/<shopId>')
  Future<Response> createEmployee(Request request, String shopId) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          final data = await form(
            request,
            fields: [
              FieldValidator<String>(name: 'phoneNumber', isRequired: true),
            ],
          );

          User? user;

          user = await UserDb.get(
            where: (where) =>
                where.phoneNumber.equals(data['phoneNumber'] as String),
          );

          user ??=
              await UserDb.create(phoneNumber: data['phoneNumber'] as String);

          final result = await BusinessEmployeDb.create(
            userId: user.id!,
            businessId: int.parse(shopId),
          );

          return jsonResponse(body: result.toJson());
        },
      );
  @Route.get('/employee')
  Future<Response> getEmployees(Request request) => handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          return jsonResponse();
        },
      );
  @Route.delete('/employee')
  Future<Response> deleteEmployees(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          return jsonResponse();
        },
      );
  @Route('PATCH', '/changePermission')
  Future<Response> changeEmployePermission(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          return jsonResponse();
        },
      );

  // @Route.get('/products/<bizId>')
//   Future<Response> getShopProducts(Request request, String bizId) =>
//       handleRequestWithPermission(
//         request,
//         permission: () {
//           if (!request.isAuthenticated) {
//             throw unAuthorizedException;
//           }
//         },
//         endpoint: () async {
//           final offset = request.url.queryParameters['offset'] == null
//               ? 0
//               : int.parse(request.url.queryParameters['offset']!);
//           final limit = request.url.queryParameters['limit'] == null
//               ? null
//               : int.parse(request.url.queryParameters['limit']!);
//           final search = request.url.queryParameters['search'];

//           if (search == null) {
//             final products = await ProductDb.filter(
//               where: (where) =>
//                   where.businessId.equals(int.parse(bizId)) &
//                   where.business.ownerId.equals(request.contextUser?.id ?? 0),
//               offset: offset,
//               limit: limit,
//             );
//             return jsonResponse(body: products.map((e) => e.toJson()));
//           } else {
//             final sql = '''
// SELECT * from products where "name" like '%$search%' or "productUId" like '%$search%' offset $offset  limit $limit'
// ''';

//             final result = await Database.execute(sql);

//             final products = ProductDb.fromResult(result);

//             return jsonResponse(body: products.map((e) => e.toJson()));
//           }
//         },
//       );

  @Route.get('/activities/<shopId>')
  Future<Response> getActivities(Request request, String shopId) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          final activities = await BusinessAcitivityDb.filter(
            where: (where) => where.id.equals(1),
          );
          return jsonResponse(body: activities.map((e) => e.toJson()));
        },
      );
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
              FieldValidator<UploadedFile>(name: 'image'),
              FieldValidator<String>(name: 'productUId', isRequired: true),
              FieldValidator<double>(name: 'costPrice', isRequired: true),
              FieldValidator<double>(name: 'sellingPrice', isRequired: true),
              FieldValidator<double>(name: 'quantity', isRequired: true),
              FieldValidator<int>(name: 'bizId', isRequired: true),
              FieldValidator<int>(name: 'catagoryId'),
              FieldValidator<int>(name: 'brandId'),
              FieldValidator<int>(name: 'unitId'),
              FieldValidator<String>(name: 'expireDate'),
              FieldValidator<String>(name: 'manDate'),
              FieldValidator<String>(name: 'desc'),
            ],
          );

          final product = await ProductDb.create(
            productUId: data['productUId'] as String,
            name: data['name'] as String,
            costPrice: data['costPrice'] as double,
            sellingPrice: data['costPrice'] as double,
            quantity: data['quantity'] as double,
            businessId: data['bizId'] as int,
            catagoryId: data['catagoryId'] as int?,
            brandId: data['brandId'] as int?,
            unit: data['unit'] as String?,
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
          final search = request.url.queryParameters['search'];

          if (search == null) {
            final products = await ProductDb.filter(
              where: (where) =>
                  where.businessId.equals(int.parse(bizId)) &
                  where.business.ownerId.equals(request.contextUser?.id ?? 0),
              offset: offset,
              limit: limit,
            );
            return jsonResponse(body: products.map((e) => e.toJson()).toList());
          } else {
            final sql = '''
SELECT "product".* from "product" 
join "business" on "business"."businessId"="product"."businessId" where "business"."businessId"='$bizId' and ("product"."name" ilike '%$search%' or "product"."productUId" ilike '%$search%') offset $offset  limit $limit
''';
            logger.f(sql);
            final result = await Database.execute(sql);

            final products = ProductDb.fromResult(result);

            return jsonResponse(body: products.map((e) => e.toJson()).toList());
          }
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

          await product.delete();

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
            product.unit = data['unit'] as String?;
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

  @Route.get('/catagories')
  Future<Response> getCatagories(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          final catagories = await CatagoryDb.filter(where: (where) => null);
          return jsonResponse(body: catagories.map((e) => e.toJson()).toList());
        },
      );
  @Route.get('/brands')
  Future<Response> getBrands(Request request) => handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          final brands = await BrandDb.filter(where: (where) => null);
          return jsonResponse(body: brands.map((e) => e.toJson()).toList());
        },
      );
  @Route.get('/units')
  Future<Response> getUnits(Request request) => handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          final units = await UnitDb.filter(where: (where) => null);
          return jsonResponse(body: units.map((e) => e.toJson()).toList());
        },
      );
}
