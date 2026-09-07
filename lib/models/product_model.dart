class Product {
  final String id;
  final String title;
  final String titleHindi;
  final String category;
  final double price;
  final double estimatedCost;
  final int stock;
  final String description;
  final String descriptionHindi;
  final List<String> tags;
  final String imageUrl;
  final int completionPercentage;
  final String craftType;

  Product({
    required this.id,
    required this.title,
    required this.titleHindi,
    required this.category,
    required this.price,
    required this.estimatedCost,
    required this.stock,
    required this.description,
    required this.descriptionHindi,
    required this.tags,
    required this.imageUrl,
    this.completionPercentage = 100,
    required this.craftType,
  });

  Product copyWith({
    String? id,
    String? title,
    String? titleHindi,
    String? category,
    double? price,
    double? estimatedCost,
    int? stock,
    String? description,
    String? descriptionHindi,
    List<String>? tags,
    String? imageUrl,
    int? completionPercentage,
    String? craftType,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      titleHindi: titleHindi ?? this.titleHindi,
      category: category ?? this.category,
      price: price ?? this.price,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      stock: stock ?? this.stock,
      description: description ?? this.description,
      descriptionHindi: descriptionHindi ?? this.descriptionHindi,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      craftType: craftType ?? this.craftType,
    );
  }
}
