String formatDescription(String raw) {
  return raw
      .replaceAllMapped(RegExp(r'\\n\s*\+?\s*'), (_) => '\n')
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .join('\n')
      .trim();
}
