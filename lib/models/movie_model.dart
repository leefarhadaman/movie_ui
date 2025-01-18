// Models
class Movie {
  final String title;
  final String posterUrl;
  final double rating;
  final String genre;
  final String synopsis;
  final List<String> cast;
  final bool isTrending;
  bool isFavorite;

  Movie({
    required this.title,
    required this.posterUrl,
    required this.rating,
    required this.genre,
    required this.synopsis,
    required this.cast,
    this.isTrending = false,
    this.isFavorite = false,
  });
}