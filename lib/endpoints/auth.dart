import 'dart:async';
import 'dart:io';

import 'package:bita_markets/models/schema.dart';
import 'package:bita_markets/utils/function/request_handler_wrapper.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:pg_dorm/pg_dorm.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
part 'auth.g.dart';

class AuthApi {
  Router get router => _$AuthApiRouter(this);

  @Route.post('/get_started_with_email')
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

          if (pass.password == null) {
            final otp = generateSecureRandom();
            pass.emailOtp = otp.toString();

            await pass.save();
            await SendMail.sendOtp(email: user.email!, otp: otp);
          }

          return jsonResponse(
            body: {
              'user': user.toJson(),
              'isRegistrationComplete': user.firstName != null,
              'isPhoneVerified': pass.isPhoneVerified ?? false,
              'isEmailVerified': pass.isEmailVerified ?? false,
              'isPasswordSet': pass.password != null,
            },
          );
        },
      );
  @Route.post('/get_started_with_phone')
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

          if (pass.password == null) {
            final otp = generateSecureRandom();

            pass.phoneOtp = otp.toString();

            unawaited(GeezSMS().sendOTP(phone: user.phoneNumber!, otp: otp));

            await pass.save();
          }

          return jsonResponse(
            body: {
              'user': user.toJson(),
              'isRegistrationComplete': user.firstName != null,
              'isPhoneVerified': pass.isPhoneVerified ?? false,
              'isEmailVerified': pass.isEmailVerified ?? false,
              'isPasswordSet': pass.password != null,
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

  @Route.post('/verify_otp')
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
                isRequired: true,
              ),
            ],
          );

          final sql = Sql.named('''
                    SELECT "user".*,"password".* from "user" 
                    join "password" on "user"."userId"="password"."userId" 
                    where "user"."userId"= @userId and "password"."${data['otpType']}Otp"=@otp''');

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

          return jsonResponse(
            body: {
              'user': {
                ...user.toJson(),
                'isPhoneVerified': pass.isPhoneVerified,
                'isEmailVerified': pass.isEmailVerified,
                'isRegistrationComplete': user.firstName != null,
                'isPasswordSet': pass.password != null,
              },
              'access': access,
            },
          );
        },
      );
  @Route.post('/login')
  Future<Response> loginWithPassword(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          final data = await form(
            request,
            fields: [
              FieldValidator<int>(
                name: 'userId',
                isRequired: true,
              ),
              FieldValidator<String>(
                name: 'password',
                isRequired: true,
              ),
            ],
          );

          final user = await UserDb.get(
            where: (where) => where.id.equals(data['userId'] as int),
          );

          if (user == null) {
            return jsonResponse(
              body: {'detail': 'no user found with given credentials'},
              statusCode: 400,
            );
          }
          final pass = await PasswordDb.get(
            where: (where) => where.user.id.equals(data['userId'] as int),
          );

          if (pass?.password == null) {
            return jsonResponse(
              body: {'detail': 'no user found with given credentials'},
              statusCode: 400,
            );
          }

          if (pass?.password != data['password']) {
            return jsonResponse(
              body: {'detail': 'no user found with given credentials'},
              statusCode: 400,
            );
          }

          final access = JWTAuth.authenticate(user);

          return jsonResponse(
            body: {'access': access, 'user': user.toJson()},
          );
        },
      );

  @Route.post('/validate_password')
  Future<Response> validatePassword(Request request) =>
      handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          final data = await form(
            request,
            fields: [
              FieldValidator<String>(name: 'password'),
            ],
          );
          return jsonResponse(body: data);
        },
      );
  @Route.post('/set_password')
  Future<Response> setPassword(Request request) => handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          final data = await form(
            request,
            fields: [FieldValidator<String>(name: 'password')],
          );

          var pass = await PasswordDb.get(
            where: (where) => where.user.id.equals(request.contextUser!.id!),
          );

          pass ??= await PasswordDb.create(userId: request.contextUser!.id!);

          if (request.contextUser?.firstName == null && pass.password != null) {
            return jsonResponse(
              body: {'detail': 'password already set'},
              statusCode: 400,
            );
          }

          pass.password = data['password'] as String;
          await pass.save();
          return jsonResponse(
            body: {'detail': 'password set succesfully'},
          );
        },
      );
  @Route.post('/change_password')
  Future<Response> changePassword(Request request) =>
      handleRequestWithPermission(
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
              FieldValidator<String>(name: 'new_password', isRequired: true),
              FieldValidator<String>(name: 'old_password', isRequired: true),
            ],
          );

          final pass = await PasswordDb.get(
            where: (where) => where.user.id.equals(request.contextUser!.id!),
          );
          if (data['old_password'] != pass?.password) {
            return jsonResponse(
              body: {'detail': 'wrong old password'},
              statusCode: 400,
            );
          }

          pass?.password = data['new_password'] as String;

          await pass?.save();

          return jsonResponse(body: {'detail': 'Succesfully updated'});
        },
      );
  @Route.post('/change_phone')
  Future<Response> changePhone(Request request) => handleRequestWithPermission(
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
              FieldValidator(name: 'newPhone', isRequired: true),
            ],
          );

          final users = await UserDb.filter(
            where: (where) =>
                where.phoneNumber.equals(data['newPhone'] as String),
          );

          if (users.isNotEmpty) {
            return jsonResponse(
              body: {'detail': 'user with this phone number already exists'},
            );
          }

          final code = generateSecureRandom();

          final change = await PhoneChangeRequestDb.create(
            newPhone: data['newPhone'] as String,
            userId: request.contextUser!.id!,
            token: '$code',
          );

          unawaited(
            GeezSMS()
                .sendOTP(phone: change.newPhone, otp: generateSecureRandom()),
          );

          return jsonResponse(body: change.toJson(exclude: ['token']));
        },
      );
  @Route.post('/change_email')
  Future<Response> changeEmail(Request request) => handleRequestWithPermission(
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
              FieldValidator(name: 'newEmail', isRequired: true),
            ],
          );

          final users = await UserDb.filter(
            where: (where) => where.email.equals(data['newEmail'] as String),
          );

          if (users.isNotEmpty) {
            return jsonResponse(
              body: {'detail': 'user with this email already exists'},
            );
          }

          final code = generateSecureRandom();

          final change = await EmailChangeRequestDb.create(
            newEmail: data['newEmail'] as String,
            userId: request.contextUser!.id!,
            token: '$code',
          );
          await SendMail.sendOtp(email: change.newEmail, otp: code);
          return jsonResponse(body: change.toJson(exclude: ['token']));
        },
      );

  @Route.get('/verify_change_phone/<requestId>/<token>')
  Future<Response> verifyChangePhone(
    Request request,
    String requestId,
    String token,
  ) =>
      handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          final req = await PhoneChangeRequestDb.get(
            where: (where) => where.id.equals(
              int.parse(requestId),
            ),
          );
          if (req == null) {
            return jsonResponse(body: {'detail': 'Not found'}, statusCode: 404);
          }
          if (req.token != token) {
            jsonResponse(
              body: {'detail': 'unable to verify'},
              statusCode: 400,
            );
          }

          request.contextUser!.phoneNumber = req.newPhone;

          await request.contextUser!.save();

          await req.delete();

          return jsonResponse(body: {'detail': 'Phone changed successfully'});
        },
      );
  @Route.get('/verify_change_email/<requestId>/<token>')
  Future<Response> verifyChangeEmail(
    Request request,
    String requestId,
    String token,
  ) =>
      handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          final req = await EmailChangeRequestDb.get(
            where: (where) => where.id.equals(
              int.parse(requestId),
            ),
          );
          if (req == null) {
            return jsonResponse(body: {'detail': 'Not found'}, statusCode: 400);
          }
          if (req.token != token) {
            jsonResponse(
              body: {'detail': 'unable to verify'},
              statusCode: 400,
            );
          }

          request.contextUser!.email = req.newEmail;

          await request.contextUser!.save();

          await req.delete();

          return jsonResponse(body: {'detail': 'Email changed successfully'});
        },
      );
}
