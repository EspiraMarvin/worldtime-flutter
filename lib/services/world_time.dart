import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time; // time in that location
  String flag; // url to an asset flag icon
  String url; // location url for API endpoint e.g Africa/Nairobi
  bool isDaytime; // true or false if daytime or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try{

      //MAKE the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data  = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create a date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour> 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);

    }catch(e){
      print(e);
      time = 'could not get time data';
    }

  }

}

// WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
