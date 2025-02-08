import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    Widget? mapWidget;
    mapWidget = Container(
      width: 300, // Circular map size
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue, width: 4),
      ),
      child: ClipOval(
        child: Screenshot(
          controller: screenshotController,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(place.location.latitude, place.location.longitude),
              zoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                        place.location.latitude, place.location.longitude),
                    builder: (context) => const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      //size: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image(
            image: FileImage(place.selectedImage),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  child: CircleAvatar(radius: 70, child: mapWidget),
                  onTap: () {
                    print('I am clicked');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return MapScreen(
                            location: place.location,
                            isSelecting: false,
                          );
                        },
                      ),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      print('I am clicked');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return MapScreen(
                              location: place.location,
                              isSelecting: false,
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      place.location.address,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
