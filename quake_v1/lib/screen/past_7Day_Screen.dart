import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/showList.dart';

class Past_7Days_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Past 7Days"),
        centerTitle: true,
      ),
      body: ShowList(data: getData(), internetStatus: true),
    );
  }

  Future<Map> getData() async {
    final url =
        "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson";
    final http.Response response = await http.get(url);
    if (response.statusCode == 200)
      return json.decode(response.body);
    else
      throw Exception("Failed to load data");
  }
}
