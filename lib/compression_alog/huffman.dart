import 'dart:convert';

class HuffmanNode implements Comparable<HuffmanNode> {
  String? char;
  int freq;
  HuffmanNode? left, right;
  HuffmanNode(this.char, this.freq);
  HuffmanNode.merge(this.left, this.right) : char = null, freq = (left?.freq ?? 0) + (right?.freq ?? 0);
  @override
  int compareTo(HuffmanNode other) => freq.compareTo(other.freq);
}

String huffmanCompress(String text) {
  // Build frequency table
  Map<String, int> freq = {};
  for (var char in text.split('')) {
    freq[char] = (freq[char] ?? 0) + 1;
  }

  // Build Huffman tree
  var queue = PriorityQueue<HuffmanNode>()..addAll(freq.entries.map((e) => HuffmanNode(e.key, e.value)));
  while (queue.length > 1) {
    var left = queue.removeFirst(), right = queue.removeFirst();
    queue.add(HuffmanNode.merge(left, right));
  }
  var root = queue.removeFirst();

  // Generate Huffman codes
  Map<String, String> huffmanCodes = {};
  void generateCodes(HuffmanNode? node, String code) {
    if (node == null) return;
    if (node.char != null) {
      huffmanCodes[node.char!] = code;
      return;
    }
    generateCodes(node.left, code + '0');
    generateCodes(node.right, code + '1');
  }
  generateCodes(root, '');

  // Encode text using Huffman codes
  String encodedText = '';
  for (var char in text.split('')) {
    encodedText += huffmanCodes[char]!;
  }

  // Serialize Huffman tree and encoded text
  return base64Encode(utf8.encode(encodedText));
}

class PriorityQueue<T> {
  final List<T> _heap = [];
  final Comparator<T> _comparator;

  PriorityQueue([int Function(T a, T b)? compare])
      : _comparator = compare ?? ((a, b) => (a as Comparable).compareTo(b));

  void add(T value) {
    _heap.add(value);
    _bubbleUp(_heap.length - 1);
  }

  void addAll(Iterable<T> values) {
    for (var value in values) {
      add(value);
    }
  }

  T removeFirst() {
    if (_heap.isEmpty) throw StateError("Queue is empty");
    var result = _heap[0];
    var last = _heap.removeLast();
    if (_heap.isNotEmpty) {
      _heap[0] = last;
      _bubbleDown(0);
    }
    return result;
  }

  int get length => _heap.length;

  void _bubbleUp(int index) {
    while (index > 0) {
      var parent = (index - 1) ~/ 2;
      if (_comparator(_heap[index], _heap[parent]) >= 0) break;
      _swap(index, parent);
      index = parent;
    }
  }

  void _bubbleDown(int index) {
    while (true) {
      var left = 2 * index + 1;
      var right = 2 * index + 2;
      var smallest = index;
      if (left < _heap.length && _comparator(_heap[left], _heap[smallest]) < 0) {
        smallest = left;
      }
      if (right < _heap.length && _comparator(_heap[right], _heap[smallest]) < 0) {
        smallest = right;
      }
      if (smallest == index) break;
      _swap(index, smallest);
      index = smallest;
    }
  }

  void _swap(int i, int j) {
    var temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }
}