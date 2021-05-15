import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Map _data;

class ShowList extends StatelessWidget {
  final Future<Map> data;
  final bool internetStatus;
  ShowList({@required this.data, @required this.internetStatus});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData && internetStatus == true) {
            _data = snapshot.data;
            return Scrollbar(
              thickness: 10.0,
              radius: Radius.circular(5.0),
              child: ListView.builder(
                  itemCount: _data["features"].length,
                  padding: const EdgeInsets.all(5.0),
                  itemBuilder: (BuildContext context, int postion) {
                    var date = DateTime.fromMicrosecondsSinceEpoch(
                        _data["features"][postion]["properties"]["time"] * 1000,
                        isUtc: true);
                    var dateFormate = new DateFormat.yMMMMd("en_US").add_jm();
                    var formattedDate = dateFormate.format(date);
                    //dynamic Color
                    Color quakeColor = getQuakeColor(postion);
                    String formatedMagnitude =
                        getQuakeMagnitudeFormated(postion);
                    return Column(
                      children: <Widget>[
                        Divider(
                          height: 6.0,
                        ),
                        ListTile(
                          title: Text(
                            "$formattedDate",
                            style: new TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${_data["features"][postion]["properties"]["place"]}",
                            style: new TextStyle(fontStyle: FontStyle.italic),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: quakeColor,
                            radius: 30.0,
                            child: Text(formatedMagnitude),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.pin_drop),
                            onPressed: () {},
                          ),
                          onTap: () => showAlert(
                              context,
                              _data["features"][postion]["properties"]["title"],
                              _data["features"][postion]["properties"]["type"]),
                        )
                      ],
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 100, top: 200, right: 100, bottom: 100),
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "No Internet Connection",
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: new CircularProgressIndicator(),
            );
          }
        });
  }

  void showAlert(BuildContext context, String msg, String type) {
    var alertDialog = new AlertDialog(
      title: Text(type.toUpperCase()),
      content: Text(msg),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("OK"),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  String getQuakeMagnitudeFormated(int index) {
    var mag = _data["features"][index]["properties"]["mag"];
    return mag.toStringAsFixed(2);
  }

  Color getQuakeColor(int index) {
    var mag = _data["features"][index]["properties"]["mag"];
    Color color;
    if (mag < 5.0) color = Colors.lightGreen;
    if (5.0 <= mag && mag < 8.0) color = Colors.amber;
    if (8.0 <= mag) color = Colors.deepOrange;
    return color;
  }
}
