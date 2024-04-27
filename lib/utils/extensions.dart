
import 'package:d_orm/models/schema.dart';
import 'package:shelf/shelf.dart';

extension RequestAddon on Request {
  User? get contextUser => context['user'] as User?;
}

extension ApiUser on User? {
  bool get isAuthenticated => this != null;
}

// extension ResponseModifier on Response {
//   static Response jsonResponse() {
//     return Response.ok('');
//   }
// }

// class JsonResponse extends Response {
//   JsonResponse(super.statusCode);
//   JsonResponse.notFound(super.body) : super.notFound();

// }

// class JsonResponse extends Response {
//   @override
//   int statusCode;
//   Object body;
//   @override
//   Map<String, String> headers;
//   JsonResponse(super.statusCode, {
//     this.body = const {},
//     this.statusCode = HttpStatus.ok,
//     this.headers = const {},
//   }){
//     super.statusCode=statusCode;
//   };

//   Response call() {
//     return Response(statusCode, body: body, headers: {
//       ...headers,
//       if (!headers.containsKey(HttpHeaders.contentTypeHeader))
//         HttpHeaders.contentTypeHeader: ContentType.json.value
//     });
//   }
// }
