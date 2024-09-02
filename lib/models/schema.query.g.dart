part of 'schema.dart';

class FileTbQuery {
  FileTbQuery();
  factory FileTbQuery.referenced({required List<Join> joins}) =>
      FileTbQuery().._joins.addAll(joins);
  static const table = 'filetb';
  NumberColumn get id =>
      NumberColumn(column: 'filetbId', offtable: 'filetb', depends: _joins);
  TextColumn get url =>
      TextColumn(column: 'url', offtable: 'filetb', depends: _joins);
  TextColumn get isAbsolute =>
      TextColumn(column: 'isAbsolute', offtable: 'filetb', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>['filetbId', 'url', 'isAbsolute'];
}

class UserQuery {
  UserQuery();
  factory UserQuery.referenced({required List<Join> joins}) =>
      UserQuery().._joins.addAll(joins);
  static const table = 'user';
  NumberColumn get id =>
      NumberColumn(column: 'userId', offtable: 'user', depends: _joins);
  TextColumn get firstName =>
      TextColumn(column: 'firstName', offtable: 'user', depends: _joins);
  TextColumn get lastName =>
      TextColumn(column: 'lastName', offtable: 'user', depends: _joins);
  TextColumn get phoneNumber =>
      TextColumn(column: 'phoneNumber', offtable: 'user', depends: _joins);
  TextColumn get email =>
      TextColumn(column: 'email', offtable: 'user', depends: _joins);
  TextColumn get createdAt =>
      TextColumn(column: 'createdAt', offtable: 'user', depends: _joins);
  TextColumn get updatedAt =>
      TextColumn(column: 'updatedAt', offtable: 'user', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'userId',
        'firstName',
        'lastName',
        'phoneNumber',
        'email',
        'createdAt',
        'updatedAt',
      ];
}

class PasswordQuery {
  PasswordQuery();
  factory PasswordQuery.referenced({required List<Join> joins}) =>
      PasswordQuery().._joins.addAll(joins);
  static const table = 'password';
  NumberColumn get id =>
      NumberColumn(column: 'passwordId', offtable: 'password', depends: _joins);
  TextColumn get password =>
      TextColumn(column: 'password', offtable: 'password', depends: _joins);
  TextColumn get emailOtp =>
      TextColumn(column: 'emailOtp', offtable: 'password', depends: _joins);
  TextColumn get phoneOtp =>
      TextColumn(column: 'phoneOtp', offtable: 'password', depends: _joins);
  TextColumn get isEmailVerified => TextColumn(
        column: 'isEmailVerified',
        offtable: 'password',
        depends: _joins,
      );
  TextColumn get isPhoneVerified => TextColumn(
        column: 'isPhoneVerified',
        offtable: 'password',
        depends: _joins,
      );
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId =>
      NumberColumn(column: 'userId', offtable: 'password', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'passwordId',
        'password',
        'emailOtp',
        'phoneOtp',
        'isEmailVerified',
        'isPhoneVerified',
        'userId',
      ];
}

class EmailChangeRequestQuery {
  EmailChangeRequestQuery();
  factory EmailChangeRequestQuery.referenced({required List<Join> joins}) =>
      EmailChangeRequestQuery().._joins.addAll(joins);
  static const table = 'emailchangerequest';
  NumberColumn get id => NumberColumn(
        column: 'emailchangerequestId',
        offtable: 'emailchangerequest',
        depends: _joins,
      );
  TextColumn get newEmail => TextColumn(
        column: 'newEmail',
        offtable: 'emailchangerequest',
        depends: _joins,
      );
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId => NumberColumn(
        column: 'userId',
        offtable: 'emailchangerequest',
        depends: _joins,
      );
  TextColumn get createdAt => TextColumn(
        column: 'createdAt',
        offtable: 'emailchangerequest',
        depends: _joins,
      );
  TextColumn get token => TextColumn(
        column: 'token',
        offtable: 'emailchangerequest',
        depends: _joins,
      );
  TextColumn get expires_at => TextColumn(
        column: 'expires_at',
        offtable: 'emailchangerequest',
        depends: _joins,
      );
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'emailchangerequestId',
        'newEmail',
        'userId',
        'createdAt',
        'token',
        'expires_at',
      ];
}

