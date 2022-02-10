import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


const apiKey = '9c51e25b2a667933712dad39e89b2b58';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherAirPollutionURL = 'http://api.openweathermap.org/data/2.5';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double? latitude3;
  double? longitude3;

  @override // loading 페이지를 여는 동시에 initState 호출
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getCityWeather(String cityName) async{
    Network network = Network(url3: '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await network.getJsonData();
    //return weatherData;
    print(weatherData);
  }

  Future<void> getLocation() async {
    // 위치를 얻어오는 메소드
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    //print(latitude3);
    //print(longitude3);

    Network network = Network(
        url:
            '$openWeatherMapURL?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
        url2:
            '$openWeatherAirPollutionURL/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey'); //&units=metric = 섭씨

    var weatherData = await network.getJsonData();

    var airData = await network.getAirData();
    print(weatherData);
    print(airData);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          parseWeatherData: weatherData,
          parseAirPollution: airData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
