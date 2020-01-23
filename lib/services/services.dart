import 'dart:convert';

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
    final Map<String, String> headers = {'Content-Type': 'application/json' };
    final body = jsonEncode({'name': itemName});
    final response = await http.post('${globals.baseUrl}/shoppinglist/item',
      headers: headers,
      body: body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return new ShoppingItem.fromJson(json);
    }
    return null;
  }
}

class DevicesService {
  Future<List<Device>> list() async{
    final response = await http.get('${globals.baseUrl}/devices', headers: {'Content-Type': 'application/json' });
    if (response.statusCode == 200) {
      List json = jsonDecode(response.body);
      return json.map((jsonItem) => new Device.fromJson(jsonItem)).toList();
    }
    return [];
  }

  Future<String> changeState(Device device) async {
    final body = jsonEncode({'state': 'toggle'});
    final response = await http.patch('${globals.baseUrl}/devices/${device.id}', headers: {'Content-Type': 'application/json' }, body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return device.state;
  }
}