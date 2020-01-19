import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

import 'package:mandos_app/model/models.dart';
import 'package:mandos_app/globals.dart' as globals;

class ShoppingListService {
  Future<List<ShoppingItem>> get() async{
    final response = await http.get('${globals.baseUrl}/shoppinglist', headers: {'Content-Type': 'application/json' });
    if (response.statusCode == 200) {
      List json = jsonDecode(response.body);
      return json.map((jsonItem) => new ShoppingItem.fromJson(jsonItem)).toList();
    }
    return [];
  }

  Future<bool> deleteItem(ShoppingItem item) async{
    final response = await http.delete('${globals.baseUrl}/shoppinglist/${item.name}', headers: {'Content-Type': 'application/json' });
    return response.statusCode == 200;
  }

  Future<ShoppingItem> newItem(String itemName) async{
    final response = await http.post('${globals.baseUrl}/shoppinglist/item',
      headers: {'Content-Type': 'application/json' },
      body: jsonEncode({ "name": itemName}));
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return new ShoppingItem.fromJson(json);
    }
    return null;
  }
}