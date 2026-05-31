import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/domain/repository/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class MovieViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  final Logger _logger;

  MovieViewModel({
    required MovieRepository movieRepository,
    required Logger logger,
  })
      : _movieRepository = movieRepository,
        _logger = logger {
      loadMovie = Command1<Movie, int>(_loadMovie);
  }


  Movie? movie;
  late final Command1<Movie, int> loadMovie;

  Future<Result<Movie>> _loadMovie(int id) async {
    final result = await _movieRepository.getMovie(id);

    return result.fold((data) {
      movie = data;
      _logger.i('Filme carregado: ${movie!.id}');
      notifyListeners();
      return Success(movie!);
    }, (error) {
      _logger.e('Erro ao carregar filmes populares: $error');
      return Failure(error);
    });
  }

  @override
  void dispose() {
    loadMovie.dispose();
    super.dispose();
  }
}
