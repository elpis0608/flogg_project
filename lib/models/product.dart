class Product {
  final String category;
  final String name;
  final int price;
  final String image;

  Product({
    required this.category,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> j) => Product(
        category: j['category'] as String,
        name: j['name'] as String,
        price: (j['price'] as num).toInt(), 
        image: j['image'] as String,
      );
}
