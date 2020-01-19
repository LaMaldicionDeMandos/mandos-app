import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:mandos_app/model/models.dart';
import 'package:mandos_app/globals.dart' as globals;
import 'package:mandos_app/services/services.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() {
    return _ShoppingListPageState();
  }
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final ShoppingListService service = globals.shoppingListService;
  List<ShoppingItem> items = [];

  Future<List<ShoppingItem>> _fetchItems() async {
    return await service.get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ShoppingItem>>(
      future: _fetchItems(),
      builder: (context, snapshot) {
        return Scaffold(
          body: _createList(snapshot),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final itemNameController = TextEditingController();
                    @override
                    void dispose() {
                      // Clean up the controller when the widget is disposed.
                      itemNameController.dispose();
                      super.dispose();
                    }
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20.0)), //this right here
                      child: Container(
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: itemNameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '¿Que queres comprar?'),
                              ),
                              SizedBox(
                                width: 320.0,
                                child: RaisedButton(
                                  onPressed: () {
                                    final Future<ShoppingItem> itemF = service.newItem(itemNameController.text);
                                    itemF.then((item) {
                                      setState(() {
                                        items.add(item);
                                      });
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text(
                                    "Agregar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.blueAccent,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _createList(snapshot) {
    items = snapshot.data;
    if (snapshot.hasData) return _createListView(items);
    if (snapshot.hasError) return Text("${snapshot.error}");
    return Center(child: CircularProgressIndicator());
  }

  ListView _createListView(List<ShoppingItem> data) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(color: Colors.grey, height: 0.5),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final item = data[index].name;
          return Dismissible(
            key: Key(item),
            background: Container(color: Colors.grey),
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Text('${data[index].name[0].toUpperCase()}${data[index].name.substring(1)}',
                    style: TextStyle(fontSize: 18.0, ))
            ),
            onDismissed: (direction) {
              final ShoppingItem item = data.elementAt(index);
              service.deleteItem(item).then((ok) {
                if (ok) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("${item.name} borrado")));
                  setState(() {
                    data.removeAt(index);
                  });
                }
              });
            },
          );
        });
  }

}