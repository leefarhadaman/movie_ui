import 'package:flutter/material.dart';
import 'package:movie_ui/controllers.dart';

class TrendingMoviesCarousel extends StatefulWidget {
  @override
  _TrendingMoviesCarouselState createState() => _TrendingMoviesCarouselState();
}

class _TrendingMoviesCarouselState extends State<TrendingMoviesCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  final Duration _carouselDuration = Duration(seconds: 5); // Auto slide duration
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  // Start the auto slide to change images
  void _startAutoSlide() {
    Future.delayed(_carouselDuration, _autoSlide);
  }

  // Function to automatically slide the carousel to the next movie
  void _autoSlide() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
    }
    _startAutoSlide(); // Recursively call to keep auto sliding
  }

  @override
  Widget build(BuildContext context) {
    final trendingMovies = movies.where((m) => m.isTrending).toList();

    return Container(
      height: 250, // Height of the carousel
      child: PageView.builder(
        controller: _pageController,
        itemCount: trendingMovies.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final movie = trendingMovies[index];
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              double scale = 1.0;
              double opacity = 1.0;

              // Parallax effect and scaling
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                scale = Curves.easeInOut.transform(1 - value.abs() * 0.3);
                opacity = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              }

              // Apply scaling effect and opacity transition
              return Center(
                child: Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 10,
                            spreadRadius: 3,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              movie.posterUrl,
                              fit: BoxFit.cover,
                            ),
                            // Adding a subtle gradient overlay for a movie card look
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            // Title and other info overlaid on the movie poster
                            Positioned(
                              bottom: 20,
                              left: 10,
                              right: 10,
                              child: Text(
                                movie.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Container(), // Empty child for the AnimatedBuilder
          );
        },
      ),
    );
  }
}
