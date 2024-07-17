import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/Providers/favorites_provider.dart';
import 'package:test/Models/dog_breed.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    List<DogBreed> favoriteBreeds = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Breeds'),
        backgroundColor: Colors.teal,
      ),
      body: favoriteBreeds.isEmpty
          ? const Center(
              child: Text(
                'No favorite breeds yet!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: favoriteBreeds.length,
              itemBuilder: (context, index) {
                final breed = favoriteBreeds[index];
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(breed.icon),
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                    title: Text(
                      breed.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(breed.subtitle),
                    trailing: IconButton(
                      icon: Icon(
                        favoritesProvider.isFavorite(breed) ? Icons.favorite : Icons.favorite_border,
                        color: favoritesProvider.isFavorite(breed) ? Colors.red : null,
                      ),
                      onPressed: () {
                        favoritesProvider.toggleFavorite(breed);
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
                  ),
                );
              },
            ),
    );
  }
}
