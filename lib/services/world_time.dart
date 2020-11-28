import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime
{
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;
  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async
  {
    try
    {
      //Get datetime from api
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');

      //Decode the JSON to a map object
      Map data = jsonDecode(response.body);

      //Get the properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);
      //print(datetime);
      print(data['utc_offset']);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDayTime = (now.hour>6 && now.hour<20) ? true : false;
      time = DateFormat.jm().format(now);
      print(time);
    }
    catch (e)
    {
      print('Caught an error: $e');
      time = 'could not get time date. sorry bitch';
    }

  }
}