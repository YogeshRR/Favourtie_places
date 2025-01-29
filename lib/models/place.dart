import 'package:uuid/uuid.dart';
import 'dart:io';

class PlaceLocation {
  const PlaceLocation(
      {required this.latitude, required this.longitude, required this.address});
  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  String id;
  String title;
  File selectedImage;
  //PlaceLocation location;

  Place({
    required this.title,
    required this.selectedImage,
  }) : id = const Uuid().v4();
}