class PhoneChangeRequestQuery {
  PhoneChangeRequestQuery();
  factory PhoneChangeRequestQuery.referenced({required List<Join> joins}) =>
      PhoneChangeRequestQuery().._joins.addAll(joins);
  static const table = 'phonechangerequest';
  NumberColumn get id => NumberColumn(
        column: 'phonechangerequestId',
        offtable: 'phonechangerequest',
        depends: _joins,
      );
  TextColumn get newPhone => TextColumn(
        column: 'newPhone',
        offtable: 'phonechangerequest',
        depends: _joins,
      );
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId => NumberColumn(
        column: 'userId',
        offtable: 'phonechangerequest',
        depends: _joins,
      );
  TextColumn get token => TextColumn(
        column: 'token',
        offtable: 'phonechangerequest',
        depends: _joins,
      );
  TextColumn get createdAt => TextColumn(
        column: 'createdAt',
        offtable: 'phonechangerequest',
        depends: _joins,
      );
  TextColumn get expires_at => TextColumn(
        column: 'expires_at',
        offtable: 'phonechangerequest',
        depends: _joins,
      );
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'phonechangerequestId',
        'newPhone',
        'userId',
        'token',
        'createdAt',
        'expires_at',
      ];
}

class UserInterestAndInteractionQuery {
  UserInterestAndInteractionQuery();
  factory UserInterestAndInteractionQuery.referenced({
    required List<Join> joins,
  }) =>
      UserInterestAndInteractionQuery().._joins.addAll(joins);
  static const table = 'userinterestandinteraction';
  NumberColumn get id => NumberColumn(
        column: 'userinterestandinteractionId',
        offtable: 'userinterestandinteraction',
        depends: _joins,
      );
  CatagoryQuery get catagory => CatagoryQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'catagory', onn: 'catagoryId', from: table),
        ],
      );
  NumberColumn get catagoryId => NumberColumn(
        column: 'catagoryId',
        offtable: 'userinterestandinteraction',
        depends: _joins,
      );
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId => NumberColumn(
        column: 'userId',
        offtable: 'userinterestandinteraction',
        depends: _joins,
      );
  final _joins = <Join>[];
  static List<String> get columns =>
      <String>['userinterestandinteractionId', 'catagoryId', 'userId'];
}

class CatagoryQuery {
  CatagoryQuery();
  factory CatagoryQuery.referenced({required List<Join> joins}) =>
      CatagoryQuery().._joins.addAll(joins);
  static const table = 'catagory';
  NumberColumn get id =>
      NumberColumn(column: 'catagoryId', offtable: 'catagory', depends: _joins);
  TextColumn get name =>
      TextColumn(column: 'name', offtable: 'catagory', depends: _joins);
  TextColumn get desc =>
      TextColumn(column: 'desc', offtable: 'catagory', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>['catagoryId', 'name', 'desc'];
}

class BrandQuery {
  BrandQuery();
  factory BrandQuery.referenced({required List<Join> joins}) =>
      BrandQuery().._joins.addAll(joins);
  static const table = 'brand';
  NumberColumn get id =>
      NumberColumn(column: 'brandId', offtable: 'brand', depends: _joins);
  TextColumn get name =>
      TextColumn(column: 'name', offtable: 'brand', depends: _joins);
  CatagoryQuery get catagory => CatagoryQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'catagory', onn: 'catagoryId', from: table),
        ],
      );
  NumberColumn get catagoryId =>
      NumberColumn(column: 'catagoryId', offtable: 'brand', depends: _joins);
  TextColumn get desc =>
      TextColumn(column: 'desc', offtable: 'brand', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns =>
      <String>['brandId', 'name', 'catagoryId', 'desc'];
}

class UnitQuery {
  UnitQuery();
  factory UnitQuery.referenced({required List<Join> joins}) =>
      UnitQuery().._joins.addAll(joins);
  static const table = 'unit';
  NumberColumn get id =>
      NumberColumn(column: 'unitId', offtable: 'unit', depends: _joins);
  TextColumn get name =>
      TextColumn(column: 'name', offtable: 'unit', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>['unitId', 'name'];
}

class AddressQuery {
  AddressQuery();
  factory AddressQuery.referenced({required List<Join> joins}) =>
      AddressQuery().._joins.addAll(joins);
  static const table = 'address';
  NumberColumn get id =>
      NumberColumn(column: 'addressId', offtable: 'address', depends: _joins);
  NumberColumn get lat =>
      NumberColumn(column: 'lat', offtable: 'address', depends: _joins);
  NumberColumn get lng =>
      NumberColumn(column: 'lng', offtable: 'address', depends: _joins);
  TextColumn get plusCode =>
      TextColumn(column: 'plusCode', offtable: 'address', depends: _joins);
  TextColumn get sublocality =>
      TextColumn(column: 'sublocality', offtable: 'address', depends: _joins);
  TextColumn get locality =>
      TextColumn(column: 'locality', offtable: 'address', depends: _joins);
  TextColumn get admin1 =>
      TextColumn(column: 'admin1', offtable: 'address', depends: _joins);
  TextColumn get admin2 =>
      TextColumn(column: 'admin2', offtable: 'address', depends: _joins);
  TextColumn get country =>
      TextColumn(column: 'country', offtable: 'address', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'addressId',
        'lat',
        'lng',
        'plusCode',
        'sublocality',
        'locality',
        'admin1',
        'admin2',
        'country',
      ];
}

class BusinessQuery {
  BusinessQuery();
  factory BusinessQuery.referenced({required List<Join> joins}) =>
      BusinessQuery().._joins.addAll(joins);
  static const table = 'business';
  NumberColumn get id =>
      NumberColumn(column: 'businessId', offtable: 'business', depends: _joins);
  TextColumn get name =>
      TextColumn(column: 'name', offtable: 'business', depends: _joins);
  UserQuery get owner => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'ownerId', from: table),
        ],
      );
  NumberColumn get ownerId =>
      NumberColumn(column: 'ownerId', offtable: 'business', depends: _joins);
  AddressQuery get address => AddressQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'address', onn: 'addressId', from: table),
        ],
      );
  NumberColumn get addressId =>
      NumberColumn(column: 'addressId', offtable: 'business', depends: _joins);
  CatagoryQuery get catagory => CatagoryQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'catagory', onn: 'catagoryId', from: table),
        ],
      );
  NumberColumn get catagoryId =>
      NumberColumn(column: 'catagoryId', offtable: 'business', depends: _joins);
  TextColumn get logo =>
      TextColumn(column: 'logo', offtable: 'business', depends: _joins);
  TextColumn get bgImage =>
      TextColumn(column: 'bgImage', offtable: 'business', depends: _joins);
  TextColumn get createdAt =>
      TextColumn(column: 'createdAt', offtable: 'business', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'businessId',
        'name',
        'ownerId',
        'addressId',
        'catagoryId',
        'logo',
        'bgImage',
        'createdAt',
      ];
}

class BusinessPrefrencesQuery {
  BusinessPrefrencesQuery();
  factory BusinessPrefrencesQuery.referenced({required List<Join> joins}) =>
      BusinessPrefrencesQuery().._joins.addAll(joins);
  static const table = 'businessprefrences';
  NumberColumn get id => NumberColumn(
        column: 'businessprefrencesId',
        offtable: 'businessprefrences',
        depends: _joins,
      );
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId => NumberColumn(
        column: 'businessId',
        offtable: 'businessprefrences',
        depends: _joins,
      );
  TextColumn get isAvailableOnline => TextColumn(
        column: 'isAvailableOnline',
        offtable: 'businessprefrences',
        depends: _joins,
      );
  TextColumn get notifyNewProduct => TextColumn(
        column: 'notifyNewProduct',
        offtable: 'businessprefrences',
        depends: _joins,
      );
  TextColumn get receiveOrder => TextColumn(
        column: 'receiveOrder',
        offtable: 'businessprefrences',
        depends: _joins,
      );
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'businessprefrencesId',
        'businessId',
        'isAvailableOnline',
        'notifyNewProduct',
        'receiveOrder',
      ];
}

