import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:test/Providers/favorites_provider.dart';
import 'package:test/Models/dog_breed.dart';
import '../Services/local_storage_service.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<DogBreed> dogBreeds = [];
  final LocalStorageService _localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    loadDogBreeds();
  }

  Future<void> loadDogBreeds() async {
    List<DogBreed> storedDogBreeds = await _localStorageService.fetchDogBreeds();
    setState(() {
      dogBreeds = storedDogBreeds;
      isLoading = false;
    });
  }

  Future<void> fetchDogBreedsFromAPI() async {
    try {
      final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['message'];
        final fetchedDogBreeds = data.keys.map<DogBreed>((breed) {
          return DogBreed(
            name: breed,
            subtitle: 'Breed Information',
            icon: '🐕',
            isFavorite: false,
          );
        }).toList();

        setState(() {
          dogBreeds = fetchedDogBreeds;
          isLoading = false;
        });

        _localStorageService.saveDogBreeds(fetchedDogBreeds);
      } else {
        throw Exception('Failed to load dog breeds');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Breeds'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dogBreeds.length,
              itemBuilder: (context, index) {
                final breed = dogBreeds[index];
                return ListTile(
                  leading: Text(breed.icon),
                  title: Text(breed.name),
                  subtitle: Text(breed.subtitle),
                  trailing: IconButton(
                    icon: Icon(
                      Provider.of<FavoritesProvider>(context).isFavorite(breed)
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      Provider.of<FavoritesProvider>(context, listen: false).toggleFavorite(breed);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(dogBreed: breed),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
