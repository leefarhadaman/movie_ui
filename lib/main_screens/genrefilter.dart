import 'package:flutter/material.dart';

class GenreFilter extends StatelessWidget {
  final String selectedGenre;
  final Function(String) onGenreSelected;

  GenreFilter({required this.selectedGenre, required this.onGenreSelected});

  @override
  Widget build(BuildContext context) {
    final genres = ['All', 'Action', 'Drama', 'Sci-Fi', 'Comedy'];

    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(genres[index]),
              selected: selectedGenre == genres[index],
              onSelected: (_) => onGenreSelected(genres[index]),
              backgroundColor: Colors.grey[800],
              selectedColor: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}
