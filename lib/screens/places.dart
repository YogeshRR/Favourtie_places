import 'package:favourite_places/widget/favourite_place_list.dart';
import 'package:flutter/material.dart';

import 'package:favourite_places/screens/add_favourite_place.dart';

class Places extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _addNewPlace() {
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
            onPressed: _addNewPlace,
            icon: const Icon(
              Icons.add,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: const FavouritePlaceList(places: []),
    );
  }
}
