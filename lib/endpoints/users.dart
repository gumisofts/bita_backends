import 'dart:io';

import 'package:bita_markets/models/schema.dart';
import 'package:bita_markets/utils/function/request_handler_wrapper.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
part 'users.g.dart';

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
          // TODO(nurads): schedule the deletion process on +14 days
          return jsonResponse();
        },
      );

  @Route('PATCH', '/<id>')
  Future<Response> updateUser(Request request, String id) =>
      handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          final user =
              await UserDb.get(where: (t) => t.id.equals(int.parse(id)));

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
            ],
          );
          user
            ..firstName = (data['firstName'] as String?) ?? user.firstName
            ..lastName = (data['lastName'] as String?) ?? user.lastName;

          await user.save();

          return jsonResponse(body: user.toJson());
        },
      );
}
