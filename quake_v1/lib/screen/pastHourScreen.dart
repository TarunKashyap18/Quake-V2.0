import 'dart:convert';

import 'package:Quake/widget/showList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PastHourScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Past Hour"),
        centerTitle: true,
      ),
      body: ShowList(data: getData(), internetStatus: true),
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
