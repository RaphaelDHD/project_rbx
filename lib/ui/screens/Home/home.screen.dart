import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter_but/domain/entities/monument.entity.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/ui/screens/home/home.state.dart';
import 'package:template_flutter_but/ui/screens/home/home.viewmodel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _isConnected = false;

  List<ConnectivityResult> _connectionStatus = <ConnectivityResult>[
    ConnectivityResult.none
  ];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
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

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        _isConnected) {
      ref.read(homeProvider.notifier).getPlacesWithOffset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeProvider);
    final PlaceEntity? places = state.places;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Monuments historiques de Roubaix'),
      ),
      body: places == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemCount: (places.results!.length == places.totalCount
                            ? places.results?.length
                            : places.results!.length + 1) ??
                        0, // +1 for loading indicator
                    itemBuilder: (BuildContext context, int index) {
                      if (index < places.results!.length) {
                        final MonumentEntity monument = places.results![index];
                        return _buildMonumentListItem(context, monument);
                      } else {
                        if (_isConnected) {
                          return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ));
                        }
                      }
                      return null;
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 4.0);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildMonumentListItem(BuildContext context, MonumentEntity monument) {
    final String firstLetter = monument.name?[0].toUpperCase() ?? '';
    const Color color = Colors.blue;
    bool isFavorite =
        ref.read(homeProvider.notifier).isFavorite(id: monument.id);

    return Card(
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        onTap: () {
          ref
              .read(homeProvider.notifier)
              .goToDetails(id: monument.id, context: context);
        },
        title: Text(monument.name ?? ''),
        subtitle: Text(monument.epoque ?? ''),
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(firstLetter),
        ),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.purpleAccent,
          ),
          onPressed: () {
            if (isFavorite) {
              ref
                  .read(homeProvider.notifier)
                  .removeFromFavorite(id: monument.id);
            } else {
              ref.read(homeProvider.notifier).addToFavorite(id: monument.id);
            }
          },
        ),
      ),
    );
  }
}
