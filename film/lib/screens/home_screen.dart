import 'package:film/models/movie.dart';
import 'package:film/services/api_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //variabel mewakili api services
  final ApiService _apiService = ApiService();

  List<Movie> _allMovies = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];

  Future<void> _loadMovies() async {
    final List<Map<String, dynamic>> allMoviesdata =
        await _apiService.getAllMovies();
    final List<Map<String, dynamic>> trendingMoviesdata =
        await _apiService.getTrendingMovies();
    final List<Map<String, dynamic>> popularMoviesdata =
        await _apiService.getPopularMovies();
    setState(() {
      _allMovies = allMoviesdata.map((e) => Movie.fromJson(e)).toList();
      _trendingMovies =
          trendingMoviesdata.map((e) => Movie.fromJson(e)).toList();
      _popularMovies = popularMoviesdata.map((e) => Movie.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilem'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMovieList('All Movies', _allMovies),
            _buildMovieList('Trending Movies', _trendingMovies),
            _buildMovieList('Popular Movies', _popularMovies),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieList(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        // Movie List
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final Movie movie = movies[index];
              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        height: 150,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        movie.title.length > 14
                            ? '${movie.title.substring(0, 10)}...'
                            : movie.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Widget _buildMovieList(String title, List<Movie> movies) {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      // Movie List
      SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final Movie movie = movies[index];
            return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    height: 150,
                    width: 100,
                    fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.title.length > 14 ?
                      '${movie.title.substring(0,10)}...'
                      : movie.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },