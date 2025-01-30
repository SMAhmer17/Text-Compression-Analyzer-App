import 'dart:convert';
import 'dart:math';

String lz77Compress(String text) {
  List<int> compressed = [];
  int i = 0;
  while (i < text.length) {
    // Find the longest match in the sliding window
    int maxLength = 0, maxDistance = 0;
    for (int j = max(0, i - 255); j < i; j++) {
      int length = 0;
      while (i + length < text.length && text[j + length] == text[i + length]) {
        length++;
      }
      if (length > maxLength) {
        maxLength = length;
        maxDistance = i - j;
      }
    }
    if (maxLength > 2) {
      compressed.add(maxDistance);
      compressed.add(maxLength);
      i += maxLength;
    } else {
      compressed.add(text.codeUnitAt(i));
      i++;
    }
  }
  return base64Encode(compressed);
}