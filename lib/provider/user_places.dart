import 'package:riverpod/riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

import 'package:favourite_places/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

  void addPlace(Place place) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.selectedImage.path);
    final savedImage =
        await place.selectedImage.copy('${appDir.path}/$fileName');
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
