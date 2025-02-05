
import 'package:daaproject/screen/analyzer_screen.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,  
        
      ),
      debugShowCheckedModeBanner: false,
      title: 'Network Optimization',
      home: ShowCaseWidget(builder: (context) => AnalyzerScreen()),
    );
  }
}
