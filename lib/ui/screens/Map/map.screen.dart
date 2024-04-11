import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:template_flutter_but/domain/entities/marker.entity.dart';
import 'package:template_flutter_but/ui/screens/map/map.state.dart';
import 'package:template_flutter_but/ui/screens/map/map.viewmodel.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final MapState state = ref.watch(mapProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartes'),
      ),
      body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GoogleMap(
              mapType: MapType.normal,
              compassEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.from(state.markers.map((MarkerEntity marker) {
                return Marker(
                  markerId: MarkerId(marker.title),
                  position: LatLng(marker.lat, marker.long),
                  infoWindow: InfoWindow(title: marker.title),
                );
              })),
            ),
          ),
        ),
    );
  }
}
