import 'package:url_launcher/url_launcher.dart';

Future<void> whatsapp(String target, String content) async {
  // var url = 'https://wa.me/+6586161190/?text=hello-world';
  var url = 'https://wa.me/$target/?text=$content';
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch');
  }
}
