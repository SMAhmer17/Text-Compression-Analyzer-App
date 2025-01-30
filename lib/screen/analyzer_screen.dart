// import 'dart:io';

// import 'package:daaproject/algo_description/huffman_description.dart';
// import 'package:daaproject/algo_description/lz4_description.dart';
// import 'package:daaproject/algo_description/lz77_description.dart';
// import 'package:daaproject/algo_description/z_standard_description.dart';
// import 'package:daaproject/compression_alog/huffman.dart';
// import 'package:daaproject/compression_alog/lz4.dart';
// import 'package:daaproject/compression_alog/lz77.dart';
// import 'package:daaproject/compression_alog/zstandard.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

// class AnalyzerScreen extends StatefulWidget {
//   @override
//   _AnalyzerScreenState createState() => _AnalyzerScreenState();
// }

// class _AnalyzerScreenState extends State<AnalyzerScreen> {
//   final Key _key = Key('fab_key');
//   String fileName = "";
//   String bestMethod = "";
//   Map<String, int> sizes = {};
//   String originalText = "";

//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform
//         .pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
//     if (result != null) {
//       File file = File(result.files.single.path!);
//       fileName = result.files.single.name;
//       originalText = await file.readAsString();
//       compressAll();
//     }
//   }

//   void compressAll() {
//     Map<String, String> compressed = {
//       'Huffman': huffmanCompress(originalText),
//       'LZ77': lz77Compress(originalText),
//       'LZ4': lz4Compress(originalText),
//       'ZStandard': zstdCompress(originalText),
//     };

//     sizes = {'Original': originalText.length};
//     compressed.forEach((key, value) {
//       sizes[key] = value.length;
//     });

//     bestMethod =
//         sizes.entries.skip(1).reduce((a, b) => a.value < b.value ? a : b).key;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.blue,
//           centerTitle: true,
//           title: Text(
//             "Text File Compression Analyzer",
//             style: TextStyle(
//                 fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
//           )),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               style: ButtonStyle(
//                 fixedSize: WidgetStatePropertyAll(Size(200, 50)),
//                 textStyle: WidgetStatePropertyAll(
//                     TextStyle(color: Colors.white, fontSize: 16)),
//                 backgroundColor: WidgetStatePropertyAll(Colors.amber),
//               ),
//               onPressed: pickFile,
//               child: Text("Select Text File"),
//             ),
//             if (fileName.isNotEmpty) Text("Selected File: $fileName"),
//             if (sizes.isNotEmpty)
//               Column(
//                 children: sizes.entries
//                     .map((e) => Text("${e.key}: ${e.value} bytes"))
//                     .toList(),
//               ),
//             if (bestMethod.isNotEmpty) Text("Best Compression: $bestMethod"),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: ExpandableFab.location,
//       floatingActionButton: ExpandableFab(
//         key: _key,
//         type: ExpandableFabType.up,
//         childrenAnimation: ExpandableFabAnimation.none,
//         distance: 70,
//         overlayStyle: ExpandableFabOverlayStyle(
//           color: Colors.white.withOpacity(0.9),
//         ),
//         children:  [
//           Row(
//             children: [
//               Text('Huffman Compression') ,
//               SizedBox(width: 20),
//               FloatingActionButton.small(
//                 heroTag: null,
//                 onPressed: (){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => HuffmanDescription()),
//                   );
//                 },
//                 child: Icon(Icons.code),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text('LZ77 Compression'),
//               SizedBox(width: 20),
//               FloatingActionButton.small(
//                 heroTag: null,
//                onPressed: (){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => LZ77Description()),
//                   );
//                 },
//                 child: Icon(Icons.repeat),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text('LZ4 Compression'),
//               SizedBox(width: 20),
//               FloatingActionButton.small(
//                 heroTag: null,
//                 onPressed: (){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => LZ4Description()),
//                   );
//                 },
//                 child: Icon(Icons.flash_on),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text('ZStandard Compression'),
//               SizedBox(width: 20),
//               FloatingActionButton.small(
//                 onPressed: (){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ZStandardDescription()),
//                   );
//                 },
//                 child: Icon(Icons.bolt),
//               ),
//             ],
//           ),
//           FloatingActionButton.small(
//             heroTag: null,
//             onPressed: (){
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => ZStandardDescription()),
//                   // );
//                 },
//             child: Icon(Icons.add),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:daaproject/compression_alog/huffman.dart';
import 'package:daaproject/compression_alog/lz4.dart';
import 'package:daaproject/compression_alog/lz77.dart';
import 'package:daaproject/compression_alog/zstandard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:showcaseview/showcaseview.dart';

class AnalyzerScreen extends StatefulWidget {
  @override
  _AnalyzerScreenState createState() => _AnalyzerScreenState();
}

