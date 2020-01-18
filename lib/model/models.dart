class ShoppingItem {
  final String id, name;

  ShoppingItem(this.id, this.name);
  ShoppingItem.fromJson(Map json) :this(json['id'], json['name']);
}