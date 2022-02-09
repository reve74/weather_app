import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Loading extends StatefulWidget {

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override // loading 페이지를 여는 동시에 initState 호출
  void initState() {
    super.initState();
    getLocation();
    fetchData();
  }

  void getLocation() async{ // 위치를 얻어오는 메소드
    try {
      LocationPermission permission = await Geolocator.requestPermission(); // 위치 정보 허용 오류 시 퍼미션 코드
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low); // 사용자의 위치 정보 받아옴
      print(position);
    }catch(e) {
      print(e);
    }
  }

  void fetchData() async{
    http.Response res = await http.get(Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
    if(res.statusCode == 200) {
      String jsonData = res.body;
      var myJson = jsonDecode(jsonData); // json Data는 변수가 일정하기 않기에 var 사용
      print(myJson['weather'][0]['description']);
      print(myJson['wind']['speed']);
      print(myJson['sys']['id']);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // getLocation();
          },
          child: Text('Get my location',
          style: TextStyle(color: Colors.white),),
          color: Colors.blue,
        ),
      ),
    );
  }
}