class BusinessAcitivityQuery {
  BusinessAcitivityQuery();
  factory BusinessAcitivityQuery.referenced({required List<Join> joins}) =>
      BusinessAcitivityQuery().._joins.addAll(joins);
  static const table = 'businessacitivity';
  NumberColumn get id => NumberColumn(
        column: 'businessacitivityId',
        offtable: 'businessacitivity',
        depends: _joins,
      );
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId => NumberColumn(
        column: 'businessId',
        offtable: 'businessacitivity',
        depends: _joins,
      );
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId => NumberColumn(
        column: 'userId',
        offtable: 'businessacitivity',
        depends: _joins,
      );
  TextColumn get action => TextColumn(
        column: 'action',
        offtable: 'businessacitivity',
        depends: _joins,
      );
  final _joins = <Join>[];
  static List<String> get columns =>
      <String>['businessacitivityId', 'businessId', 'userId', 'action'];
}

class BusinessReviewQuery {
  BusinessReviewQuery();
  factory BusinessReviewQuery.referenced({required List<Join> joins}) =>
      BusinessReviewQuery().._joins.addAll(joins);
  static const table = 'businessreview';
  NumberColumn get id => NumberColumn(
        column: 'businessreviewId',
        offtable: 'businessreview',
        depends: _joins,
      );
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId => NumberColumn(
        column: 'userId',
        offtable: 'businessreview',
        depends: _joins,
      );
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId => NumberColumn(
        column: 'businessId',
        offtable: 'businessreview',
        depends: _joins,
      );
  final _joins = <Join>[];
  static List<String> get columns =>
      <String>['businessreviewId', 'userId', 'businessId'];
}

class BusinessEmployeQuery {
  BusinessEmployeQuery();
  factory BusinessEmployeQuery.referenced({required List<Join> joins}) =>
      BusinessEmployeQuery().._joins.addAll(joins);
  static const table = 'businessemploye';
  NumberColumn get id => NumberColumn(
        column: 'businessemployeId',
        offtable: 'businessemploye',
        depends: _joins,
      );
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId => NumberColumn(
        column: 'userId',
        offtable: 'businessemploye',
        depends: _joins,
      );
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId => NumberColumn(
        column: 'businessId',
        offtable: 'businessemploye',
        depends: _joins,
      );
  TextColumn get createdAt => TextColumn(
        column: 'createdAt',
        offtable: 'businessemploye',
        depends: _joins,
      );
  final _joins = <Join>[];
  static List<String> get columns =>
      <String>['businessemployeId', 'userId', 'businessId', 'createdAt'];
}

class BusinessPermissionQuery {
  BusinessPermissionQuery();
  factory BusinessPermissionQuery.referenced({required List<Join> joins}) =>
      BusinessPermissionQuery().._joins.addAll(joins);
  static const table = 'businesspermission';
  NumberColumn get id => NumberColumn(
        column: 'businesspermissionId',
        offtable: 'businesspermission',
        depends: _joins,
      );
  TextColumn get name => TextColumn(
        column: 'name',
        offtable: 'businesspermission',
        depends: _joins,
      );
  final _joins = <Join>[];
  static List<String> get columns => <String>['businesspermissionId', 'name'];
}