class _AnalyzerScreenState extends State<AnalyzerScreen> {
  final Key _key = Key('fab_key');
  String fileName = "";
  String bestMethod = "";
  Map<String, int> sizes = {};
  String originalText = "";

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
    if (result != null) {
      File file = File(result.files.single.path!);
      fileName = result.files.single.name;

      originalText = await file.readAsString();

      compressAll();
    } else {
      // User canceled the file picker
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          content: Text(
            "No file selected.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)), // Rounded corners
          ),
        ),
      );
    }
  }

  void compressAll() {
    Map<String, String> compressed = {
      'Huffman': huffmanCompress(originalText),
      'LZ77': lz77Compress(originalText),
      'LZ4': lz4Compress(originalText),
      'ZStandard': zstdCompress(originalText),
    };

    sizes = {'Original': originalText.length};
    compressed.forEach((key, value) {
      sizes[key] = value.length;
    });

    bestMethod =
        sizes.entries.skip(1).reduce((a, b) => a.value < b.value ? a : b).key;
    setState(() {});
  }

  void _showDescriptionBottomSheet(
      BuildContext context, String title, String description) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4, // Initial size of the bottom sheet
          maxChildSize: 0.5, // Maximum size of the bottom sheet
          minChildSize: 0.3, // Minimum size of the bottom sheet

          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  GlobalKey<State<StatefulWidget>> _infoKey = GlobalKey();
  GlobalKey<State<StatefulWidget>> _buttonKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context).startShowCase([_infoKey, _buttonKey]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          Showcase(
            key: _infoKey,
            description:
                "Tap here to learn more about compression and this app.",
            child: IconButton(
              onPressed: () {
                showInfoDialog(context);
              },
              icon: Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
        title: Text(
          "Text File Compression Analyzer",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(
                      Size(MediaQuery.of(context).size.width * .8, 50)),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                ),
                onPressed: pickFile,
                child: Text(
                  "Select Text File",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            if (sizes.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                "Compression Results:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...sizes.entries.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "${e.key}: ${e.value} bytes",
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
            ],
            if (bestMethod.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                "Best Compression Method: $bestMethod",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        type: ExpandableFabType.up,
        openButtonBuilder: FloatingActionButtonBuilder(
            size: 30.0,
            builder: (context, V, V2) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  elevation: 10,
                  color: Colors.blue,
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                ),
              );
            }),
        closeButtonBuilder: FloatingActionButtonBuilder(
            size: 30.0,
            builder: (context, V, V2) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.blue,
                  elevation: 10,
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ),
              );
            }),
        childrenAnimation: ExpandableFabAnimation.none,
        distance: 70,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withOpacity(.8),
        ),
        children: [
          Row(
            children: [
              Text(
                'Huffman Compression',
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 20),
              FloatingActionButton.small(
                backgroundColor: Colors.blue,
                heroTag: null,
                onPressed: () {
                  _showDescriptionBottomSheet(
                    context,
                    "Huffman Compression",
                    "Huffman encoding is a lossless compression algorithm that uses variable-length codes based on the frequency of symbols in the data. It works best on data with redundant or repetitive patterns.\n\nWhen to Use:\n- Text files with highly skewed character frequencies (e.g., many repetitions of a few characters).\n- Small to medium-sized files where compression ratio is more important than speed.",
                  );
                },
                child: Icon(
                  Icons.code,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'LZ77 Compression',
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 20),
              FloatingActionButton.small(
                heroTag: null,
                backgroundColor: Colors.blue,
                onPressed: () {
                  _showDescriptionBottomSheet(
                    context,
                    "LZ77 Compression",
                    "LZ77 is a sliding-window-based compression algorithm that replaces repeated sequences with (distance, length) pairs. It is the foundation of many modern compression algorithms.\n\nWhen to Use:\n- Text files with repeated phrases or patterns (e.g., log files with repeated error messages).\n- Files where pattern redundancy is high.",
                  );
                },
                child: Icon(
                  Icons.repeat,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'LZ4 Compression',
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 20),
              FloatingActionButton.small(
                backgroundColor: Colors.blue,
                heroTag: null,
                onPressed: () {
                  _showDescriptionBottomSheet(
                    context,
                    "LZ4 Compression",
                    "LZ4 is a fast, lossless compression algorithm that focuses on speed over compression ratio. It uses a dictionary-based approach to replace repeated sequences with references.\n\nWhen to Use:\n- Real-time compression of text data where speed is more important than size.\n- Large files where fast compression and decompression are required.",
                  );
                },
                child: Icon(
                  Icons.flash_on,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'ZStandard Compression',
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 20),
              FloatingActionButton.small(
                backgroundColor: Colors.blue,
                onPressed: () {
                  _showDescriptionBottomSheet(
                    context,
                    "ZStandard Compression",
                    "ZStandard (ZSTD) is a modern, lossless compression algorithm that combines dictionary-based compression with entropy encoding. It is designed to be fast and achieve high compression ratios.\n\nWhen to Use:\n- Large text files with mixed data (repetitive patterns and high entropy).\n- General-purpose compression where both speed and compression ratio are important.",
                  );
                },
                child: Icon(
                  Icons.bolt,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.blue,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(
                          child: Text(
                        "Team Members  ",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Shaikh Muhammad Ahmer ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "EB21102102",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Muhammad Musab ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "EB21102071",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Close",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  });
            },
            child: Icon(
              Icons.info,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

void showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "About Compression and This App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "What is Compression?\n\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text:
                          "Compression is the process of reducing the size of data to save storage space or speed up transmission. It works by removing redundancy or encoding data more efficiently.\n\n",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "What Does This App Do?\n\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text:
                          "This app allows you to analyze the effectiveness of different compression algorithms on your text files. Simply select a .txt file, and the app will compress it using four popular algorithms: Huffman, LZ77, LZ4, and ZStandard.\n\n",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "How to Use:\n\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text:
                          "1. Tap the 'Select Text File' button to choose a .txt file from your device.\n"
                          "2. The app will display the original file size and the compressed sizes for each algorithm.\n"
                          "3. Based on the results, the app will recommend the best compression method for your file.\n\n",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "Why Use This App?\n\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text:
                          "- Compare the performance of different compression algorithms.\n"
                          "- Learn which algorithm works best for your specific text data.\n"
                          "- Understand how compression can reduce file sizes effectively.\n\n"
                          "Get started by selecting a text file and see the results!",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Close",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    },
  );
}
