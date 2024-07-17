import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/dog_breed.dart';

class LocalStorageService {
  static const String dogBreedsKey = 'dog_breeds';

  Future<void> saveDogBreeds(List<DogBreed> dogBreeds) async {
    final prefs = await SharedPreferences.getInstance();
    final dogBreedsJson = dogBreeds.map((breed) => breed.toJson()).toList();
    prefs.setString(dogBreedsKey, json.encode(dogBreedsJson));
  }

  Future<List<DogBreed>> fetchDogBreeds() async {
    final prefs = await SharedPreferences.getInstance();
    final dogBreedsString = prefs.getString(dogBreedsKey);

    if (dogBreedsString != null) {
      final List<dynamic> dogBreedsJson = json.decode(dogBreedsString);
      return dogBreedsJson.map((json) => DogBreed.fromJson(json)).toList();
    }

    return [];
  }

  Future<void> initializeStorageWithDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(dogBreedsKey)) {
      List<DogBreed> defaultBreeds = [
        DogBreed(name: 'Labrador Retriever', subtitle: 'Friendly and outgoing', icon: '🐕'),
        DogBreed(name: 'German Shepherd', subtitle: 'Confident and courageous', icon: '🐕'),
        DogBreed(name: 'Golden Retriever', subtitle: 'Intelligent and friendly', icon: '🐕'),
        DogBreed(name: 'Bulldog', subtitle: 'Docile and willful', icon: '🐕'),
        DogBreed(name: 'Beagle', subtitle: 'Curious and merry', icon: '🐕'),
      ];
      await saveDogBreeds(defaultBreeds);
    }
  }
}
