import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  bool updateIt = true;

  void updateMinute() async {
    WorldTime instance = WorldTime(location: data['location'],flag: data['flag'],url: data['url'],);
    await instance.getTime();
    setState(() {

      data = {
        'time': instance.time,
        'isDayTime': instance.isDayTime,
        'flag': instance.flag,
        'location': instance.location,
        'url': instance.url,
      };
    });
  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty? data: ModalRoute.of(context).settings.arguments;
    print(data);
    String bgImage = data['isDayTime']? 'day.png' : 'night.png';
    Color bgStripColor = data['isDayTime']? Colors.blue : Colors.grey[900];
    if(updateIt)  updateMinute();
    return Scaffold(
      backgroundColor: bgStripColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(

                    onPressed: () async{
                      updateIt=false;
                      dynamic fetch = await Navigator.pushNamed(context, '/location');
                      Map result = fetch;
                      setState(() {
                        if(result.isNotEmpty)
                          {
                            data = {
                              'time': result['time'],
                              'location': result['location'],
                              'isDayTime': result['isDayTime'],
                              'flag': result['flag'],
                              'url': result['url'],
                            };
                          }
                      });

                      print('test: $result');
                      updateIt=true;
                    },
                    icon: Icon(Icons.edit_location, color: Colors.white,),
                    label: Text('choose location', style: TextStyle(color: Colors.white,),),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(data['location'],
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 20.0,
                          color: Colors.grey[400],
                        )),
                        SizedBox(width:10.0),
                        CircleAvatar(backgroundImage: AssetImage('assets/${data['flag']}'), radius: 15,)
                        //Image(image:AssetImage('assets/${data['flag']}',), height: 25.0, width: 25.0,)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(data['time'],
                  style: TextStyle(
                    letterSpacing: 2.0,
                    fontSize: 50.0,
                    color: Colors.grey[400],
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
