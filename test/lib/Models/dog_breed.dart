class DogBreed {
  final String name;
  final String subtitle;
  final String icon;
  bool isFavorite; // Property to indicate if the breed is favorite

  DogBreed({
    required this.name,
    required this.subtitle,
    required this.icon,
    this.isFavorite = false, // Default value is false
  });

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    return DogBreed(
      name: json['name'],
      subtitle: json['subtitle'],
      icon: json['icon'],
      isFavorite: false, // Initialize as not favorite
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subtitle': subtitle,
      'icon': icon,
      'isFavorite': isFavorite, // Include isFavorite in JSON serialization
    };
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
