import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/user_model.dart';
import '../main.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late GoogleMapController mapController;
    final auth = ref.watch(authProvider);

    final LatLng _center = const LatLng(40.763308, 29.929694);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("KOU BUSS"),
        actions: [Center(child: Text("Welcome ${auth?.name}")),],
        backgroundColor: Colors.indigo.withOpacity(0.75),
      ),
      body: auth == null ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(auth == null ? "Username and password are not matching" : auth.name),
            ElevatedButton(
              child: const Text("Go Back"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                );
              },
            ),
          ],
        ),
      ) : GoogleMap(
        zoomControlsEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _createMarker(),
      ),
    );
  }
}

Set<Marker> _createMarker() {
  return {
    Marker(
      markerId: MarkerId("marker_1"),
      position: LatLng(40.763308, 29.929694),
    ),
    Marker(
      markerId: MarkerId("marker_2"),
      position: LatLng(40.774408, 29.940794),
    ),
  };
}