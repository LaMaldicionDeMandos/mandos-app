import 'package:flutter/material.dart';
import 'package:mandos_app/screens/devices.dart';
import 'package:mandos_app/screens/energy_monitor.dart';

import 'package:mandos_app/screens/shopping_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Mandos';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static final _views = [
    { 'name': 'Lista de compras', 'view': ShoppingListPage()},
    { 'name': 'Dispositivos', 'view': DevicesPage()},
    { 'name': 'Monitor de consumo', 'view': EnergyMonitorPage()}
  ];
  Widget _view = _views.first['view'];
  String _title = _views.first['name'];

  void _selectFeature(int index) {
    setState(() {
      final view = _views.elementAt(index);
      _view = view['view'];
      _title = view['name'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: _view,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
                height: 90.0,
                child: DrawerHeader(
                  child: Text('Aplicaciones',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.0)
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent
                  ),
                )
            ),
            ListTile(
              title: Text(_views.elementAt(0)['name']),
              onTap: () {
                Navigator.pop(context);
                _selectFeature(0);
              },
            ),
            ListTile(
              title: Text(_views.elementAt(1)['name']),
              onTap: () {
                Navigator.pop(context);
                _selectFeature(1);
              },
            ),
            ListTile(
              title: Text(_views.elementAt(2)['name']),
              onTap: () {
                Navigator.pop(context);
                _selectFeature(2);
              },
            )
          ],
        ),
      ),
    );
  }

}
