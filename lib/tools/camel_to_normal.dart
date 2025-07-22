String camelToNormal(String text) {
  return text[0].toUpperCase() +
      text
          .replaceAllMapped(RegExp(r'([A-Z])'), (Match match) {
            return ' ${match.group(1)}';
          })
          .substring(1);
}
