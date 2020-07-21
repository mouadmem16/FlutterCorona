import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HttpClient {
    NumberFormat numberFormat = NumberFormat.compact();

  Future<Map<String, String>> getGlobStats() async {
    var data = await http.get("https://api.thevirustracker.com/free-api?global=stats");
    var jsondata = json.decode(data.body);
    dynamic results = jsondata["results"][0];
    Map<String, String> glob = Map();
    glob["total_cases"] =         numberFormat.format(results["total_cases"]); 
    glob["total_recovered"] =     numberFormat.format(results["total_recovered"]);
    glob["total_deaths"] =        numberFormat.format(results["total_deaths"]);
    glob["total_active_cases"] =  numberFormat.format(results["total_active_cases"]);
    glob["total_serious_cases"] = numberFormat.format(results["total_serious_cases"]);
    return glob;
  }

  Future<Map<String, String>> getCountryStats(String codeCountry) async {
    var data = await http.get("https://api.thevirustracker.com/free-api?countryTotal="+codeCountry);
    var jsondata = json.decode(data.body);
    Map<String, dynamic> results = jsondata["countrydata"][0];
    Map<String, String> glob = Map<String, String>();
    glob["total_cases"] =         numberFormat.format(results["total_cases"]); 
    glob["total_recovered"] =     numberFormat.format(results["total_recovered"]);
    glob["total_deaths"] =        numberFormat.format(results["total_deaths"]);
    glob["total_active_cases"] =  numberFormat.format(results["total_active_cases"]);
    glob["total_serious_cases"] = numberFormat.format(results["total_serious_cases"]);
    return glob;
  }

  Future<Map<String, int>> getCountryTimeline(String codeCountry) async {
    var data = await http.get("https://api.thevirustracker.com/free-api?countryTimeline="+codeCountry);
    var jsondata = json.decode(data.body);
    Map<String, dynamic> results = jsondata["timelineitems"][0];
    List<String> keys = results.keys.toList();
    List<dynamic> values = results.values.toList();

    Map<String, int> resList = Map<String, int>();
    int length = results.length - 2;
    
    for (int i = length; i > length - 7; i--) {
      resList[keys[i]] = values[i]["new_daily_cases"];
    }

    print(resList);

    return resList;
  }


}
