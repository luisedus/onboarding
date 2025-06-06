class Product {
  final int id;
  final String title;
  final String description;
  final num price;
  final int stock;
  final String thumbnail;
  final List<dynamic> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      images: json['images'] ?? [],
    );
  }
}
