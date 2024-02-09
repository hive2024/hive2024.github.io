import 'package:url_launcher/url_launcher.dart';

Future<void> whatsapp(String target, String content) async {
  // var url = 'https://wa.me/+6586161190/?text=hello-world';
  var url = 'https://wa.me/$target/?text=$content';
  print("whatsapp>> $url");
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch');
  }
}

///https://player.vimeo.com/video/909714908?muted=1&amp;autoplay=1&amp;loop=1&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;
String getHtmlBody(String url) {
  String u = url.contains("?") ? url : "$url?";
  String html = '''
<div style="padding:56.25% 0 0 0;position:relative;">
<iframe src="${u}muted=1&amp;autoplay=1&amp;loop=1&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="mytest">
</iframe>
</div>
<script src="https://player.vimeo.com/api/player.js"></script>
''';
  print("getHtmlBody>> $html");
  return html;
}
