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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      ref.read(homeProvider.notifier).getPlacesWithOffset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeProvider);
    final PlaceEntity? places = state.places;

    return Scaffold(
      body: places == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        places.results!.length == places.totalCount ? places.results?.length : places.results!.length  + 1, // +1 for loading indicator
                    itemBuilder: (BuildContext context, int index) {
                      if (index < places.results!.length) {
                        final MonumentEntity monument = places.results![index];
                        return _buildMonumentListItem(context, monument);
                      } else {
                        return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ));
                      }
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

    return InkWell(
      onTap: () {
        // Action à effectuer lors du clic sur l'élément
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Center(
                child: Text(
                  firstLetter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    monument.name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    monument.epoque ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
