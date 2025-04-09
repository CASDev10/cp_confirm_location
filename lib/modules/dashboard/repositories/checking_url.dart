import 'dart:html' as html;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web URL Params Demo',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String id = '';
  String name = '';

  @override
  void initState() {
    super.initState();

    // Get the full browser URL
    var uri = Uri.parse(html.window.location.href);

    // Get query parameters like ?id=13&name=John
    setState(() {
      id = uri.queryParameters['id'] ?? '';
      name = uri.queryParameters['name'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Web URL Params'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              id.isNotEmpty ? "ID from URL: $id" : "No ID in URL",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              name.isNotEmpty ? "Name from URL: $name" : "No Name in URL",
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
