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
      ),
      body: favoriteBreeds.isEmpty
          ? const Center(child: Text('No favorite breeds yet!'))
          : ListView.builder(
              itemCount: favoriteBreeds.length,
              itemBuilder: (context, index) {
                final breed = favoriteBreeds[index];
                return ListTile(
                  title: Text(breed.name),
                  subtitle: Text(breed.subtitle),
                  leading: Text(breed.icon),
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
