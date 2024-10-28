class Product {
  final int id;
  final List<ProductImage> images;
  final String name;
  final String description;
  final String price;
  final int stock;
  final int category_id;

  Product(this.images,
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.stock,
      required this.category_id});
}

class ProductImage {
  final String image;
  final bool is_primary;

  ProductImage({required this.image, required this.is_primary});
}
