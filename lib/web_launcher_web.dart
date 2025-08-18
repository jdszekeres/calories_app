// web_launcher.dart
// Platform-specific launcher for app download

import 'dart:html' as html;

void launchAppDownload(String url) {
  html.window.open(url, '_blank');
}

void launchUrl(String url) {
  html.window.open(url, '_blank');
}
