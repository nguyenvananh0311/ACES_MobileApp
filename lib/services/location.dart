import 'package:geolocator/geolocator.dart';


Future<bool> checkLocation(double targetLatitude,double targetLongitude, int distanceStandard) async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  // const double targetLatitude = 37.4219983; // Replace with your target latitude
  // const double targetLongitude = -122.084; // Replace with your target longitude

  double distance = Geolocator.distanceBetween(
    position.latitude,
    position.longitude,
    targetLatitude,
    targetLongitude,
  );

  return distance <= distanceStandard; // within 100 meters
}

