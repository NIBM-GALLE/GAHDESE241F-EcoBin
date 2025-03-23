import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class BinLocation extends StatefulWidget {
  const BinLocation({Key? key}) : super(key: key);

  @override
  _BinLocationState createState() => _BinLocationState();
}

class _BinLocationState extends State<BinLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  bool _mapCreated = false;

  // Set default camera position
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.0,
  );

  // Example bin locations
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('bin1'),
          position: LatLng(37.42796133580664, -122.085749655962),
          infoWindow: InfoWindow(
            title: 'Bin Location 1',
            snippet: 'Recycling Bin',
          ),
        ),
      );
      _markers.add(
        const Marker(
          markerId: MarkerId('bin2'),
          position: LatLng(37.42496133580664, -122.082749655962),
          infoWindow: InfoWindow(title: 'Bin Location 2', snippet: 'Trash Bin'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bin Location'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              setState(() {
                _mapCreated = true;
              });
            },
          ),
          if (!_mapCreated) const Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async {
          try {
            final Position position = await Geolocator.getCurrentPosition();
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14,
                ),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error getting location: $e')),
            );
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
