import 'dart:async';

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
  Timer timer;
  List<Device> items = [];

  @override
  void initState() {
    super.initState();
    const time = const Duration(seconds: 5);
    timer = new Timer.periodic(time, (Timer t) => setState((){}));
  }

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
                child: _BasicDeviceTile(device: data[index])
          );
        });
  }

}

class _BasicDeviceTileState extends State<_BasicDeviceTile> {
  @override
  Widget build(BuildContext context) {
    bool on = widget.device.state == 'on';
    Widget subtitle = Text(widget.device.model == 'Pow_R2' && on ? 'Consumo: ${widget.device.power}W' : '');
    return ListTile(
        title: Text('${widget.device.name[0].toUpperCase()}${widget.device.name.substring(1)}',
            style: TextStyle(fontSize: 18.0, )),
        subtitle: subtitle,
        trailing: FloatingActionButton(
            backgroundColor: on ? Colors.greenAccent : Colors.white70,
            child: Icon(Icons.power_settings_new, color: on ? Colors.white : Colors.black26),
            onPressed: () {
              globals.devicesService.changeState(widget.device)
                  .then((state) {
                    setState(() {
                      widget.device.state = state;
                    });
              });
            },
        )
    );
  }

}

class _BasicDeviceTile extends StatefulWidget {
  Device device;

  _BasicDeviceTile({Key key, this.device}): super(key: key);

  @override
  _BasicDeviceTileState createState() {
    return _BasicDeviceTileState();
  }

}