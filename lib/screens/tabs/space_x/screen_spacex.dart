import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/scoped_model/launches_latest.dart';
import 'package:space_news/scoped_model/launches_upcoming.dart';
import 'package:space_news/screens/tabs/space_x/tab_launches.dart';
import 'package:flutter/material.dart';
import 'package:space_news/screens/tabs/space_x/tab_vehicles.dart';
import 'package:space_news/scoped_model/vehicles.dart';

class SpacexScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpacexTabScreen();
}

class _SpacexTabScreen extends State<SpacexScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 1;

  static final VehiclesModel _vehicles = VehiclesModel();
  static final LaunchesUpcomingModel _upcomingLaunches =
      LaunchesUpcomingModel();
  static final LaunchesLatestModel _latestLaunches = LaunchesLatestModel();

  List<ScopedModel> _tabs = [
    ScopedModel<VehiclesModel>(
      model: _vehicles,
      child: VehiclesTab(),
    ),
    ScopedModel<LaunchesUpcomingModel>(
      model: _upcomingLaunches,
      child: LaunchesTab(),
    ),
    ScopedModel<LaunchesLatestModel>(
      model: _latestLaunches,
      child: LaunchesTab(),
    ),
  ];

  @override
  initState() {
    super.initState();
    _initPlatformState();
  }

  void _initPlatformState() async {
    _vehicles.loadData();
    _upcomingLaunches.loadData();
    _latestLaunches.loadData();
  }

  void _onTabTapped(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('SpaceX'), centerTitle: true),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: const Text('Vehicles'),
            icon: Icon(Icons.directions_car),
          ),
          BottomNavigationBarItem(
            title: const Text('Upcoming'),
            icon: Icon(Icons.timer),
          ),
          BottomNavigationBarItem(
            title: const Text('Latest'),
            icon: Icon(Icons.library_books),
          ),
        ],
      ),
    );
  }
}
