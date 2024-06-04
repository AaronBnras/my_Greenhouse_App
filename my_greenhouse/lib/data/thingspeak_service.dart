import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_greenhouse/data/sensor_data.dart';


class ThingspeakService {
  late final String channelID;
  late final String readAPIkey;

  ThingspeakService({required this.channelID, required this.readAPIkey});

  Future<SensorData?> fetchData() async{
    const url = 'https://api.thingspeak.com/channels/2562505/feeds.json?api_key=WBTWK03HLNA3N339&results=2';

    try{
      final response = await http.get(Uri.parse(url));

      if(response.statusCode == 200){
        final data = json.decode(response.body);
        final feeds = data['feeds'];
        if(feeds.isNotEmpty){
          return SensorData.fromJson(feeds[0]);
        }
      }else{
        if (kDebugMode) {
          print('Failed to load data: ${response.statusCode}');
        }
      }
    } catch (e){
      if (kDebugMode) {
        print('Error: e');
      }
    }
    return null;
  }
}
