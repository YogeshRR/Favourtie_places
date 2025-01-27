import 'package:uuid/uuid.dart';

class Place {
  String id;
  String title;

  Place({required this.title}) : id = const Uuid().v4();
}
