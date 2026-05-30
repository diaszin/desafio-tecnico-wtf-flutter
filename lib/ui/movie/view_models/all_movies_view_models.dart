import 'package:desafio_tecnico_wtf/domain/entities/popular_movies.dart';
import 'package:desafio_tecnico_wtf/domain/repository/movie_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

class AllMoviesViewModels extends ChangeNotifier{

  final MovieRepository _movieRepository;
  final Logger logger;

  AllMoviesViewModels({required MovieRepository movieRepository, required this.logger}) : _movieRepository = movieRepository;

  List<PopularMovies> popularMovies = [];

  Future<void> loadPopularMovies() async {
    List<PopularMovies> list = await _movieRepository.getPopularMovies().getOrDefault([]);

    popularMovies = list;
    logger.i("Consultando os filmes populares");

    notifyListeners();
  }
}