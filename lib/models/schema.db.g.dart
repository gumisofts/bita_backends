part of 'schema.dart';

extension FileTbDb on FileTb {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'url': url,
      'isAbsolute': isAbsolute,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static FileTb fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return FileTb(
      id: map['filetbId'] as int,
      url: map['url'] as String,
      isAbsolute: map['isAbsolute'] as bool?,
    );
  }

  static Iterable<FileTb> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<FileTb> create({
    required String url,
    bool? isAbsolute,
  }) async {
    final model = FileTb(
      url: url,
      isAbsolute: isAbsolute,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'filetb',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(FileTb filetb) async {
    final q = Query.delete(
      table: 'filetb',
      operation: Operation('filetbId'.safeTk, Operator.eq, filetb.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<FileTb>> filter({
    required Operation? Function(FileTbQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(FileTbQuery());
    final query = Query.select(
      table: FileTbQuery.table,
      columns: FileTbQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<FileTb?> get(
      {required Operation Function(FileTbQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension UserDb on User {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static User fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return User(
      id: map['userId'] as int,
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      email: map['email'] as String?,
      createdAt: map['createdAt'] as DateTime?,
      updatedAt: map['updatedAt'] as DateTime?,
    );
  }

  static Iterable<User> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<User> create({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) async {
    final model = User(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'user',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(User user) async {
    final q = Query.delete(
      table: 'user',
      operation: Operation('userId'.safeTk, Operator.eq, user.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<User>> filter({
    required Operation? Function(UserQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(UserQuery());
    final query = Query.select(
      table: UserQuery.table,
      columns: UserQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<User?> get(
      {required Operation Function(UserQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension PasswordDb on Password {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'password': password,
      'emailOtp': emailOtp,
      'phoneOtp': phoneOtp,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'userId': userId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Password fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Password(
      id: map['passwordId'] as int,
      password: map['password'] as String?,
      emailOtp: map['emailOtp'] as String?,
      phoneOtp: map['phoneOtp'] as String?,
      isEmailVerified: map['isEmailVerified'] as bool?,
      isPhoneVerified: map['isPhoneVerified'] as bool?,
      userId: map['userId'] as int,
    );
  }

  static Iterable<Password> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Password> create({
    required int userId,
    String? password,
    String? emailOtp,
    String? phoneOtp,
    bool? isEmailVerified,
    bool? isPhoneVerified,
  }) async {
    final model = Password(
      password: password,
      emailOtp: emailOtp,
      phoneOtp: phoneOtp,
      isEmailVerified: isEmailVerified,
      isPhoneVerified: isPhoneVerified,
      userId: userId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'password',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Password password) async {
    final q = Query.delete(
      table: 'password',
      operation: Operation('passwordId'.safeTk, Operator.eq, password.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Password>> filter({
    required Operation? Function(PasswordQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(PasswordQuery());
    final query = Query.select(
      table: PasswordQuery.table,
      columns: PasswordQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Password?> get(
      {required Operation Function(PasswordQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension InfoChangeRequestDb on InfoChangeRequest {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'newEmail': newEmail,
      'newPhone': newPhone,
      'createdAt': createdAt?.toIso8601String(),
      'userId': userId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static InfoChangeRequest fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return InfoChangeRequest(
      id: map['infochangerequestId'] as int,
      newEmail: map['newEmail'] as String?,
      newPhone: map['newPhone'] as String?,
      createdAt: map['createdAt'] as DateTime?,
      userId: map['userId'] as int,
    );
  }

  static Iterable<InfoChangeRequest> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<InfoChangeRequest> create({
    required int userId,
    String? newEmail,
    String? newPhone,
    DateTime? createdAt,
  }) async {
    final model = InfoChangeRequest(
      newEmail: newEmail,
      newPhone: newPhone,
      createdAt: createdAt,
      userId: userId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'infochangerequest',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(InfoChangeRequest infochangerequest) async {
    final q = Query.delete(
      table: 'infochangerequest',
      operation: Operation(
          'infochangerequestId'.safeTk, Operator.eq, infochangerequest.id,),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<InfoChangeRequest>> filter({
    required Operation? Function(InfoChangeRequestQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(InfoChangeRequestQuery());
    final query = Query.select(
      table: InfoChangeRequestQuery.table,
      columns: InfoChangeRequestQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<InfoChangeRequest?> get(
      {required Operation Function(InfoChangeRequestQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension UserInterestAndInteractionDb on UserInterestAndInteraction {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'catagoryId': catagoryId,
      'userId': userId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static UserInterestAndInteraction fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return UserInterestAndInteraction(
      id: map['userinterestandinteractionId'] as int,
      catagoryId: map['catagoryId'] as int,
      userId: map['userId'] as int,
    );
  }

  static Iterable<UserInterestAndInteraction> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<UserInterestAndInteraction> create({
    required int catagoryId,
    required int userId,
  }) async {
    final model = UserInterestAndInteraction(
      catagoryId: catagoryId,
      userId: userId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'userinterestandinteraction',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(
      UserInterestAndInteraction userinterestandinteraction,) async {
    final q = Query.delete(
      table: 'userinterestandinteraction',
      operation: Operation('userinterestandinteractionId'.safeTk, Operator.eq,
          userinterestandinteraction.id,),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<UserInterestAndInteraction>> filter({
    required Operation? Function(UserInterestAndInteractionQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(UserInterestAndInteractionQuery());
    final query = Query.select(
      table: UserInterestAndInteractionQuery.table,
      columns: UserInterestAndInteractionQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<UserInterestAndInteraction?> get(
      {required Operation Function(UserInterestAndInteractionQuery)
          where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension CatagoryDb on Catagory {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'name': name,
      'desc': desc,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Catagory fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Catagory(
      id: map['catagoryId'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String?,
    );
  }

  static Iterable<Catagory> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Catagory> create({
    required String name,
    String? desc,
  }) async {
    final model = Catagory(
      name: name,
      desc: desc,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'catagory',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Catagory catagory) async {
    final q = Query.delete(
      table: 'catagory',
      operation: Operation('catagoryId'.safeTk, Operator.eq, catagory.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Catagory>> filter({
    required Operation? Function(CatagoryQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(CatagoryQuery());
    final query = Query.select(
      table: CatagoryQuery.table,
      columns: CatagoryQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Catagory?> get(
      {required Operation Function(CatagoryQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension BrandDb on Brand {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'name': name,
      'desc': desc,
      'catagoryId': catagoryId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Brand fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Brand(
      id: map['brandId'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String?,
      catagoryId: map['catagoryId'] as int?,
    );
  }

  static Iterable<Brand> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Brand> create({
    required String name,
    int? catagoryId,
    String? desc,
  }) async {
    final model = Brand(
      name: name,
      desc: desc,
      catagoryId: catagoryId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'brand',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Brand brand) async {
    final q = Query.delete(
      table: 'brand',
      operation: Operation('brandId'.safeTk, Operator.eq, brand.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Brand>> filter({
    required Operation? Function(BrandQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(BrandQuery());
    final query = Query.select(
      table: BrandQuery.table,
      columns: BrandQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Brand?> get(
      {required Operation Function(BrandQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension UnitDb on Unit {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'name': name,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Unit fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Unit(
      id: map['unitId'] as int,
      name: map['name'] as String,
    );
  }

  static Iterable<Unit> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Unit> create({
    required String name,
  }) async {
    final model = Unit(
      name: name,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'unit',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Unit unit) async {
    final q = Query.delete(
      table: 'unit',
      operation: Operation('unitId'.safeTk, Operator.eq, unit.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Unit>> filter({
    required Operation? Function(UnitQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(UnitQuery());
    final query = Query.select(
      table: UnitQuery.table,
      columns: UnitQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Unit?> get(
      {required Operation Function(UnitQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension AddressDb on Address {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'lat': lat,
      'lng': lng,
      'plusCode': plusCode,
      'sublocality': sublocality,
      'locality': locality,
      'admin1': admin1,
      'admin2': admin2,
      'country': country,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Address fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Address(
      id: map['addressId'] as int,
      lat: map['lat'] as double?,
      lng: map['lng'] as double?,
      plusCode: map['plusCode'] as String?,
      sublocality: map['sublocality'] as String?,
      locality: map['locality'] as String?,
      admin1: map['admin1'] as String?,
      admin2: map['admin2'] as String?,
      country: map['country'] as String?,
    );
  }

  static Iterable<Address> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Address> create({
    double? lat,
    double? lng,
    String? plusCode,
    String? sublocality,
    String? locality,
    String? admin1,
    String? admin2,
    String? country,
  }) async {
    final model = Address(
      lat: lat,
      lng: lng,
      plusCode: plusCode,
      sublocality: sublocality,
      locality: locality,
      admin1: admin1,
      admin2: admin2,
      country: country,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'address',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Address address) async {
    final q = Query.delete(
      table: 'address',
      operation: Operation('addressId'.safeTk, Operator.eq, address.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Address>> filter({
    required Operation? Function(AddressQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(AddressQuery());
    final query = Query.select(
      table: AddressQuery.table,
      columns: AddressQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Address?> get(
      {required Operation Function(AddressQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension BusinessDb on Business {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'name': name,
      'logo': logo,
      'bgImage': bgImage,
      'createdAt': createdAt?.toIso8601String(),
      'ownerId': ownerId,
      'addressId': addressId,
      'catagoryId': catagoryId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Business fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Business(
      id: map['businessId'] as int,
      name: map['name'] as String,
      logo: map['logo'] as String?,
      bgImage: map['bgImage'] as String?,
      createdAt: map['createdAt'] as DateTime?,
      ownerId: map['ownerId'] as int,
      addressId: map['addressId'] as int,
      catagoryId: map['catagoryId'] as int?,
    );
  }

  static Iterable<Business> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Business> create({
    required String name,
    required int ownerId,
    required int addressId,
    int? catagoryId,
    String? logo,
    String? bgImage,
    DateTime? createdAt,
  }) async {
    final model = Business(
      name: name,
      logo: logo,
      bgImage: bgImage,
      createdAt: createdAt,
      ownerId: ownerId,
      addressId: addressId,
      catagoryId: catagoryId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'business',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Business business) async {
    final q = Query.delete(
      table: 'business',
      operation: Operation('businessId'.safeTk, Operator.eq, business.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Business>> filter({
    required Operation? Function(BusinessQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(BusinessQuery());
    final query = Query.select(
      table: BusinessQuery.table,
      columns: BusinessQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Business?> get(
      {required Operation Function(BusinessQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension BusinessPrefrencesDb on BusinessPrefrences {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'isAvailableOnline': isAvailableOnline,
      'notifyNewProduct': notifyNewProduct,
      'receiveOrder': receiveOrder,
      'businessId': businessId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static BusinessPrefrences fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return BusinessPrefrences(
      id: map['businessprefrencesId'] as int,
      isAvailableOnline: map['isAvailableOnline'] as bool?,
      notifyNewProduct: map['notifyNewProduct'] as bool?,
      receiveOrder: map['receiveOrder'] as bool?,
      businessId: map['businessId'] as int?,
    );
  }

  static Iterable<BusinessPrefrences> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<BusinessPrefrences> create({
    int? businessId,
    bool? isAvailableOnline,
    bool? notifyNewProduct,
    bool? receiveOrder,
  }) async {
    final model = BusinessPrefrences(
      isAvailableOnline: isAvailableOnline,
      notifyNewProduct: notifyNewProduct,
      receiveOrder: receiveOrder,
      businessId: businessId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'businessprefrences',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(BusinessPrefrences businessprefrences) async {
    final q = Query.delete(
      table: 'businessprefrences',
      operation: Operation(
          'businessprefrencesId'.safeTk, Operator.eq, businessprefrences.id,),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<BusinessPrefrences>> filter({
    required Operation? Function(BusinessPrefrencesQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(BusinessPrefrencesQuery());
    final query = Query.select(
      table: BusinessPrefrencesQuery.table,
      columns: BusinessPrefrencesQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<BusinessPrefrences?> get(
      {required Operation Function(BusinessPrefrencesQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension BusinessAcitiviyDb on BusinessAcitiviy {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'action': action,
      'userId': userId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static BusinessAcitiviy fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return BusinessAcitiviy(
      id: map['businessacitiviyId'] as int,
      action: map['action'] as String?,
      userId: map['userId'] as int,
    );
  }

  static Iterable<BusinessAcitiviy> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<BusinessAcitiviy> create({
    required int userId,
    String? action,
  }) async {
    final model = BusinessAcitiviy(
      action: action,
      userId: userId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'businessacitiviy',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(BusinessAcitiviy businessacitiviy) async {
    final q = Query.delete(
      table: 'businessacitiviy',
      operation: Operation(
          'businessacitiviyId'.safeTk, Operator.eq, businessacitiviy.id,),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<BusinessAcitiviy>> filter({
    required Operation? Function(BusinessAcitiviyQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(BusinessAcitiviyQuery());
    final query = Query.select(
      table: BusinessAcitiviyQuery.table,
      columns: BusinessAcitiviyQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<BusinessAcitiviy?> get(
      {required Operation Function(BusinessAcitiviyQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension BusinessReviewDb on BusinessReview {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'userId': userId,
      'businessId': businessId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static BusinessReview fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return BusinessReview(
      id: map['businessreviewId'] as int,
      userId: map['userId'] as int,
      businessId: map['businessId'] as int,
    );
  }

  static Iterable<BusinessReview> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<BusinessReview> create({
    required int userId,
    required int businessId,
  }) async {
    final model = BusinessReview(
      userId: userId,
      businessId: businessId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'businessreview',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(BusinessReview businessreview) async {
    final q = Query.delete(
      table: 'businessreview',
      operation:
          Operation('businessreviewId'.safeTk, Operator.eq, businessreview.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<BusinessReview>> filter({
    required Operation? Function(BusinessReviewQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(BusinessReviewQuery());
    final query = Query.select(
      table: BusinessReviewQuery.table,
      columns: BusinessReviewQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<BusinessReview?> get(
      {required Operation Function(BusinessReviewQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension ProductDb on Product {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'name': name,
      'costPrice': costPrice,
      'sellingPrice': sellingPrice,
      'quantity': quantity,
      'expireDate': expireDate?.toIso8601String(),
      'manDate': manDate?.toIso8601String(),
      'desc': desc,
      'businessId': businessId,
      'brandId': brandId,
      'catagoryId': catagoryId,
      'unitId': unitId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Product fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Product(
      id: map['productId'] as int,
      name: map['name'] as String,
      costPrice: map['costPrice'] as double,
      sellingPrice: map['sellingPrice'] as double,
      quantity: map['quantity'] as double,
      expireDate: map['expireDate'] as DateTime?,
      manDate: map['manDate'] as DateTime?,
      desc: map['desc'] as String?,
      businessId: map['businessId'] as int,
      brandId: map['brandId'] as int?,
      catagoryId: map['catagoryId'] as int?,
      unitId: map['unitId'] as int?,
    );
  }

  static Iterable<Product> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Product> create({
    required String name,
    required double costPrice,
    required double sellingPrice,
    required double quantity,
    required int businessId,
    int? brandId,
    int? catagoryId,
    int? unitId,
    DateTime? expireDate,
    DateTime? manDate,
    String? desc,
  }) async {
    final model = Product(
      name: name,
      costPrice: costPrice,
      sellingPrice: sellingPrice,
      quantity: quantity,
      expireDate: expireDate,
      manDate: manDate,
      desc: desc,
      businessId: businessId,
      brandId: brandId,
      catagoryId: catagoryId,
      unitId: unitId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'product',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Product product) async {
    final q = Query.delete(
      table: 'product',
      operation: Operation('productId'.safeTk, Operator.eq, product.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Product>> filter({
    required Operation? Function(ProductQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(ProductQuery());
    final query = Query.select(
      table: ProductQuery.table,
      columns: ProductQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Product?> get(
      {required Operation Function(ProductQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension LikeDb on Like {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'productId': productId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Like fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Like(
      id: map['likeId'] as int,
      productId: map['productId'] as int,
    );
  }

  static Iterable<Like> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Like> create({
    required int productId,
  }) async {
    final model = Like(
      productId: productId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'like',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Like like) async {
    final q = Query.delete(
      table: 'like',
      operation: Operation('likeId'.safeTk, Operator.eq, like.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Like>> filter({
    required Operation? Function(LikeQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(LikeQuery());
    final query = Query.select(
      table: LikeQuery.table,
      columns: LikeQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Like?> get(
      {required Operation Function(LikeQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension FollowDb on Follow {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'businessId': businessId,
      'userId': userId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Follow fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Follow(
      id: map['followId'] as int,
      businessId: map['businessId'] as int,
      userId: map['userId'] as int,
    );
  }

  static Iterable<Follow> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Follow> create({
    required int businessId,
    required int userId,
  }) async {
    final model = Follow(
      businessId: businessId,
      userId: userId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'follow',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Follow follow) async {
    final q = Query.delete(
      table: 'follow',
      operation: Operation('followId'.safeTk, Operator.eq, follow.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Follow>> filter({
    required Operation? Function(FollowQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(FollowQuery());
    final query = Query.select(
      table: FollowQuery.table,
      columns: FollowQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Follow?> get(
      {required Operation Function(FollowQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension OrderDb on Order {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'status': status,
      'type': type,
      'msg': msg,
      'businessId': businessId,
      'userId': userId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Order fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Order(
      id: map['orderId'] as int,
      status: map['status'] as String?,
      type: map['type'] as String?,
      msg: map['msg'] as String?,
      businessId: map['businessId'] as int,
      userId: map['userId'] as int,
    );
  }

  static Iterable<Order> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Order> create({
    required int businessId,
    required int userId,
    String? status,
    String? type,
    String? msg,
  }) async {
    final model = Order(
      status: status,
      type: type,
      msg: msg,
      businessId: businessId,
      userId: userId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'order',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Order order) async {
    final q = Query.delete(
      table: 'order',
      operation: Operation('orderId'.safeTk, Operator.eq, order.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Order>> filter({
    required Operation? Function(OrderQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(OrderQuery());
    final query = Query.select(
      table: OrderQuery.table,
      columns: OrderQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Order?> get(
      {required Operation Function(OrderQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension ItemsDb on Items {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'quantity': quantity,
      'createdAt': createdAt?.toIso8601String(),
      'productId': productId,
      'orderId': orderId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Items fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Items(
      id: map['itemsId'] as int,
      quantity: map['quantity'] as int,
      createdAt: map['createdAt'] as DateTime?,
      productId: map['productId'] as int,
      orderId: map['orderId'] as int?,
    );
  }

  static Iterable<Items> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Items> create({
    required int quantity,
    required int productId,
    int? orderId,
    DateTime? createdAt,
  }) async {
    final model = Items(
      quantity: quantity,
      createdAt: createdAt,
      productId: productId,
      orderId: orderId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'items',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Items items) async {
    final q = Query.delete(
      table: 'items',
      operation: Operation('itemsId'.safeTk, Operator.eq, items.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Items>> filter({
    required Operation? Function(ItemsQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(ItemsQuery());
    final query = Query.select(
      table: ItemsQuery.table,
      columns: ItemsQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Items?> get(
      {required Operation Function(ItemsQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension NotificationDb on Notification {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'title': title,
      'content': content,
      'type': type,
      'userId': userId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Notification fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Notification(
      id: map['notificationId'] as int,
      timestamp: map['timestamp'] as DateTime,
      title: map['title'] as String,
      content: map['content'] as String,
      type: map['type'] as String,
      userId: map['userId'] as int,
    );
  }

  static Iterable<Notification> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Notification> create({
    required DateTime timestamp,
    required String title,
    required String content,
    required String type,
    required int userId,
  }) async {
    final model = Notification(
      timestamp: timestamp,
      title: title,
      content: content,
      type: type,
      userId: userId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'notification',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Notification notification) async {
    final q = Query.delete(
      table: 'notification',
      operation:
          Operation('notificationId'.safeTk, Operator.eq, notification.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Notification>> filter({
    required Operation? Function(NotificationQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(NotificationQuery());
    final query = Query.select(
      table: NotificationQuery.table,
      columns: NotificationQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Notification?> get(
      {required Operation Function(NotificationQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension GiftCardDb on GiftCard {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'couponId': couponId,
      'redeemed': redeemed,
      'expireDate': expireDate?.toIso8601String(),
      'ownerId': ownerId,
      'createdById': createdById,
      'productId': productId,
      'businessId': businessId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static GiftCard fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return GiftCard(
      id: map['giftcardId'] as int,
      couponId: map['couponId'] as String,
      redeemed: map['redeemed'] as bool?,
      expireDate: map['expireDate'] as DateTime?,
      ownerId: map['ownerId'] as int,
      createdById: map['createdById'] as int?,
      productId: map['productId'] as int?,
      businessId: map['businessId'] as int?,
    );
  }

  static Iterable<GiftCard> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<GiftCard> create({
    required String couponId,
    required int ownerId,
    int? createdById,
    int? productId,
    int? businessId,
    bool? redeemed,
    DateTime? expireDate,
  }) async {
    final model = GiftCard(
      couponId: couponId,
      redeemed: redeemed,
      expireDate: expireDate,
      ownerId: ownerId,
      createdById: createdById,
      productId: productId,
      businessId: businessId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'giftcard',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(GiftCard giftcard) async {
    final q = Query.delete(
      table: 'giftcard',
      operation: Operation('giftcardId'.safeTk, Operator.eq, giftcard.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<GiftCard>> filter({
    required Operation? Function(GiftCardQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(GiftCardQuery());
    final query = Query.select(
      table: GiftCardQuery.table,
      columns: GiftCardQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<GiftCard?> get(
      {required Operation Function(GiftCardQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension BlockedDb on Blocked {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'endDate': endDate?.toIso8601String(),
      'userId': userId,
      'businessId': businessId,
      'productId': productId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Blocked fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Blocked(
      id: map['blockedId'] as int,
      endDate: map['endDate'] as DateTime?,
      userId: map['userId'] as int?,
      businessId: map['businessId'] as int?,
      productId: map['productId'] as int?,
    );
  }

  static Iterable<Blocked> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Blocked> create({
    int? userId,
    int? businessId,
    int? productId,
    DateTime? endDate,
  }) async {
    final model = Blocked(
      endDate: endDate,
      userId: userId,
      businessId: businessId,
      productId: productId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'blocked',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Blocked blocked) async {
    final q = Query.delete(
      table: 'blocked',
      operation: Operation('blockedId'.safeTk, Operator.eq, blocked.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Blocked>> filter({
    required Operation? Function(BlockedQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(BlockedQuery());
    final query = Query.select(
      table: BlockedQuery.table,
      columns: BlockedQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Blocked?> get(
      {required Operation Function(BlockedQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension PolicyDb on Policy {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'number': number,
      'detail': detail,
      'createdAt': createdAt.toIso8601String(),
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Policy fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Policy(
      id: map['policyId'] as int,
      createdAt: map['createdAt'] as DateTime,
      number: map['number'] as int?,
      detail: map['detail'] as String?,
    );
  }

  static Iterable<Policy> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Policy> create({
    required DateTime createdAt,
    int? number,
    String? detail,
  }) async {
    final model = Policy(
      number: number,
      detail: detail,
      createdAt: createdAt,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'policy',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Policy policy) async {
    final q = Query.delete(
      table: 'policy',
      operation: Operation('policyId'.safeTk, Operator.eq, policy.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Policy>> filter({
    required Operation? Function(PolicyQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(PolicyQuery());
    final query = Query.select(
      table: PolicyQuery.table,
      columns: PolicyQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Policy?> get(
      {required Operation Function(PolicyQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}

extension ReportDb on Report {
  Map<String, dynamic> toJson(
      {bool excludeNull = false, List<String>? exclude, List<String>? only,}) {
    final json = {
      'id': id,
      'desc': desc,
      'policyId': policyId,
      'businessId': businessId,
      'userId': userId,
      'violatorId': violatorId,
      'productId': productId,
    };
    if (excludeNull) {
      json.removeWhere((key, value) => value == null);
    }
    if (only != null) {
      json.removeWhere((key, value) => !only.contains(key));
    } else if (exclude != null) {
      json.removeWhere((key, value) => exclude.contains(key));
    }
    return json;
  }

  static Report fromRow(ResultRow row) {
    final map = row.toColumnMap();
    return Report(
      id: map['reportId'] as int,
      desc: map['desc'] as String?,
      businessId: map['businessId'] as int,
      userId: map['userId'] as int,
      policyId: map['policyId'] as int?,
      violatorId: map['violatorId'] as int?,
      productId: map['productId'] as int?,
    );
  }

  static Iterable<Report> fromResult(Result result) {
    return result.map(fromRow);
  }

  static Future<Report> create({
    required int businessId, required int userId, int? policyId,
    int? violatorId,
    int? productId,
    String? desc,
  }) async {
    final model = Report(
      desc: desc,
      policyId: policyId,
      businessId: businessId,
      userId: userId,
      violatorId: violatorId,
      productId: productId,
    );
    final data = model.toJson(excludeNull: true);
    final q = Query.insert(
      table: 'report',
      columns: data,
    );
    final res = await Database.execute(q.toString());
    return fromRow(res.first);
  }

  static Future<bool> delete(Report report) async {
    final q = Query.delete(
      table: 'report',
      operation: Operation('reportId'.safeTk, Operator.eq, report.id),
    );
    try {
      await Database.execute(q.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Iterable<Report>> filter({
    required Operation? Function(ReportQuery) where,
    List<String> orderBy = const [],
    int offset = 0,
    int? limit,
    List<Join> joins = const [],
  }) async {
    final tt = where(ReportQuery());
    final query = Query.select(
      table: ReportQuery.table,
      columns: ReportQuery.columns,
      operation: tt,
      offset: offset,
      limit: limit,
      joins: tt == null ? [] : tt.joins,
    );
    final result = await Database.execute(query.toString());
    return fromResult(result);
  }

  static Future<Report?> get(
      {required Operation Function(ReportQuery) where,}) async {
    final res = await filter(where: where);
    if (res.isEmpty) return null;
    return res.first;
  }
}
