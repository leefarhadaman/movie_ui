import 'package:movie_ui/models/movie_model.dart';

final movies = [
  // Hollywood Movies
  Movie(
    title: 'Inception',
    posterUrl: 'https://i.scdn.co/image/ab67616d0000b273a883e26f90ab617c91b90e56',
    rating: 4.8,
    genre: 'Sci-Fi',
    synopsis: 'A thief who steals corporate secrets through dream-sharing technology...',
    cast: ['Leonardo DiCaprio', 'Ellen Page', 'Tom Hardy'],
    isTrending: true,
  ),
  Movie(
    title: 'The Dark Knight',
    posterUrl: 'https://www.studioremarkable.com/wp-content/uploads/2012/08/Dark-Knight-Trilogy.jpg',
    rating: 4.9,
    genre: 'Action',
    synopsis: 'Batman sets out to dismantle the remaining criminal organizations that plague Gotham...',
    cast: ['Christian Bale', 'Heath Ledger', 'Aaron Eckhart'],
    isTrending: false,
  ),
  // Bollywood Movies
  Movie(
    title: 'Dangal',
    posterUrl: 'https://screenanarchy.com/assets_c/2016/12/Dangal-poster-large-thumb-860x860-64596.jpg',
    rating: 4.8,
    genre: 'Sports/Drama',
    synopsis: 'The real-life story of the Phogat sisters and their struggle to make it to the top of the wrestling world.',
    cast: ['Aamir Khan', 'Fatima Sana Shaikh', 'Sanya Malhotra'],
    isTrending: true,
  ),
  Movie(
    title: 'Kabhi Khushi Kabhie Gham',
    posterUrl: 'https://m.media-amazon.com/images/I/51FshbJ5IQL._UF1000,1000_QL80_.jpg',
    rating: 4.7,
    genre: 'Drama/Romance',
    synopsis: 'The story of a wealthy family torn apart by issues of love and loyalty.',
    cast: ['Shah Rukh Khan', 'Kajol', 'Amitabh Bachchan'],
    isTrending: false,
  ),
  Movie(
    title: '3 Idiots',
    posterUrl: 'https://i0.wp.com/theobjectivestandard.com/wp-content/uploads/2022/03/3-Idiots-Written-and-Directed-by-Rajkumar-Hirani.jpg?fit=2560%2C1520&ssl=1',
    rating: 4.9,
    genre: 'Comedy/Drama',
    synopsis: 'Three engineering students navigate life, love, and their journey to follow their passion.',
    cast: ['Aamir Khan', 'R. Madhavan', 'Sharman Joshi'],
    isTrending: true,
  ),
  Movie(
    title: 'Zindagi Na Milegi Dobara',
    posterUrl: 'https://i.ytimg.com/vi/uBx4gtxWA7M/maxresdefault.jpg',
    rating: 4.8,
    genre: 'Comedy/Drama',
    synopsis: 'Three friends embark on a road trip across Spain and learn valuable life lessons.',
    cast: ['Hrithik Roshan', 'Farhan Akhtar', 'Abhay Deol'],
    isTrending: false,
  ),
];

final trendingMovies = [
  // Hollywood Trending Movies
  Movie(
    title: 'Avengers: Endgame',
    posterUrl: 'https://i.dawn.com/primary/2019/04/5cc6a29a812e0.jpg',
    rating: 4.9,
    genre: 'Action/Sci-Fi',
    synopsis: 'The Avengers assemble once again to undo the havoc caused by Thanos.',
    cast: ['Robert Downey Jr.', 'Chris Evans', 'Mark Ruffalo'],
    isTrending: true,
  ),
  // Bollywood Trending Movies
  Movie(
    title: 'Lagaan',
    posterUrl: 'https://static.theprint.in/wp-content/uploads/2022/06/Feature-Image-1.png',
    rating: 4.8,
    genre: 'Sports/Drama',
    synopsis: 'A small village in British India takes on the British rulers in a game of cricket to avoid heavy taxes.',
    cast: ['Aamir Khan', 'Gracy Singh', 'Rachel Shelley'],
    isTrending: true,
  ),
];

