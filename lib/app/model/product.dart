
class ProductModel {
    int id;
    String name;
    String description;
    String imageUrl;
    dynamic price;
    int categoryId;
    String categoryName;

    ProductModel({
        required this.id,
        required this.name,
        required this.description,
        required this.imageUrl,
        required this.price,
        required this.categoryId,
        required this.categoryName,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        imageUrl: json["imageURL"] ?? '',
        price: json["price"] ?? 0,
        categoryId: json["categoryID"] ?? 0,
        categoryName: json["categoryName"] ?? '',
    );

}