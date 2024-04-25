import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:template_flutter_but/domain/entities/monument.entity.dart';
import 'package:template_flutter_but/ui/screens/details/details.state.dart';
import 'package:template_flutter_but/ui/screens/details/details.viewmodel.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({super.key});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  bool _isConnected = false;

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
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DetailsState state = ref.watch(detailsProvider);

    MonumentEntity? monument = ref.read(detailsProvider.notifier).getMonument();

    bool isFavorite = state.isFavorite;

    if (monument == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      );
    }

    String adresse = monument.adresseBanSig ?? "Unknown";
    String ville = monument.commune ?? "Unknown";
    String codePostal = monument.codeDepartement.toString();
    String adresseComplete = "$adresse, $ville, $codePostal";

    return Scaffold(
      appBar:
          AppBar(title: Text(monument.name ?? 'Sans nom'), actions: <Widget>[
        IconButton(
          icon: isFavorite
              ? const Icon(Icons.favorite, color: Colors.blue)
              : const Icon(Icons.favorite_border, color: Colors.blue),
          onPressed: () {
            if (isFavorite) {
              ref.read(detailsProvider.notifier).removeFromFavorite();
            } else {
              ref.read(detailsProvider.notifier).addToFavorite();
            }
          },
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            monument.photo != null
                ? _isConnected  ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(monument.photo?.url ?? '',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) =>
                            loadingProgress == null
                                ? child
                                : const Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ))),
                  ) : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.wifi_off,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                  ) 
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.no_photography,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                monument.description ?? "Pas de description",
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 117, 117, 117)),
              ),
            ),
            const Text(
              'Adresse :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                adresseComplete,
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 117, 117, 117)),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Date de protection :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                monument.dateDeProtection ?? "Pas de date de protection",
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 117, 117, 117)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              monument.classement ?? "Non classé",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (monument.lat != null &&
                monument.long != null &&
                _isConnected) ...<Widget>[
              const Text(
                'Localisation :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (_isConnected)
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      compassEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target:
                            LatLng(monument.lat ?? 0.0, monument.long ?? 0.0),
                        zoom: 14.4746,
                      ),
                      markers: <Marker>{
                        Marker(
                          markerId: MarkerId(monument.name ?? 'Sans nom'),
                          position:
                              LatLng(monument.lat ?? 0.0, monument.long ?? 0.0),
                          infoWindow: InfoWindow(
                            title: monument.name ?? 'Sans nom',
                            snippet: monument.commune ?? 'Unknown',
                          ),
                        ),
                      },
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
