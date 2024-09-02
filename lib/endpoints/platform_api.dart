import 'package:bita_markets/utils/function/request_handler_wrapper.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'platform_api.g.dart';

class PlatformApi {
  Router get router => _$PlatformApiRouter(this);
  @Route.post('/interests')
  Future<Response> userInterest(Request request) => handleRequestWithPermission(
        request,
        permission: () {},
        endpoint: () async {
          // TODO(nurads): Complete this endpoint
          return jsonResponse();
        },
      );
}
