import 'package:riverpod/riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:favourite_places/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

  void addPlace(Place place) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.selectedImage.path);
    final savedImage =
        await place.selectedImage.copy('${appDir.path}/$fileName');
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
      },
      version: 1,
    );

    db.insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': savedImage.path,
      'loc_lat': place.location.latitude,
      'loc_lng': place.location.longitude,
      'address': place.location.address,
    });

    final newPlace = Place(
      title: place.title,
      location: place.location,
      selectedImage: savedImage,
    );
    state = [...state, newPlace];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>((ref) {
  return UserPlacesNotifier();
});
