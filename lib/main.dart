import 'package:flutter/material.dart';

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

class _MainPageState extends State<MainPage> {
  String _title = 'Primera';
  int _indexPage = 0;
  Widget _view;
  Widget _firstView = Center(child: Text('Primera Vista'));
  Widget _secondView = Center(child: Text('Segunda Vista'));

  void _selectFeature(int index) {
    setState(() {
      _indexPage = index;
      _view = _indexPage == 0 ? _firstView : _secondView;
      _title = _indexPage == 0 ? 'Primera' : 'Segunda';
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
              title: Text('Lista de compras'),
              onTap: () {

                Navigator.pop(context);
                _selectFeature(0);
              },
            ),
            ListTile(
              title: Text('Monitor de consumo'),
              onTap: () {
                Navigator.pop(context);
                _selectFeature(1);
              },
            )
          ],
        ),
      ),
    );
  }

}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}