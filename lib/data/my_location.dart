import 'package:geolocator/geolocator.dart';

class MyLocation {
  double? latitude2;
  double? longitude2;

  Future<void> getMyCurrentLocation() async{
    try {
      LocationPermission permission = await Geolocator.requestPermission(); // 위치 정보 허용 오류 시 퍼미션 코드
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low); // 사용자의 위치 정보 받아옴
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print(latitude2);
      print(longitude2);
      print(position);
    }catch(e) {
      print(e);
    }
  }
}