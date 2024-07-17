import 'package:flutter/material.dart';
import 'package:test/Models/dog_breed.dart';

class FavoritesProvider extends ChangeNotifier {
  List<DogBreed> _favorites = [];

  List<DogBreed> get favorites => _favorites;

  void toggleFavorite(DogBreed breed) {
    final index = _favorites.indexWhere((element) => element.name == breed.name);
    if (index != -1) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(breed);
    }
    breed.toggleFavorite(); // Use the toggleFavorite method of DogBreed
    notifyListeners();
  }

  bool isFavorite(DogBreed breed) {
    return _favorites.any((element) => element.name == breed.name);
  }
}