class HasBusinessPermissionQuery {
  HasBusinessPermissionQuery();
  factory HasBusinessPermissionQuery.referenced({required List<Join> joins}) =>
      HasBusinessPermissionQuery().._joins.addAll(joins);
  static const table = 'hasbusinesspermission';
  NumberColumn get id => NumberColumn(
        column: 'hasbusinesspermissionId',
        offtable: 'hasbusinesspermission',
        depends: _joins,
      );
  BusinessEmployeQuery get employee => BusinessEmployeQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'businessemploye', onn: 'employeeId', from: table),
        ],
      );
  NumberColumn get employeeId => NumberColumn(
        column: 'employeeId',
        offtable: 'hasbusinesspermission',
        depends: _joins,
      );
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId => NumberColumn(
        column: 'businessId',
        offtable: 'hasbusinesspermission',
        depends: _joins,
      );
  BusinessPermissionQuery get permission => BusinessPermissionQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'businesspermission', onn: 'permissionId', from: table),
        ],
      );
  NumberColumn get permissionId => NumberColumn(
        column: 'permissionId',
        offtable: 'hasbusinesspermission',
        depends: _joins,
      );
  TextColumn get createdAt => TextColumn(
        column: 'createdAt',
        offtable: 'hasbusinesspermission',
        depends: _joins,
      );
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'hasbusinesspermissionId',
        'employeeId',
        'businessId',
        'permissionId',
        'createdAt',
      ];
}

class ProductQuery {
  ProductQuery();
  factory ProductQuery.referenced({required List<Join> joins}) =>
      ProductQuery().._joins.addAll(joins);
  static const table = 'product';
  NumberColumn get id =>
      NumberColumn(column: 'productId', offtable: 'product', depends: _joins);
  TextColumn get name =>
      TextColumn(column: 'name', offtable: 'product', depends: _joins);
  TextColumn get productUId =>
      TextColumn(column: 'productUId', offtable: 'product', depends: _joins);
  NumberColumn get costPrice =>
      NumberColumn(column: 'costPrice', offtable: 'product', depends: _joins);
  NumberColumn get sellingPrice => NumberColumn(
        column: 'sellingPrice',
        offtable: 'product',
        depends: _joins,
      );
  NumberColumn get quantity =>
      NumberColumn(column: 'quantity', offtable: 'product', depends: _joins);
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId =>
      NumberColumn(column: 'businessId', offtable: 'product', depends: _joins);
  BrandQuery get brand => BrandQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'brand', onn: 'brandId', from: table),
        ],
      );
  NumberColumn get brandId =>
      NumberColumn(column: 'brandId', offtable: 'product', depends: _joins);
  CatagoryQuery get catagory => CatagoryQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'catagory', onn: 'catagoryId', from: table),
        ],
      );
  NumberColumn get catagoryId =>
      NumberColumn(column: 'catagoryId', offtable: 'product', depends: _joins);
  UnitQuery get unit => UnitQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'unit', onn: 'unitId', from: table),
        ],
      );
  NumberColumn get unitId =>
      NumberColumn(column: 'unitId', offtable: 'product', depends: _joins);
  TextColumn get expireDate =>
      TextColumn(column: 'expireDate', offtable: 'product', depends: _joins);
  TextColumn get manDate =>
      TextColumn(column: 'manDate', offtable: 'product', depends: _joins);
  TextColumn get desc =>
      TextColumn(column: 'desc', offtable: 'product', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'productId',
        'name',
        'productUId',
        'costPrice',
        'sellingPrice',
        'quantity',
        'businessId',
        'brandId',
        'catagoryId',
        'unitId',
        'expireDate',
        'manDate',
        'desc',
      ];
}

class LikeQuery {
  LikeQuery();
  factory LikeQuery.referenced({required List<Join> joins}) =>
      LikeQuery().._joins.addAll(joins);
  static const table = 'like';
  NumberColumn get id =>
      NumberColumn(column: 'likeId', offtable: 'like', depends: _joins);
  ProductQuery get product => ProductQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'product', onn: 'productId', from: table),
        ],
      );
  NumberColumn get productId =>
      NumberColumn(column: 'productId', offtable: 'like', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>['likeId', 'productId'];
}

