import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppConfig {
  static String get phoneNumber {
    final raw = dotenv.env['WHATSAPP_NUMBER'] ?? '9745638628';
    return raw.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static String get defaultMessage {
    return dotenv.env['WHATSAPP_DEFAULT_MESSAGE'] ??
        'Hi Backershan, I visited your portfolio and would like to connect!';
  }

  static Future<bool> launchWhatsApp({String? message}) async {
    final text = message ?? defaultMessage;
    final phone = phoneNumber;
    final uri = Uri.parse(
      'https://wa.me/$phone?text=${Uri.encodeComponent(text)}',
    );
    
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }
}
