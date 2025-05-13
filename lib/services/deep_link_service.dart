import 'package:app_links/app_links.dart';

class DeepLinkHandler {
  final AppLinks _appLinks = AppLinks();

  void init({required Function(Uri uri) onLinkReceived}) {
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        onLinkReceived(uri);
      }
    });
  }
}