class FollowQuery {
  FollowQuery();
  factory FollowQuery.referenced({required List<Join> joins}) =>
      FollowQuery().._joins.addAll(joins);
  static const table = 'follow';
  NumberColumn get id =>
      NumberColumn(column: 'followId', offtable: 'follow', depends: _joins);
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId =>
      NumberColumn(column: 'businessId', offtable: 'follow', depends: _joins);
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId =>
      NumberColumn(column: 'userId', offtable: 'follow', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns =>
      <String>['followId', 'businessId', 'userId'];
}

class OrderQuery {
  OrderQuery();
  factory OrderQuery.referenced({required List<Join> joins}) =>
      OrderQuery().._joins.addAll(joins);
  static const table = 'order';
  NumberColumn get id =>
      NumberColumn(column: 'orderId', offtable: 'order', depends: _joins);
  TextColumn get status =>
      TextColumn(column: 'status', offtable: 'order', depends: _joins);
  TextColumn get type =>
      TextColumn(column: 'type', offtable: 'order', depends: _joins);
  TextColumn get msg =>
      TextColumn(column: 'msg', offtable: 'order', depends: _joins);
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId =>
      NumberColumn(column: 'businessId', offtable: 'order', depends: _joins);
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId =>
      NumberColumn(column: 'userId', offtable: 'order', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns =>
      <String>['orderId', 'status', 'type', 'msg', 'businessId', 'userId'];
}

class ItemsQuery {
  ItemsQuery();
  factory ItemsQuery.referenced({required List<Join> joins}) =>
      ItemsQuery().._joins.addAll(joins);
  static const table = 'items';
  NumberColumn get id =>
      NumberColumn(column: 'itemsId', offtable: 'items', depends: _joins);
  ProductQuery get product => ProductQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'product', onn: 'productId', from: table),
        ],
      );
  NumberColumn get productId =>
      NumberColumn(column: 'productId', offtable: 'items', depends: _joins);
  NumberColumn get quantity =>
      NumberColumn(column: 'quantity', offtable: 'items', depends: _joins);
  OrderQuery get order => OrderQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'order', onn: 'orderId', from: table),
        ],
      );
  NumberColumn get orderId =>
      NumberColumn(column: 'orderId', offtable: 'items', depends: _joins);
  TextColumn get createdAt =>
      TextColumn(column: 'createdAt', offtable: 'items', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns =>
      <String>['itemsId', 'productId', 'quantity', 'orderId', 'createdAt'];
}

class NotificationQuery {
  NotificationQuery();
  factory NotificationQuery.referenced({required List<Join> joins}) =>
      NotificationQuery().._joins.addAll(joins);
  static const table = 'notification';
  NumberColumn get id => NumberColumn(
        column: 'notificationId',
        offtable: 'notification',
        depends: _joins,
      );
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId =>
      NumberColumn(column: 'userId', offtable: 'notification', depends: _joins);
  TextColumn get timestamp => TextColumn(
        column: 'timestamp',
        offtable: 'notification',
        depends: _joins,
      );
  TextColumn get title =>
      TextColumn(column: 'title', offtable: 'notification', depends: _joins);
  TextColumn get content =>
      TextColumn(column: 'content', offtable: 'notification', depends: _joins);
  TextColumn get type =>
      TextColumn(column: 'type', offtable: 'notification', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'notificationId',
        'userId',
        'timestamp',
        'title',
        'content',
        'type',
      ];
}

class GiftCardQuery {
  GiftCardQuery();
  factory GiftCardQuery.referenced({required List<Join> joins}) =>
      GiftCardQuery().._joins.addAll(joins);
  static const table = 'giftcard';
  NumberColumn get id =>
      NumberColumn(column: 'giftcardId', offtable: 'giftcard', depends: _joins);
  TextColumn get couponId =>
      TextColumn(column: 'couponId', offtable: 'giftcard', depends: _joins);
  UserQuery get owner => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'ownerId', from: table),
        ],
      );
  NumberColumn get ownerId =>
      NumberColumn(column: 'ownerId', offtable: 'giftcard', depends: _joins);
  UserQuery get createdBy => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'createdById', from: table),
        ],
      );
  NumberColumn get createdbyId => NumberColumn(
        column: 'createdById',
        offtable: 'giftcard',
        depends: _joins,
      );
  ProductQuery get product => ProductQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'product', onn: 'productId', from: table),
        ],
      );
  NumberColumn get productId =>
      NumberColumn(column: 'productId', offtable: 'giftcard', depends: _joins);
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId =>
      NumberColumn(column: 'businessId', offtable: 'giftcard', depends: _joins);
  TextColumn get redeemed =>
      TextColumn(column: 'redeemed', offtable: 'giftcard', depends: _joins);
  TextColumn get expireDate =>
      TextColumn(column: 'expireDate', offtable: 'giftcard', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'giftcardId',
        'couponId',
        'ownerId',
        'createdbyId',
        'productId',
        'businessId',
        'redeemed',
        'expireDate',
      ];
}

