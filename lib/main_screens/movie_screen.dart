import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'package:movie_ui/models/movie_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  MovieDetailScreen({required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildRatingSection(),
                    _buildSynopsisSection(),
                    _buildCastSection(),
                    _buildTrailerSection(),
                    _buildExtrasSection(),
                  ],
                ),
              ),
            ],
          ),
          _buildFloatingButtons(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      stretch: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'movie-${widget.movie.title}',
              child: Image.network(
                widget.movie.posterUrl,
                fit: BoxFit.cover,
              ),
            ),
            DecoratedBox(
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
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.0, 0.6, curve: Curves.easeOut),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.movie.title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '2024',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                SizedBox(width: 16),
                Text(
                  '2h 15m',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                SizedBox(width: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[600]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'PG-13',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: FadeTransition(
        opacity: _animationController,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildRatingItem(
              icon: Icons.star,
              color: Colors.amber,
              value: widget.movie.rating.toString(),
              label: 'IMDb',
            ),
            _buildRatingItem(
              icon: Icons.thumb_up,
              color: Colors.green,
              value: '95%',
              label: 'Rotten Tomatoes',
            ),
            _buildRatingItem(
              icon: Icons.people,
              color: Colors.blue,
              value: '4.5',
              label: 'User Score',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingItem({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: color),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildSynopsisSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.2, 0.8, curve: Curves.easeOut),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Synopsis',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.movie.synopsis,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[300],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCastSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.4, 1.0, curve: Curves.easeOut),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cast',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.movie.cast.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'https://sm.ign.com/ign_pk/cover/a/avatar-gen/avatar-generations_rpge.jpg',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.movie.cast[index],
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailerSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: FadeTransition(
        opacity: _animationController,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(widget.movie.posterUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              IconButton(
                icon: Icon(Icons.play_circle_fill, size: 64),
                color: Colors.white,
                onPressed: () {
                  // Implement trailer playback
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExtrasSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: FadeTransition(
        opacity: _animationController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'More Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            _buildDetailItem('Director', 'Christopher Nolan'),
            _buildDetailItem('Writers', 'Jonathan Nolan, Christopher Nolan'),
            _buildDetailItem('Release Date', 'July 21, 2024'),
            _buildDetailItem('Budget', '\$200 million'),
            _buildDetailItem('Box Office', '\$836.8 million'),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: _animationController,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Implement watch now functionality
                },
                icon: Icon(Icons.play_arrow),
                label: Text('Watch Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}