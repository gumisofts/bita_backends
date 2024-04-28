import 'dart:math';

import 'package:logger/logger.dart';

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

final logger = Logger(
  printer: PrettyPrinter(
      // methodCount: 2, // Number of method calls to be displayed
      // errorMethodCount: 8, // Number of method calls if stacktrace is provided
      // lineLength: 120, // Width of the output
      // colors: true, // Colorful log messages
      // printEmojis: true, // Print an emoji for each log message
      // printTime: false // Should each log print contain a timestamp
      ),
);
