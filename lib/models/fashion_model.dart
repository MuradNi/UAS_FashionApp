class FashionItem {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String imagePath;
  final String category;
  final List<String> colors;
  final List<String> sizes;
  final String description;
  bool isFavorite;

  FashionItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.colors,
    required this.sizes,
    required this.description,
    this.isFavorite = false,
  });
}