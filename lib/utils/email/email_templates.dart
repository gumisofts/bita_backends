import 'dart:io';

class EmailOtpTemplate {
  static Future<String> get content async {
    final temp = File('templates/otp_sign_up_mail.html');

    return temp.readAsString();
  }
}
