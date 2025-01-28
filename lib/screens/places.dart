import 'package:favourite_places/provider/user_places.dart';
import 'package:favourite_places/widget/favourite_place_list.dart';
import 'package:flutter/material.dart';

import 'package:favourite_places/screens/add_favourite_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Places extends ConsumerWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var addedPlaceValue = ref.watch(userPlacesProvider);
    void addNewPlace() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (contex) {
            return const AddFavouritePlace();
          },
        ),
      );
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: addNewPlace,
            icon: const Icon(
              Icons.add,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: FavouritePlaceList(places: addedPlaceValue),
    );
  }
}
