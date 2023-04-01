import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sliver_example/pages/favorite_page.dart';
import 'package:sliver_example/pages/settings_page.dart';
import 'package:sliver_example/pages/stations_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tabController = StreamController<int>.broadcast();

  @override
  void initState() {
    _tabController.add(0);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
        stream: _tabController.stream,
        builder: (context, snapshot) {
          return _TabBuilderWidget(
            index: snapshot.data ?? 0,
            pages: const [
              StationsPage(),
              FavoritePage(),
              SettingsPage(),
            ],
          );
        },
      ),
      bottomNavigationBar: StreamBuilder<int>(
        stream: _tabController.stream,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            currentIndex: snapshot.data ?? 0,
            onTap: (value) {
              _tabController.add(value);
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white54,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: 'Станции',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Избранное',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Настройки',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TabBuilderWidget extends StatelessWidget {
  final int index;

  final List<Widget> pages;

  const _TabBuilderWidget({
    required this.index,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    return pages[index];
  }
}
