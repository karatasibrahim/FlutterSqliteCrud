class Dish {
  String name = "", description = "";
  double price = 0.0;

  Dish(this.name, this.description, this.price);

  Dish.fromMap(Map map) {
    this.name = map["name"];
    this.description = map["description"];
    this.price = map["price"];
  }
}
