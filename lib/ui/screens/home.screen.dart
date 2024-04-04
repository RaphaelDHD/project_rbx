import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter_but/domain/entities/monument.entity.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/ui/screens/home.state.dart';
import 'package:template_flutter_but/ui/screens/home.viewmodel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeProvider);
    final PlaceEntity? places = state.places;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
      ),
      body: state.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : places != null && places.results!.isNotEmpty
              ? ListView.builder(
                  itemCount: places.results?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final MonumentEntity? place = places.results?[index];
                    return ListTile(
                      title: Text(place?.name ?? 'no name'),
                    );
                  },
                )
              : const Center(
                  child: Text('No places found'),
                ),
    );
  }
}
