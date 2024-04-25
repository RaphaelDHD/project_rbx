import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool _isConnected = true;

  List<ConnectivityResult> _connectionStatus = <ConnectivityResult>[
    ConnectivityResult.none
  ];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status' + e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (_connectionStatus.contains(ConnectivityResult.none)) {
      _isConnected = false;
    } else {
      _isConnected = true;
    }
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  @override
  Widget build(BuildContext context) {
    final MapState state = ref.watch(mapProvider);

    return Scaffold(
      
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
              state.selectedMarker!.imageUrl.isNotEmpty &&
              _isConnected)
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
                          heroTag: 'clearSelectedMarker',
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.clear, color: Colors.black),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            onPressed: () {
                              ref.read(mapProvider.notifier).goToDetails(
                                  id: state.selectedMonument!.id,
                                  context: context);
                            },
                            heroTag: 'goToDetails',
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.open_in_browser,
                                color: Colors.black),
                          ),
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
