import 'package:url_launcher/url_launcher_string.dart';

// For non-web platforms, this does nothing
void launchAppDownload(String url) {
  launchUrl(url);
}

void launchUrl(String url) {
  launchUrlString(url);
}