class BlockedQuery {
  BlockedQuery();
  factory BlockedQuery.referenced({required List<Join> joins}) =>
      BlockedQuery().._joins.addAll(joins);
  static const table = 'blocked';
  NumberColumn get id =>
      NumberColumn(column: 'blockedId', offtable: 'blocked', depends: _joins);
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId =>
      NumberColumn(column: 'userId', offtable: 'blocked', depends: _joins);
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId =>
      NumberColumn(column: 'businessId', offtable: 'blocked', depends: _joins);
  ProductQuery get product => ProductQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'product', onn: 'productId', from: table),
        ],
      );
  NumberColumn get productId =>
      NumberColumn(column: 'productId', offtable: 'blocked', depends: _joins);
  TextColumn get endDate =>
      TextColumn(column: 'endDate', offtable: 'blocked', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns =>
      <String>['blockedId', 'userId', 'businessId', 'productId', 'endDate'];
}

class PolicyQuery {
  PolicyQuery();
  factory PolicyQuery.referenced({required List<Join> joins}) =>
      PolicyQuery().._joins.addAll(joins);
  static const table = 'policy';
  NumberColumn get id =>
      NumberColumn(column: 'policyId', offtable: 'policy', depends: _joins);
  NumberColumn get number =>
      NumberColumn(column: 'number', offtable: 'policy', depends: _joins);
  TextColumn get detail =>
      TextColumn(column: 'detail', offtable: 'policy', depends: _joins);
  TextColumn get createdAt =>
      TextColumn(column: 'createdAt', offtable: 'policy', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns =>
      <String>['policyId', 'number', 'detail', 'createdAt'];
}

class ReportQuery {
  ReportQuery();
  factory ReportQuery.referenced({required List<Join> joins}) =>
      ReportQuery().._joins.addAll(joins);
  static const table = 'report';
  NumberColumn get id =>
      NumberColumn(column: 'reportId', offtable: 'report', depends: _joins);
  PolicyQuery get policy => PolicyQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'policy', onn: 'policyId', from: table),
        ],
      );
  NumberColumn get policyId =>
      NumberColumn(column: 'policyId', offtable: 'report', depends: _joins);
  BusinessQuery get business => BusinessQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'business', onn: 'businessId', from: table),
        ],
      );
  NumberColumn get businessId =>
      NumberColumn(column: 'businessId', offtable: 'report', depends: _joins);
  UserQuery get user => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'userId', from: table),
        ],
      );
  NumberColumn get userId =>
      NumberColumn(column: 'userId', offtable: 'report', depends: _joins);
  UserQuery get violator => UserQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'user', onn: 'violatorId', from: table),
        ],
      );
  NumberColumn get violatorId =>
      NumberColumn(column: 'violatorId', offtable: 'report', depends: _joins);
  ProductQuery get product => ProductQuery.referenced(
        joins: [
          ..._joins,
          Join(table: 'product', onn: 'productId', from: table),
        ],
      );
  NumberColumn get productId =>
      NumberColumn(column: 'productId', offtable: 'report', depends: _joins);
  TextColumn get desc =>
      TextColumn(column: 'desc', offtable: 'report', depends: _joins);
  final _joins = <Join>[];
  static List<String> get columns => <String>[
        'reportId',
        'policyId',
        'businessId',
        'userId',
        'violatorId',
        'productId',
        'desc',
      ];
}
