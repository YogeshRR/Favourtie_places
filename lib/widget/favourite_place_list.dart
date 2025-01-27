import 'package:favourite_places/widget/add_favourite_place.dart';
import 'package:flutter/material.dart';

class FavouritePlaceList extends StatelessWidget {
  const FavouritePlaceList({super.key});

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
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return const Card(
            child: Text(
              'I am here',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
