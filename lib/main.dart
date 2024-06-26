import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:template_flutter_but/application/injections/initializer.dart';
import 'package:template_flutter_but/data/dao/adapter/monument.model.adapter.dart';
import 'package:template_flutter_but/data/dao/adapter/photo.model.adapter.dart';
import 'package:template_flutter_but/data/dao/adapter/place.model.adapter.dart';
import 'package:template_flutter_but/data/network/models/monument.model.dart';
import 'package:template_flutter_but/data/network/models/photo.model.dart';
import 'package:template_flutter_but/data/network/models/place.model.dart';
import 'package:template_flutter_but/ui/screens/home/home.screen.dart';
import 'package:template_flutter_but/ui/screens/map/map.screen.dart';

void main() async {
  initializeInjections();
  await Hive.initFlutter();
  Hive.registerAdapter<PlaceModel>(PlaceModelAdapter());
  Hive.registerAdapter<MonumentModel>(MonumentModelAdapter());
  Hive.registerAdapter<PhotoModel>(PhotoModelAdapter());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MapScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Site historique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Monuments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Cartes',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
