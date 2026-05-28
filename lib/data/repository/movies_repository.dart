import 'package:desafio_tecnico_wtf/data/models/popular_movies_api_model.dart';
import 'package:desafio_tecnico_wtf/data/services/movies_service.dart';
import 'package:desafio_tecnico_wtf/domain/models/popular_movies.dart';
import 'package:desafio_tecnico_wtf/domain/repository/movie_repository.dart';
import 'package:result_dart/result_dart.dart';

class MoviesRepositoryHttp extends MovieRepository{
 final MoviesService _moviesService;

  MoviesRepositoryHttp({required MoviesService moviesService})
    : _moviesService = moviesService;

  Future<Result<List<PopularMovies>>> getPopularMovies() async {
    PopularMoviesApiModel? externalResponseApiModel = await _moviesService
        .getPopularMovies()
        .getOrNull();

    if (externalResponseApiModel == null) {
      return Failure(
        Exception("Não foi possível listar os filmes mais populares"),
      );
    }

    final results = externalResponseApiModel.results;

    if (results.isEmpty) {
      return Failure(Exception("Não existe filmes populares no momento"));
    }

    List<PopularMovies> popularMoviesList = results
        .map((movie) => movie.toDomain())
        .toList();

    return Success(popularMoviesList);
  }
}
