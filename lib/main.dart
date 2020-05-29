import 'package:flutter/material.dart';
import 'package:streams_exemple/pages/futures/futures_page.dart';
import 'package:streams_exemple/pages/streams/streams_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future and Streams',
      debugShowCheckedModeBanner: false,
      initialRoute: '/futures',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (BuildContext context) => StreamsPage(
              title: 'Demonstração de Streams',
            ),
        '/futures': (BuildContext context) => FuturesPage(
              title: 'Demonstração de Futures',
            ),
      },
    );
  }
}
