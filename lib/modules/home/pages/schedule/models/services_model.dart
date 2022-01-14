class ServicesModel {
  int id;
  String name;
  double price;
  String description;

  @override
  String toString() {
    return 'ServicesModel{id: $id, name: $name, price: $price, description: $description}';
  }

  ServicesModel(
      {this.id = -1,
      this.name = '',
      this.price = 0,
      this.description = '',
    });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': _formatPriceForInt(price: price),
      'description': description,

    };
  }

  factory ServicesModel.fromMap(Map<String, dynamic> map) {
    return ServicesModel(
      id: map['id'] ?? -1,
      name: map['name'] ?? '',
      price: _formatPriceForDouble(price:map['price'] ?? 0),
      description: map['description'] ?? '',

    );
  }




  static double _formatPriceForDouble({required int price}){
    var value = price/100;
    return double.tryParse(value.toString())??0.0;
  }
  static int _formatPriceForInt({required double price}){
    var value = price * 100;
    return int.tryParse(value.toString())??0;
  }
}
