import 'package:flutter/material.dart';

class AddFavouritePlace extends StatefulWidget {
  const AddFavouritePlace({super.key});

  @override
  State<AddFavouritePlace> createState() => _AddFavouritePlaceState();
}

class _AddFavouritePlaceState extends State<AddFavouritePlace> {
  @override
  Widget build(BuildContext context) {
    var _textEdittingController = TextEditingController();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Favourite Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _textEdittingController,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: Text(
                'Add Place',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
