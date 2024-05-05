import 'dart:io';

import 'package:bita_markets/models/schema.dart';
import 'package:bita_markets/utils/function/request_handler_wrapper.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:d_orm/database/database.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
part 'users_api.g.dart';

class UsersApi {
  Router get router => _$UsersApiRouter(this);
  @Route.put('/<id>')
  Future<Response> updateThroughPutAUser(Request request, String id) =>
      updateUser(request, id);

  @Route.delete('/me')
  Future<Response> delAUser(Request request) => handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          // TODO(nuradic): schedule the deletion process on +14 days
          return jsonResponse();
        },
      );

  @Route('PATCH', '/<id>')
  Future<Response> updateUser(Request request, String id) async {
    final user = await UserDb.get(where: (t) => t.id.equals(int.parse(id)));

    if (user == null) {
      return jsonResponse(
        body: {'detail': 'user not found'},
        statusCode: HttpStatus.notFound,
      );
    }

    final data = await form(
      request,
      fields: [
        FieldValidator<String?>(
          name: 'firstName',
          validator: (value) {
            if (value != null) return null;
            if (value!.length > 25) {
              return 'firstName is to long';
            }
            return null;
          },
        ),
        FieldValidator<String?>(
          name: 'lastName',
          validator: (value) {
            if (value != null) return null;
            if (value!.length > 25) {
              return 'lastName is to long';
            }
            return null;
          },
        ),
        FieldValidator<String>(
          name: 'password',
          validator: (value) {
            if (value.length < 6) {
              return 'Password is to short';
            }
            return null;
          },
        ),
      ],
    );
    user
      ..firstName = (data['firstName'] as String?) ?? user.firstName
      ..lastName = (data['lastName'] as String?) ?? user.lastName;
    Password? pass;
    pass =
        await PasswordDb.get(where: (where) => where.userId.equals(user.id!));

    pass ?? await PasswordDb.create(userId: user.id!);

    pass!.password = data['password'] as String;

    await pass.save();

    await user.save();

    return jsonResponse(body: user.toJson());
  }

  @Route.post('/getStartedWithEmail')
  Future<Response> getStartedEmail(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          final data = await form(
            request,
            fields: [
              FieldValidator<String>(
                name: 'email',
                isRequired: true,
                validator: (value) => RegExp(r'.+@.+\..+').hasMatch(value)
                    ? null
                    : 'Incorrect email format',
              ),
            ],
          );
          User? user;

          final email = data['email'] as String;

          user = await UserDb.get(where: (t) => t.email.equals(email));
          user ??= await UserDb.create(email: email);
          var pass =
              await PasswordDb.get(where: (t) => t.userId.equals(user!.id!));

          pass ??= await PasswordDb.create(userId: user.id!);

          final otp = generateSecureRandom();
          pass.emailOtp = otp.toString();

          await pass.save();

          await SendMail.sendOtp(otp.toString(), user);
          return jsonResponse(
            body: {
              'user': user.toJson(),
              'isRegistrationComplete': user.firstName != null,
            },
          );
        },
      );
  @Route.post('/getStartedWithPhone')
  Future<Response> getStartedPhone(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          final data = await form(
            request,
            fields: [
              FieldValidator<String>(
                name: 'phoneNumber',
                isRequired: true,
                validator: (value) => RegExp(r'(7|9)\d{8}').hasMatch(value)
                    ? null
                    : 'Incorrect phone format',
              ),
            ],
          );
          User? user;

          final phoneNumber = data['phoneNumber'] as String;

          user =
              await UserDb.get(where: (t) => t.phoneNumber.equals(phoneNumber));
          user ??= await UserDb.create(phoneNumber: phoneNumber);
          var pass =
              await PasswordDb.get(where: (t) => t.userId.equals(user!.id!));

          pass ??= await PasswordDb.create(userId: user.id!);

          final otp = generateSecureRandom();
          pass.phoneOtp = otp.toString();

          await pass.save();

          await SendSms.sendOtp(otp.toString(), user);
          return jsonResponse(
            body: {
              'user': user.toJson(),
              'isRegistrationComplete': user.firstName != null,
            },
          );
        },
      );
  @Route.get('/me')
  Future<Response> userMe(Request request) => handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          return jsonResponse(body: request.contextUser!.toJson());
        },
      );

  @Route.post('/verifyOtp')
  Future<Response> verifyOtp(Request request) => handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          final data = await form(
            request,
            fields: [
              FieldValidator<int>(
                name: 'otp',
                isRequired: true,
                // parse: int.parse,
                validator: (value) => value > 99999 && value <= 999999
                    ? null
                    : 'otp should be six digit',
              ),
              FieldValidator<String>(
                name: 'otpType',
                isRequired: true,
                validator: (value) => ['email', 'phone'].contains(value)
                    ? null
                    : 'Unknown otpType',
              ),
              FieldValidator<int>(
                name: 'userId',
                // parse: int.parse,
                isRequired: true,
              ),
            ],
          );

          final sql = Sql.named('''
SELECT "user".*,"password".* from "user" join "password" on "user"."userId"="password"."userId" where "user"."userId"= @userId and "password"."${data['otpType']}Otp"=@otp
    ''');
          data.remove('otpType');
          final res = await Database.execute(sql, parameters: data);

          if (res.isEmpty) {
            return jsonResponse(
              statusCode: HttpStatus.notFound,
              body: {'detail': 'User not found'},
            );
          }

          final user = UserDb.fromResult(res).first;
          final pass = PasswordDb.fromResult(res).first;

          data['otpType'] == 'email'
              ? pass.isEmailVerified = true
              : pass.isPhoneVerified = true;

          await pass.save();

          final access = JWTAuth.authenticate(user);

          return jsonResponse(body: {'user': user.toJson(), 'access': access});
        },
      );
  @Route.post('/changeEmail')
  Future<Response> changeEmail(Request request) => handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nuradic): Complete this endpoint
          return jsonResponse();
        },
      );
  @Route.post('/changePhone')
  Future<Response> changePhone(Request request) => handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nuradic): Complete this endpoint
          return jsonResponse();
        },
      );
}

// user.join()=> 
// 
