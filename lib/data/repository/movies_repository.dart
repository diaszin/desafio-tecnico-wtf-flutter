import 'package:desafio_tecnico_wtf/data/mapper/movie_mapper.dart';
import 'package:desafio_tecnico_wtf/data/models/movie_api_model.dart';
import 'package:desafio_tecnico_wtf/data/models/popular_movies_api_model.dart';
import 'package:desafio_tecnico_wtf/data/services/movies_service.dart';
import 'package:desafio_tecnico_wtf/data/services/movies_service_impl.dart';
import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/domain/entities/popular_movies.dart';
import 'package:desafio_tecnico_wtf/domain/repository/movie_repository.dart';
import 'package:result_dart/result_dart.dart';

class MoviesRepositoryHttp extends MovieRepository {
  final MoviesService _moviesService;

  MoviesRepositoryHttp({required MoviesService moviesService})
    : _moviesService = moviesService;

  @override
  Future<Result<List<Movie>>> getPopularMovies() async {
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

    List<Movie> popularMoviesList = results
        .map((movie) => MovieMapper.modelToDomain(movie))
        .toList();

    return Success(popularMoviesList);
  }

  @override
  Future<Result<Movie>> getMovie(int id) async {
    MovieApiModel? externalResponse = await _moviesService
        .getMovie(id)
        .getOrNull();

    if (externalResponse == null) {
      return Failure(Exception("Não foi possível consultar o filme"));
    }

    Movie movie = MovieMapper.modelToDomain(externalResponse);

    return Success(movie);
  }
}
