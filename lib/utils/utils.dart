import 'dart:math';

export 'email/email.dart';
// export 'exceptions/api_exceptions.dart';
export 'extensions.dart';
export 'forms/field_exceptions.dart';
export 'forms/form_validators.dart';
export 'jwt.dart';
export 'sms/sms.dart';
// export 'http.dart';

int generateSecureRandom({int length = 6}) {
  final max = (pow(10, length) - 1).toInt();
  return Random.secure().nextInt(max);
}
