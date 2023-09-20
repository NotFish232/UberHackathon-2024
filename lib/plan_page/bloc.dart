// Importing necessary packages
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// WMATABloc class
class WMATABloc {
  // WMATA API key
  static const wmataApiKey = '<api-key-here>';

  // Method to get station code
  Future<String> getStationCode(String stationName) async {
    // Constructing the URL
    final url = Uri.https('api.wmata.com', '/Rail.svc/json/jStations', {
      'api_key': wmataApiKey,
    });

    // Making the GET request
    final response = await http.get(url);

    // If the request is successful
    if (response.statusCode == 200) {
      // Decoding the response body
      final Map<String, dynamic> stationData = jsonDecode(response.body);
      List<dynamic> stations = stationData['Stations'];
      // Looping through the stations
      for (var station in stations) {
        // If the station name matches
        if (station['Name'] == stationName) {
          print(station['Code']);
          // Returning the station code
          return station['Code'];
        }
      }
    }
    // If the request is not successful
    else {
      throw Exception('Failed to get station code');
    }
    return Future.value('error');
  }

  // Method to get station predictions
  Future<List<String>> getStationPredictions(String stationName, String finalName) async {
    // Getting the station code and final code
    String stationCode = await getStationCode(stationName);
    String finalCode = await getStationCode(finalName);

    List<String> stationTimes = [];
    List<String> finalTimes = [];

    // Constructing the URL
    final url1 = Uri.https(
        'api.wmata.com',
        '/stationprediction.svc/json/getprediction/$stationCode',
        {'api_key': wmataApiKey});

    // Making the GET request
    final response1 = await http.get(url1);

    // If the request is successful
    if (response1.statusCode == 200) {
      // Decoding the response body
      final Map<String, dynamic> predictionData = jsonDecode(response1.body);
      List<dynamic> trains = predictionData['Trains'];
      // Looping through the trains
      for (var train in trains) {
        if(train['Min'] == 'BRD' || train['Min'] == 'ARR'){
          stationTimes.add('0');
        }
        else{
          stationTimes.add(train['Min']);
        }
      }
    } else {
      throw Exception('Failed to get station predictions');
    }

    // Constructing the URL
    final url2 = Uri.https(
        'api.wmata.com',
        '/Rail.svc/json/jSrcStationToDstStationInfo',
        {
          'FromStationCode': stationCode,
          'ToStationCode': finalCode,
          'api_key': wmataApiKey
          });
    print(url2);

    // Making the GET request
    final response2 = await http.get(url2);

    // If the request is successful
    if (response2.statusCode == 200) {
      // Decoding the response body
      final Map<String, dynamic> predictionData = jsonDecode(response2.body);
      List<dynamic> sts= predictionData['StationToStationInfos'];
      int time = sts[0]['RailTime'];
      for(int i = 0; i < stationTimes.length; i++){
        finalTimes.add((int.parse(stationTimes[i])+time).toString());
      }
    } else {
      throw Exception('Failed to get station predictions');
    }

    // Constructing the final list
    List<String> finalList = [];
    for(int i = 0; i < min(stationTimes.length, finalTimes.length); i++){
      print(stationTimes[i]);
      print(finalTimes[i]);
      DateTime s = DateTime.now().add(Duration(minutes: int.parse(stationTimes[i])));
      DateTime f = DateTime.now().add(Duration(minutes: int.parse(finalTimes[i])));
      String sTime = (DateFormat('h:mm a').format(s));
      String fTime = (DateFormat('h:mm a').format(f));
      finalList.add('$sTime-$fTime');
    }
    // Returning the final list
    return finalList;
  }
}
