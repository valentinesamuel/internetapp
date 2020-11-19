import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //To use the json.decode

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse;
  double latitude;
  double longitude;
  String mainWeather;
  int villa;
  int resCode;

  List listResponse;

  Map mapResponse;
  Future fetchData() async {
    http.Response response;
    response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=lagos&appid=e9ea363e3bfda4c6f78c96f8984940a8');
    try {
      if (response.statusCode == 200) {
        setState(() {
          mapResponse = json.decode(response.body);
          mainWeather = mapResponse['weather'][0]['main'];
          latitude = mapResponse['coord']['lat'];
          resCode = mapResponse['cod'];
          villa = mapResponse['dt'];
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch Data From Internet"),
        ),
        body: mapResponse == null
            ? Container(
                height: 150,
                width: 150,
                color: Colors.green,
              )
            : Center(
                child: Column(
                  children: [
                    Text(mainWeather),
                    Text(latitude.toString()),
                    Text(resCode.toString()),
                    Text(villa.toString()),
                  ],
                ),
              ));
  }
}
