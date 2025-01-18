import 'package:flutter/material.dart';
import 'package:movie_ui/controllers.dart';
import 'package:movie_ui/main_screens/movie_screen.dart';
import 'package:movie_ui/widgets/moviecard.dart';



class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteMovies = movies.where((m) => m.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: favoriteMovies.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No favorites yet'),
          ],
        ),
      )
          : GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          return MovieCard(
            movie: favoriteMovies[index],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MovieDetailScreen(movie: favoriteMovies[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
