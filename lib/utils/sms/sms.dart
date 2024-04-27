import 'package:bita_markets/models/schema.dart';
import 'package:http/http.dart' as http;

class SMSHahu {
  static const _url = '';
  static Future<bool> send({required String phone, required String msg}) async {
    try {
      await http.post(Uri.parse(_url));
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
    print(template);
    return SMSHahu.send(phone: user.phoneNumber!, msg: template);
  }
}

void main(List<String> args) {
  http.post(Uri.parse('https://hahu.io/api/send/sms'));
}
