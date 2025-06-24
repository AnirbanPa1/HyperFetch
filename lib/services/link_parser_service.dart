import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class LinkParserService {
  static Future<List<String>> extractLinks(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) return [];

    final document = parse(response.body);
    final elements = document.querySelectorAll('a[href], img[src]');

    final links = <String>{};

    for (var element in elements) {
      final href = element.attributes['href'];
      final src = element.attributes['src'];
      final link = href ?? src;

      if (link != null && _isMediaLink(link)) {
        final absoluteLink = link.startsWith('http')
            ? link
            : Uri.parse(url).resolve(link).toString();
        links.add(absoluteLink);
      }
    }

    return links.toList();
  }

  static bool _isMediaLink(String url) {
    final mediaExtensions = [
      '.jpg',
      '.jpeg',
      '.png',
      '.gif',
      '.webp',
      '.mp4',
      '.pdf',
    ];
    return mediaExtensions.any((ext) => url.toLowerCase().endsWith(ext));
  }
}
