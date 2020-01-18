import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mandos_app/model/models.dart';

import 'package:mandos_app/globals.dart' as globals;

class ShoppingListPage extends StatelessWidget {
  Future<List<ShoppingItem>> _fetchItems() async {
    final response = await http.get('${globals.baseUrl}/shoppinglist', headers: {'Content-Type': 'application/json' });
    if (response.statusCode == 200) {
      List json = jsonDecode(response.body);
      return json.map((jsonItem) => new ShoppingItem.fromJson(jsonItem)).toList();
    }
    return [];
  }

  ListView _createListView(List<ShoppingItem> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: const EdgeInsets.all(20),
              child: Text('${data[index].name[0].toUpperCase()}${data[index].name.substring(1)}',
                  style: TextStyle(fontSize: 18.0, ))
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ShoppingItem>>(
      future: _fetchItems(),
      builder: (context, snapshot) {
        if (snapshot.hasData) return _createListView(snapshot.data);
        if (snapshot.hasError) return Text("${snapshot.error}");
        return CircularProgressIndicator();
      },
    );
  }

}