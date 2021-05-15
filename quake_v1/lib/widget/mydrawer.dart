import 'package:Quake/screen/pastDayScreen.dart';
import 'package:Quake/screen/pastHourScreen.dart';
import 'package:Quake/screen/past_30Days_Screen.dart';
import 'package:Quake/screen/past_7Day_Screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset('assets/images/image.png')),
          ListTile(
            title: Text("Past Hour"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PastHourScreen()));
            },
          ),
          ListTile(
            title: Text("Past Day"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PastDayScreen()));
            },
          ),
          ListTile(
            title: Text("Past 7Days"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Past_7Days_Screen()));
            },
          ),
          ListTile(
            title: Text("Past 30Days"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Past_30Days_Screen()));
            },
          ),
        ],
      ),
    );
  }
}
