import 'package:flutter/material.dart';

import 'package:mandos_app/globals.dart' as globals;
import 'package:mandos_app/model/models.dart';
import 'package:mandos_app/services/services.dart';

class DevicesPage extends StatefulWidget {
  @override
  _DevicesPageState createState() {
    return _DevicesPageState();
  }
}

class _DevicesPageState extends State<DevicesPage> {
  final DevicesService service = globals.devicesService;
  List<Device> items = [];

  Future<List<Device>> _fetchItems() async{
    return service.list();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Device>>(
      future: _fetchItems(),
      builder: (context, snapshot) {
        return _createList(snapshot);
      },
    );
  }

  Widget _createList(snapshot) {
    items = snapshot.data;
    if (snapshot.hasData) return _createListView(items);
    if (snapshot.hasError) return Text("${snapshot.error}");
    return Center(child: CircularProgressIndicator());
  }

  ListView _createListView(List<Device> data) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(color: Colors.grey, height: 0.5),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final item = data[index].name;
          return Container(
                padding: const EdgeInsets.all(20),
                child: Text('${data[index].name[0].toUpperCase()}${data[index].name.substring(1)}',
                    style: TextStyle(fontSize: 18.0, ))
          );
        });
  }

}