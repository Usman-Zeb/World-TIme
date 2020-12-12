import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String time = 'Loading';
  void setupWorldTime() async
  {
    WorldTime instance = WorldTime(location: 'Karachi', flag: 'pakistan.png', url: 'Asia/Karachi');
    await instance.getTime();
    //print(instance.time);
    setState(() {
      time = instance.time;

      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
        'url': instance.url,
      });
    });
  }
  @override

  void initState()
  {
    super.initState();
    setupWorldTime();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitWanderingCubes(
              color: Colors.white,
              size: 40.0,
            ),
            SizedBox(height: 20.0),
            Text('Loading',
            style: TextStyle(color: Colors.white, fontSize: 15.0)),
          ],
        ),

      ),
    );
  }
}
