import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './widget/mydrawer.dart';
import './widget/showList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quake',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Quake'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: ShowList(data: getData(), internetStatus: true),
      ),
      drawer: MyDrawer(),
    );
  }

  Future<Map> getData() async {
    final url =
        "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson";
    final http.Response response = await http.get(url);
    if (response.statusCode == 200)
      return json.decode(response.body);
    else
      throw Exception("Failed to load data");
  }
}
