import 'dart:convert';

class Cart{
  int productID;
  String name;
  dynamic price;
  String img;
  String des;
  int count;
  //constructor
  Cart(
      {required this.name, required this.price, required this.img, required this.des, required this.count, required this.productID});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'img' : img,
      'des' : des,
      'count' : count,
      'productID': productID
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      productID: map['productID'] ?? 0,
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      img: map['img'] ?? '',
      des: map['des'] ?? '',
      count: map['count'] ?? 1
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Product(productID: $productID, name: $name, price: $price, img: $img, des: $des, count: $count)';

}