import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/domain/repository/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class AllMoviesViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  final Logger _logger;

  AllMoviesViewModel({
    required MovieRepository movieRepository,
    required Logger logger,
  }) : _movieRepository = movieRepository,
       _logger = logger {
    loadPopularMoviesCommand = Command0(_loadPopularMovies);
  }

  List<Movie> popularMovies = [];

  Movie? get featuredMovie =>  popularMovies.isNotEmpty
      ? popularMovies[0]
      : null;

  late final Command0<List<Movie>> loadPopularMoviesCommand;

  Future<Result<List<Movie>>> _loadPopularMovies() async {
    final result = await _movieRepository.getPopularMovies();

    // Somente para mostrar o uso do Shimmer
    await Future.delayed(Duration(seconds: 2));

    return result.fold(
      (list) {
        popularMovies = list;
        _logger.i('Filmes populares carregados: ${list.length}');
        notifyListeners();
        return Success(list);
      },
      (error) {
        _logger.e('Erro ao carregar filmes populares: $error');
        return Failure(error);
      },
    );
  }

  @override
  void dispose() {
    loadPopularMoviesCommand.dispose();
    super.dispose();
  }
}
