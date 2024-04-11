import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter_but/domain/entities/monument.entity.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/ui/screens/Details/details.screen.dart';
import 'package:template_flutter_but/ui/screens/home/home.state.dart';
import 'package:template_flutter_but/ui/screens/home/home.viewmodel.dart';

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
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
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
                        return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ));
                      }
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

    return Card(
        child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DetailsScreen(monument: monument),
                  ));
            },
            title: Text(monument.name ?? ''),
            subtitle: Text(monument.epoque ?? ''),
            leading: CircleAvatar(
              backgroundColor: color,
              child: Text(firstLetter),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.purpleAccent,),
              onPressed: () {},
            )));
  }
}
