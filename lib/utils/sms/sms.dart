import 'dart:convert';

import 'package:bita_markets/models/schema.dart';
import 'package:bita_markets/utils/utils.dart';
import 'package:http/http.dart' as http;

abstract class SMS {
  Future<bool> sendMessage({required String phone, required String message});
  Future<bool> sendOTP({required String phone, required int otp});
}

class GeezSMS implements SMS {
  final _url = 'https://api.geezsms.com/api/v1/sms/send';
  final _token = env['GEEZ_TOKEN'] ?? '';
  @override
  Future<bool> sendMessage({
    required String phone,
    required String message,
  }) async {
    final data = {
      'token': _token,
      'phone': phone,
      'msg': message,
    };

    try {
      final res = await http.post(Uri.parse(_url), body: data);

      final resDecode = jsonDecode(res.body);

      logger.i(resDecode);

      return !(resDecode['error'] as bool);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> sendOTP({required String phone, required int otp}) {
    return sendMessage(
      phone: phone[0] == '0' ? phone : '0$phone',
      message: 'your Bita verification code is $otp',
    );
  }
}

class SMSHahu {
  // static const _url = '';
  static Future<bool> send({required String phone, required String msg}) async {
    try {
      // await http.post(Uri.parse(_url));
    } catch (e) {
      return false;
    }
    return true;
  }
}

Future<bool> sendSms(User user, String msg) async {
  // add mail send feature here

  return true;
}

class SendSms {
  static Future<bool> sendOtp(String otp, User user) async {
    // add mail send feature here
    final template = '''
your verification code for Bita Markets is $otp
''';
    logger.i(template);
    return SMSHahu.send(phone: user.phoneNumber!, msg: template);
  }
}

void main(List<String> args) {
  http.post(Uri.parse('https://hahu.io/api/send/sms'));
}
