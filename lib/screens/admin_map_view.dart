import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdminMapView extends ConsumerWidget {
  const AdminMapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LatLng _center = const LatLng(40.763308, 29.929694);
    late GoogleMapController mapController;
    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("ADMIN MAP"),
        backgroundColor: Colors.indigo.withOpacity(0.75),
      ),
      body: GoogleMap(
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
  Set<Marker> _createMarker() {
    return {
      const Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(40.763308, 29.929694),
      ),
      const Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(40.774408, 29.940794),
      ),
    };
  }
}
