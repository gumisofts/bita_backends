import 'package:bita_markets/models/schema.dart';
import 'package:bita_markets/utils/forms/parsers/form_data.dart';
import 'package:bita_markets/utils/function/request_handler_wrapper.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'platform_api.g.dart';

class PlatformApi {
  Router get router => _$PlatformApiRouter(this);
  @Route.post('/interests')
  Future<Response> userInterest(Request request) => handleRequestWithPermission(
        request,
        permission: () {
          if (!request.isAuthenticated) {
            throw unAuthorizedException;
          }
        },
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );

  @Route.post('/upload')
  Future<Response> testFile(Request request) => handleRequestWithPermission(
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
              FieldValidator<UploadedFile>(
                name: 'file',
                isRequired: true,
                validator: (value) => [
                  'image/png',
                  'image/jpeg',
                  'image/jfif',
                  'image/heic',
                  'image/gif',
                  'text/csv',
                ].contains(value.contentType.mimeType)
                    ? null
                    : 'unsupported file format',
              ),
            ],
          );
          final f = await writeFileTo(file: data['file'] as UploadedFile);

          final size = f.lengthSync();

          final file =
              await FileTbDb.create(url: f.path, size: size.toDouble());
          return jsonResponse(body: file.toJson());
        },
      );
}
