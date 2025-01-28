import 'package:uuid/uuid.dart';
import 'dart:io';

class Place {
  String id;
  String title;
  File selectedImage;

  Place({required this.title, required this.selectedImage})
      : id = const Uuid().v4();
}
