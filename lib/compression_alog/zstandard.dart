import 'dart:convert';

String zstdCompress(String text) {
  // Simplified ZStandard-like compression
  List<int> compressed = [];
  for (int i = 0; i < text.length; i += 4) {
    compressed.add(text.codeUnitAt(i));
  }
  return base64Encode(compressed);
}