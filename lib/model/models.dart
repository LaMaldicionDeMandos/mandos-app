class ShoppingItem {
  final String id, name;

  ShoppingItem(this.id, this.name);
  ShoppingItem.fromJson(Map json) :this(json['id'], json['name']);
}

class Device {
  final String id, name, model, voltage, current, power;
  String state;

  Device(this.id, this.name, this.state, this.model, this.voltage, this.current, this.power);
  Device.fromJson(Map json) : this(json['id'], json['name'], json['state'], json['model'], json['voltage'], json['current'], json['power']);
}