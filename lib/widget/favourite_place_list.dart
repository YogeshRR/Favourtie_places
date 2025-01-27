import 'package:flutter/material.dart';

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/add_favourite_place.dart';

class FavouritePlaceList extends StatelessWidget {
  const FavouritePlaceList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return places.isNotEmpty
        ? ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(places[index].title,
                    style: Theme.of(context).textTheme.titleMedium),
              );
            },
          )
        : Center(
            child: Text(
              'No Places available',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          );
  }
}
