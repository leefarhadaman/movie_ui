import 'package:flutter/material.dart';
import 'package:movie_ui/controllers.dart';
import 'package:movie_ui/main_screens/movie_screen.dart';
import 'package:movie_ui/models/movie_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  String searchQuery = '';
  late AnimationController _animationController;
  late TextEditingController _searchController;

  // Fake data for trending movies (replace with actual data)
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _searchController = TextEditingController();

    // Add debouncing functionality for search query to avoid too many calls
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredMovies = movies.where((movie) =>
        movie.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: searchQuery.isEmpty ? 16.0 : 0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => _onSearchChanged(),
            decoration: InputDecoration(
              hintText: 'Search movies...',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      body: Column(
        children: [
          // Trending Movies Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Trending Movies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendingMovies.length,
              itemBuilder: (context, index) {
                final movie = trendingMovies[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: movie),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Hero(
                      tag: movie.posterUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movie.posterUrl,
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Suggestions or Search Results Section
          Expanded(
            child: searchQuery.isEmpty
                ? Center(child: Text('Start searching for movies', style: TextStyle(fontSize: 18, color: Colors.grey)))
                : filteredMovies.isEmpty
                ? Center(child: Text('No movies found', style: TextStyle(fontSize: 18, color: Colors.grey)))
                : ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];

                // Animation for each movie item
                _animationController.forward();

                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: ListTile(
                    leading: Hero(
                      tag: movie.posterUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movie.posterUrl,
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      movie.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(movie.genre),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return ScaleTransition(
                                scale: Tween(begin: 1.0, end: 1.2).animate(
                                  CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.elasticOut,
                                  ),
                                ),
                                child: Icon(Icons.star, color: Colors.amber, size: 16),
                              );
                            }
                        ),
                        SizedBox(width: 4),
                        Text(movie.rating.toString()),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
