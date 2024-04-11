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
    target: LatLng(50.7, 3.1667),
    zoom: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    final MapState state = ref.watch(mapProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartes'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
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
                onTap: () {
                  ref.read(mapProvider.notifier).setSelectedMarker(marker);
                },
              );
            })),
          ),
          if (state.selectedMarker != null &&
              state.selectedMarker!.imageUrl.isNotEmpty)
            Positioned(
              top: 16.0,
              left: 16.0,
              right: 16.0,
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          state.selectedMarker!.imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.black,
                                    )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            ref
                                .read(mapProvider.notifier)
                                .clearSelectedMarker();
                          },
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.clear, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
