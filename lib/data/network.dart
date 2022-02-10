import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {
  final dynamic url;
  final dynamic url2;
  final dynamic url3;

  Network({this.url, this.url2, this.url3});

  Future<dynamic> getJsonData() async {
    http.Response res = await http.get(Uri.parse(url));
      //(Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
    if (res.statusCode == 200) {
      String jsonData = res.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData; // 파싱된 json 데이터를 반환
    }else {
      print(res.statusCode);
    }
  }

  Future<dynamic> getAirData() async {
    http.Response res = await http.get(Uri.parse(url2));
    if (res.statusCode == 200) {
      String jsonData = res.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData; // 파싱된 json 데이터를 반환
    }else {
      print(res.statusCode);
    }
  }
}
