import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ui/controllers.dart';
import 'package:movie_ui/main_screens/genrefilter.dart';
import 'package:movie_ui/main_screens/movie_screen.dart';
import 'package:movie_ui/main_screens/search_screen.dart';
import 'package:movie_ui/main_screens/trending.dart';
import 'package:movie_ui/models/movie_model.dart';
import 'package:movie_ui/widgets/moviecard.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> with SingleTickerProviderStateMixin {
  String selectedGenre = 'All';
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          _buildGenreAndTrending(),
          _buildMovieGrid(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 200,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Discover Movies',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Image.network(
                'https://t3.ftcdn.net/jpg/09/34/12/72/360_F_934127274_UN2bD654c5u4aMJMaQBcGFQaD2y9VAFE.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget _buildGenreAndTrending() {
    return SliverToBoxAdapter(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GenreFilter(
                selectedGenre: selectedGenre,
                onGenreSelected: (genre) {
                  setState(() {
                    selectedGenre = genre;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Now',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to full trending list
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TrendingMoviesCarousel(),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieGrid() {
    return SliverPadding(
      padding: EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - _controller.value)),
                  child: Opacity(
                    opacity: _controller.value,
                    child: MovieCard(
                      movie: movies[index],
                      onTap: () => _navigateToDetail(context, movies[index]),
                    ),
                  ),
                );
              },
            );
          },
          childCount: movies.length,
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MovieDetailScreen(movie: movie),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var curve = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return Stack(
            children: [
              FadeTransition(
                opacity: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(curve),
                child: child,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(curve),
                child: child,
              ),
            ],
          );
        },
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
  }
}