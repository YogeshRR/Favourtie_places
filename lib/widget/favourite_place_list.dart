import 'package:favourite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:favourite_places/models/place.dart';

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
                title: Text(
                  places[index].title,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailScreen(
                        place: Place(title: places[index].title),
                      ),
                    ),
                  );
                },
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
